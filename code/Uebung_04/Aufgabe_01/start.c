#include <unistd.h>
#include <sys/wait.h>
#include <sys/resource.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

// was macht fork()?
// -> systemcall, der verwendet wird um einen neuen prozess zu erstellen, der kindprozess
// -> fork() erstellt eine fast identische kopie des elternprozesses (ID ist anders)
// -> im elternprozess gibt fork() dessen id zurück, im kindprozess 0 und bei fehlern -1
// https://man7.org/linux/man-pages/man2/fork.2.html


// was macht execvp()?
// -> systemcall, der den aktuellen Prozess durch einen neuen ersetzt
// -> ersetzt hier im Code immer nur den Kindprozess durc den als Argument übergebenen
// -> nimmt als Argument den Pfad und die Argumente, daher ist d auch der richtige Aufruf,
//    da wir zum einen den Pfad selbst brauchen und dann die Argumente, die das Programm selbst braucht,
//    also execvp(argv[1], argv + 1)
//    argv + 1 beduetet hier bei, dass man wieder einen Pointer auf ein Array bekommt, aber ab dem ersten hier 
//    https://openbook.rheinwerk-verlag.de/c_von_a_bis_z/012_c_zeiger_007.htm#mjb99637a42fd3decdfe07fe3416407be8
// https://linux.die.net/man/3/execvp

int main(int argc, char **argv) {
  
  if (argc < 2) {
    printf("Verwendung: %s <command> <argument 1> <argument2> ...", argv[0]);
    return 1;
  }

  pid_t pid = fork();

  if (pid == -1) {
    printf("Etwas ist bei fork() schiefgelaufen\n");
    return 1;
  }

  if (pid == 0) { //pid ist nur 0, wenn es sich um den Kindknoten handel

    setpriority(PRIO_PROCESS, 0, 19); // nice wert reicht von -20 bis 19, dabei gilt: je höher die zahl, dest niedriger die priorität
    execvp(argv[1], argv + 1); //Das hier ist der richtige Aufruf, d
    exit(1); // muss bendet werden, weil ich sonst eine forkbomb bauen würde

  } else {

    printf("Der neu gestartete Prozess: %d\n", pid);
    int status; //muss vorher deklariert werden, weil waitpid eine adresse will https://linux.die.net/man/2/waitpid

    wait(&status);

    // Was genau jedes einzelne Macro macht kann man hier nachlesen: https://man7.org/linux/man-pages/man2/wait.2.html

    if (WIFEXITED(status)) {
      printf("child returned code: %d\n", WEXITSTATUS(status));
    } else if (WIFSIGNALED(status)) {
      int signal = WTERMSIG(status);
      printf("child terminated by signal %d: ", signal);
      psignal(signal, NULL);
    }

    return 0;

  }

}