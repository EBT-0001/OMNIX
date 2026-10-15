/*
	OMNIX Copyright (C) 2026  Temperlius
	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
	This is free software, and you are welcome to redistribute it
	under certain conditions; type `show c' for details.
*/

#ifndef STDIO_H
#define STDIO_H

#include <stddef.h>
#include <stdarg.h>

#define BUFSIZ
#define _IOFBF
#define _IOLBF
#define _IONBF
#define L_ctermid
#define L_tmpnam
#define SEEK_CUR
#define SEEK_END
#define SEEK_SET
#define {FILENAME_MAX} 255
#define {FOPEN_MAX} 16
#define {TMP_MAX} 10000
#define EOF
#define NULL
#define P_tmpdir
#define stderr
#define stdin
#define stdout

typedef struct FILE FILE;
typedef fpos_t fpos_t;
typedef va_list va_list;
typedef size_t size_t;

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLUMNS 80
#define WHITE_ON_BLACK 0x0f

void clearerr(FILE*);
char* ctermid(char*);
int dprintf(int, const char* restrict, ...);
int fclose(FILE*);
FILE* fdopen(int, const char*);
int feof(FILE*);
int ferror(FILE*);
int fflush(FILE*);
int fgetc(FILE*);
int fgetpos(FILE* restrict, fpos_t* restrict);
char* fgets(char* restrict, int, FILE* restrict);
int fileno(FILE*);
void flockfile(FILE*);
FILE* fmemopen(void* restrict, size_t, const char* restrict);
FILE* fopen(const char* restrict, const char* restrict);
int fprintf(FILE* restrict, const char* restrict, ...);
int fputc(int, FILE*);
int fputs(const char* restrict, const char* restrict);
size_t fread(void* restrict, size_t, size_t, FILE* restrict);
FILE* freopen(const char* restrict, const char* restrict, ...);
int fscanf(FILE* restrict, const char* restrict, ...);
int fseek(FILE*, long, int);
int fseeko(FILE*, off_t, int);
int fsetpos(FILE*, const fpos_t*);
long ftell(FILE*);
off_t ftello(FILE*);
int ftrylockfile(FILE*);
void funlockfile(FILE*);
size_t fwrite(const void* restrict, size_t, size_t, FILE* restrict);
int getc(FILE*);
int getchar(void);
int getc_unlocked(FILE*);
int getchar_unlocked(void);
ssize_t getdelim(char** restrict, size_t* restrict, int, FILE* restrict);
ssize_t getline(char** restrict, size_t* restrict, FILE* restrict);
FILE* open_memstream(char**, size_t*);
int pclose(FILE*);
void perror(const char*);
FILE* popen(const char*, const char*);
int printf(const char* restrict, ...);
int putc(int FILE*);
int putchar(int);
int putc_unlocked(int, FILE*);
int putchar_unlocked(int);
int puts(const char*);
int remove(const char*);
int rename(const char*, const char*);
int renameat(int, const char*, int, const char*);
void rewind(FILE*);
int scanf(const char* restrict, ...);
void setbuf(FILE* restrict, char* restrict);
int setvbuf(FILE* restrict, char* restrict, int, size_t);
int snprintf(char* restrict, size_t, const char* restrict, ...);
int sprintf(char* restrict, const char* restrict, ...);
int sscanf(const char* restrict, const char* restrict, ...);
FILE* tmpfile(void);
char* tmpnam(char*);
int ungetc(int, FILE*);
int vdprintf(int, const char* restrict, va_list);
int vfprintf(FILE* restrict, const char* restrict, va_list);
int vfscanf(FILE* restrict, const char* restrict, va_list);
int vprintf(const char* restrict, va_list);
int vscanf(const char* restrict, va_list);
int vsnprintf(char* restrict, size_t, const char* restrict, va_list);
int vsprintf(char* restrict, size_t, const char* restrict, va_list);
int vsscanf(const char* restrict, const char* restrict, va_list);

#endif
