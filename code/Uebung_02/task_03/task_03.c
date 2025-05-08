#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h> // for lstat() & struct stat
#include <pwd.h>
#include <time.h>
#include <unistd.h> // for lstat() -> is needed on some systems as an addition to sys/stat.h
#include <errno.h>

void print_file_info(const char *filename) {
    struct stat file_stat;
    
    // lstat() gives statistic data for given file name -> if it is a symbolic link, it will return information about the link itself and not the referenced file
    if (lstat(filename, &file_stat) == -1) {
        perror("Error");

        return;
    }

    // choose the correct file type
    //st_mode is a bitmask that contains the file type and mode
    // S_IFMT is a bitmask that extracts the file type from st_mode
    // S_IFREG, S_IFDIR, S_IFIFO, S_IFSOCK, S_IFCHR, S_IFBLK, S_IFLNK are macros that define the file types
    switch (file_stat.st_mode & S_IFMT) {
        case S_IFREG:  printf("Filetype: Regular file\n"); break;
        case S_IFDIR:  printf("Filetype: Directory\n"); break;
        case S_IFIFO:  printf("Filetype: FIFO/pipe\n"); break;
        case S_IFSOCK: printf("Filetype: Socket\n"); break;
        case S_IFCHR:  printf("Filetype: Character device\n"); break;
        case S_IFBLK:  printf("Filetype: Block device\n"); break;
        case S_IFLNK:  printf("Filetype: Symbolic link\n"); break;
        default:       printf("Filetype: Unknown\n"); break;
    }

    // get user and group information
    struct passwd *pw = getpwuid(file_stat.st_uid);
    printf("User ID: %d, Group ID: %d\n", file_stat.st_uid, file_stat.st_gid);
    if (pw) {
        printf("User Name: %s\n", pw->pw_name);
    }

    // get access rights in octal format
    printf("Access rights (octal): %o\n", file_stat.st_mode & 0777);

    // timestamp buffer for formatting
    char time_buff[100];
    struct tm *tm_info;

    // get last access time
    tm_info = localtime(&file_stat.st_atime);
    strftime(time_buff, sizeof(time_buff), "%c", tm_info);
    printf("Last access time: %s\n", time_buff);

    // get last inode change time
    tm_info = localtime(&file_stat.st_ctime);
    strftime(time_buff, sizeof(time_buff), "%c", tm_info);
    printf("Last inode change time: %s\n", time_buff);

    // get last modification time
    tm_info = localtime(&file_stat.st_mtime);
    strftime(time_buff, sizeof(time_buff), "%c", tm_info);
    printf("Last modification time: %s\n", time_buff);

    // get creation time if available
    #ifdef __APPLE__
    // on macOS, we can use st_birthtime for creation time, there is no explicit creation time in struct stat
    tm_info = localtime(&file_stat.st_birthtime);
    strftime(time_buff, sizeof(time_buff), "%c", tm_info);
    printf("Creation time: %s\n", time_buff);
    #endif

    printf("\n");
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <file1> <file2> ... <fileN>\n", argv[0]);
        return EXIT_FAILURE;
    }

    for (int i = 1; i < argc; i++) {
        printf("Information for file: %s\n", argv[i]);
        print_file_info(argv[i]);
    }

    return EXIT_SUCCESS;
}
