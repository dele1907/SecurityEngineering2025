#include <stdio.h>
#include <time.h>

int main() {
    time_t current_time;

    // do not pass pointer as argument, b.c. we do not want to save the time
    // we do only want the return value of time()
    current_time = time(NULL);

    // time() returns (time_t)-1 on error
    if (current_time == ((time_t)-1)) {
        fprintf(stderr, "Error getting the current time.\n");
        return 1;
    }

    printf("Variante a) (ctime): %s", ctime(&current_time));

    // local_time pointer on tm who contains foramtted time
    struct tm * local_time;
    // buffer array to store the formatted time
    char formatted_time[100];

    local_time = localtime(&current_time);
    if (local_time == NULL) {
        fprintf(stderr, "Error converting to local time.\n");
        return 1;
    }
    if (strftime(formatted_time, sizeof(formatted_time), "%a %b %d %H:%M:%S %Z %Y", local_time) == 0) {
        fprintf(stderr, "Error formatting the time.\n");
        return 1;
    }
    printf("Variante b) (strftime): %s\n", formatted_time);

    return 0;
}