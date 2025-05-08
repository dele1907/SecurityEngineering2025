#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <pwd.h>
#include <grp.h>
#include <time.h>
#include <errno.h>

void print_permissions_octal(mode_t mode) {
    printf("Zugriffsbits (Oktal): %04o\n", mode & 07777);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Verwendung: %s <Datei1> <Datei2> ...\n", argv[0]);
        return EXIT_FAILURE;
    }

    for (int i = 1; i < argc; i++) {
        struct stat file_stat;

        if (lstat(argv[i], &file_stat) < 0) {
            perror("lstat");
            continue;
        }

        printf("Datei: %s\n", argv[i]);

        printf("Dateityp: ");
        if (S_ISREG(file_stat.st_mode)) {
            printf("Reguläre Datei\n");
        } else if (S_ISDIR(file_stat.st_mode)) {
            printf("Verzeichnis\n");
        } else if (S_ISLNK(file_stat.st_mode)) {
             printf("Symbolischer Link\n");
        } else if (S_ISCHR(file_stat.st_mode)){
            printf("Zeichenorientiertes Gerät\n");
        } else if (S_ISBLK(file_stat.st_mode)){
            printf("Blockorientiertes Gerät\n");
        } else if (S_ISFIFO(file_stat.st_mode)){
            printf("FIFO/Pipe\n");
        } else if(S_ISSOCK(file_stat.st_mode)){
            printf("Socket\n");
        }
         else {
            printf("Unbekannt\n");
        }

        struct passwd *user_info = getpwuid(file_stat.st_uid);
        if (user_info == NULL) {
            perror("getpwuid");
            printf("User-ID: %d, Benutzername: Unbekannt\n", file_stat.st_uid);
        } else {
            printf("User-ID: %d, Benutzername: %s\n", file_stat.st_uid, user_info->pw_name);
        }

        struct group *group_info = getgrgid(file_stat.st_gid);
        if (group_info == NULL) {
            perror("getgrgid");
            printf("Gruppen-ID: %d, Gruppenname: Unbekannt\n", file_stat.st_gid);
        } else {
            printf("Gruppen-ID: %d, Gruppenname: %s\n", file_stat.st_gid, group_info->gr_name);
        }

        print_permissions_octal(file_stat.st_mode);

        char time_buf[256];

        if (strftime(time_buf, sizeof(time_buf), "%a %b %d %H:%M:%S %Y", localtime(&file_stat.st_atime)) == 0) {
             perror("strftime");
             printf("Zeit des letzten Zugriffs: Fehler bei der Formatierung\n");
        } else{
             printf("Zeit des letzten Zugriffs: %s\n", time_buf);
        }
       

        if (strftime(time_buf, sizeof(time_buf), "%a %b %d %H:%M:%S %Y", localtime(&file_stat.st_ctime)) == 0) {
            perror("strftime");
            printf("Zeit der letzten Inode-Änderung: Fehler bei der Formatierung\n");
        } else{
             printf("Zeit der letzten Inode-Änderung: %s\n", time_buf);
        }
       
        if (strftime(time_buf, sizeof(time_buf), "%a %b %d %H:%M:%S %Y", localtime(&file_stat.st_mtime)) == 0) {
            perror("strftime");
            printf("Zeit der letzten Dateiänderung: Fehler bei der Formatierung\n");
        } else {
             printf("Zeit der letzten Dateiänderung: %s\n", time_buf);
        }

        printf("\n");
    }

    return EXIT_SUCCESS;
}
/*
/dev/random: char
/bin/sh: link
/usr/bin/tar: regular
/var/spool: dir
/etc/services regular
/tmp/.X11-unix/X0
*/