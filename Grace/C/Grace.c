#include <stdio.h>
#define FILENAME "Grace_kid.c"
#define xxxxxxxx "#include <stdio.h>%c#define FILENAME %cGrace_kid.c%c%c#define xxxxxxxx %c%s%c%c#define FT(x) int main() { FILE *file = fopen(FILENAME, %cw%c); if (file) { fprintf(file, x, 10, 34, 34, 10, 34, x, 34, 10, 34, 34, 10, 10, 10, 10, 10); fclose(file); } ; return 0; }%c/*%c    This program will save its source code into a file%c*/%cFT(xxxxxxxx)%c"
#define FT(x) int main() { FILE *file = fopen(FILENAME, "w"); if (file) { fprintf(file, x, 10, 34, 34, 10, 34, x, 34, 10, 34, 34, 10, 10, 10, 10, 10); fclose(file); } ; return 0; }
/*
    This program will save its source code into a file
*/
FT(xxxxxxxx)
