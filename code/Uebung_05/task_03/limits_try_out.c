#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <string.h>

const char *orange = "\033[38;5;208m";
const char *red = "\033[31m";
const char *reset = "\033[0m"; 

// Signal-Handler
void handle_signal(int sig) {
    switch(sig) {
        case SIGXCPU:
            printf("%s⚠️  SIGXCPU empfangen: CPU-Zeitlimit überschritten%s\n", orange, reset);
            break;
        case SIGSEGV:
            printf("%s⚠️  SIGSEGV empfangen: Stacklimit (z.B. Rekursion) überschritten%s\n", orange, reset);
            break;
        case SIGXFSZ:
            printf("%s⚠️  SIGXFSZ empfangen: Dateigrößenlimit überschritten%s\n", orange, reset);
            break;
        default:
            printf("%s⚠️  Signal %d empfangen%s\n", orange, sig, reset);
    }
    exit(EXIT_FAILURE);
}

// Funktion zum Stacküberlauf
void overflow_stack() {
    char big[8192]; // große Variable auf dem Stack
    memset(big, 0, sizeof(big));
    overflow_stack(); // endlose Rekursion
}

// Funktion zum CPU-Verbrauch
void use_cpu() {
    while (1) {} // endlose Schleife
}

// Funktion zum Dateischreiben
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
    // Signalhandler installieren
    signal(SIGXCPU, handle_signal);
    signal(SIGSEGV, handle_signal);
    signal(SIGXFSZ, handle_signal);

    printf("PID = %d\n", getpid());

    if (argc != 2) {
        fprintf(stderr, "%sUsage: %s cpu|stack|file%s\n", red, argv[0], reset);
        return EXIT_FAILURE;
    }

    if (strcmp(argv[1], "cpu") == 0) {
        use_cpu();
    } else if (strcmp(argv[1], "stack") == 0) {
        overflow_stack();
    } else if (strcmp(argv[1], "file") == 0) {
        write_big_file();
    } else {
        fprintf(stderr, "%sUnbekannter Modus: %s%s\n", red, argv[1], reset);
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

//HINT
/**
 * stack overflow: Wenn der Stack überläuft, wird ein SIGSEGV-Signal ausgelöst, das den Signal-Handler aufruft und eine Fehlermeldung ausgibt.
 * ABER bei Stacküberlauf wird das Programm in der Regel sofort beendet, ohne dass der Signal-Handler aufgerufen wird. Das liegt daran, dass der Stack-Überlauf zu einem ungültigen Speicherzugriff führt, der das Programm zum Absturz bringt.
 * Daher ist der Stack-Overflow nicht sicher zu behandeln, da er in der Regel zu einem sofortigen Programmabsturz führt. Der Signal-Handler wird in diesem Fall nicht aufgerufen, weil das Programm bereits in einem ungültigen Zustand ist.
 * 
 * */ 
