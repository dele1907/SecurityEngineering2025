/*
  P-Operation: "passeren": Prozess versucht, zugang zu einem kritischen Bereucht (shared Memory zu bekommen),
                           Wenn Wert des Semaphors > 0 ist, wird er um 1 verkleinert und darf fortfahren.
                           Wenn Wer des Semaphors 0 ist, wird er blockiert, bis er wieder > 0 wird

  V-Operation: "vrijgeven": Gibt Zugriff wieder frei, signalisiert, dass ein Prozess fertig ist
                            Semaphor wird um 1 erhöht
                            Falls Prozesse warten (wegen früherer P-Operation), kann einer weitermachen 


  https://de.wikipedia.org/wiki/Semaphor_(Informatik)#L%C3%B6sung_von_Dijkstra
  https://www.youtube.com/watch?v=ukM_zzrIeXs

*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <sys/wait.h>
#include <time.h>
#include <string.h>


#define N_DATA 2000000
#define N_SHARED 2000

// op steht hier für die operation (-1: P, +1: V, 0: auf Sempahoren warten)
void sem_op(int semid, int semnum, int op) {
    struct sembuf sb = {semnum, op, 0};
    if (semop(semid, &sb, 1) == -1) {
        perror("semop");
        exit(1);
    }
}

int main() {
    key_t key = ftok(".", 'X');
    if (key == -1) {
        perror("ftok");
        exit(1);
    }

    int shmid = shmget(key, N_SHARED * sizeof(int), IPC_CREAT | 0666);
    if (shmid == -1) {
        perror("shmget");
        exit(1);
    }

    int *shared_buffer = (int *)shmat(shmid, NULL, 0);
    if (shared_buffer == (void *)-1) {
        perror("shmat");
        exit(1);
    }

    int semid = semget(key, 2, IPC_CREAT | 0666);
    if (semid == -1) {
        perror("semget");
        exit(1);
    }

    semctl(semid, 0, SETVAL, 1);
    semctl(semid, 1, SETVAL, 0);

    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(1);
    }

    if (pid == 0) {
        for (int i = 0; i < N_DATA; i += N_SHARED) {
            sem_op(semid, 1, -1);

            int count = (N_DATA - i < N_SHARED) ? N_DATA - i : N_SHARED;
            long long sum = 0;
            for (int j = 0; j < count; j++) {
                sum += shared_buffer[j]; 
            }

            printf("P2: Summe von Block %d: %lld\n", i / N_SHARED, sum);
            sem_op(semid, 0, 1);
        }

        shmdt(shared_buffer);
        exit(0);

    } else {
        // Elternprozess (Erzeuger / P1)

        srand48(time(NULL));
        int *data = malloc(N_DATA * sizeof(int));
        for (int i = 0; i < N_DATA; i++) {
            data[i] = lrand48() % 100;
        }

        for (int i = 0; i < N_DATA; i += N_SHARED) {
            sem_op(semid, 0, -1);

            int count = (N_DATA - i < N_SHARED) ? N_DATA - i : N_SHARED;
            memcpy(shared_buffer, &data[i], count * sizeof(int));

            sem_op(semid, 1, 1);
        }

        wait(NULL);
        shmdt(shared_buffer);
        shmctl(shmid, IPC_RMID, NULL);
        semctl(semid, 0, IPC_RMID);
        free(data);
    }

    return 0;
}
