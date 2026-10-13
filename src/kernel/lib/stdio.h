/*
	OMNIX Copyright (C) 2026  Temperlius
	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
	This is free software, and you are welcome to redistribute it
	under certain conditions; type `show c' for details.
*/

#ifndef STDIO_H
#define STDIO_H

#define BUFSIZ
#define _IOFBF
#define _IOLBF
#define _IONBF
#define L_ctermid
#define L_tmpnam
#define SEEK_CUR
#define SEEK_END
#define SEEK_SET
#define FILENAME_MAX 255
#define FOPEN_MAX 16
#define EOF
#define NULL
#define P_tmpdir
#define stderr
#define stdin
#define stdout

typedef struct {

}FILE;
typedef fpos_t;
typedef va_list;
typedef size_t;

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLUMNS 80
#define WHITE_ON_BLACK 0x0f

void clearerr(FILE*);
char* ctermid(char*);
int fclose(FILE*);
FILE* fdopen(int, const char*);
int feof(FILE*);
int ferror(FILE*);
int fflush(FILE*);
int fgetc(FILE*);
int fgetpos(FILE* restrict, fpos_t* restrict);
int fileno(FILE*);

int printf();

#endig
