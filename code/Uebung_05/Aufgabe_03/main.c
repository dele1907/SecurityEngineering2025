#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <string.h>

void handle_signal(int sig) {
    switch (sig) {
        case SIGXCPU:
            printf("%d SIGXCPU empfangen, cpu limit überschritten\n", sig);
            break;
        case SIGSEGV:
            printf("%d SIGSEGV empfangen, illegaler Speicherzugriff\n", sig);
            break;
        case SIGXFSZ:
            printf("%d SIGXFSZ empfangen, Datei zu gross\n", sig);
            break;
        default:
            printf("%d Signal empfangen\n", sig);
            break;
    }

    exit(EXIT_FAILURE);
}

void overflow_stack() {
    char big[8192];
    memset(big, 0, sizeof(big));
    overflow_stack(); 
}

void use_cpu() {
    while (1) {} 
}

void write_big_file() {
    FILE *file = fopen("output.txt", "w");
    if (!file) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }
    for (int i = 0; i < 100000; i++) {
        fprintf(file, "Dies ist eine Zeile mit Text...\n");
    }
    fclose(file);
}

int main(int argc, char *argv[]) {
    signal(SIGXCPU, handle_signal);
    signal(SIGSEGV, handle_signal);
    signal(SIGXFSZ, handle_signal);

    printf("PID = %d\n", getpid());

    if (argc != 2) {
        fprintf(stderr, "Usage: %s cpu|stack|file\n",argv[0]);
        return EXIT_FAILURE;
    }

    if (strcmp(argv[1], "cpu") == 0) {
        use_cpu();
    } else if (strcmp(argv[1], "stack") == 0) {
        overflow_stack();
    } else if (strcmp(argv[1], "file") == 0) {
        write_big_file();
    } else {
        printf("Unbekannter Modus\n");
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}