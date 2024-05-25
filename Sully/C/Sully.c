#include <stdio.h>
#include <stdlib.h>

#define PREFIX "Sully_"
#define SUFFIX ".c"
#define CC "clang"
#define CCFLAGS "-Wall -Werror -Wextra -DINNERCOMP"
#define s "#include <stdio.h>%c#include <stdlib.h>%c%c#define PREFIX %cSully_%c%c#define SUFFIX %c.c%c%c#define CC %cclang%c%c#define CCFLAGS %c-Wall -Werror -Wextra -DINNERCOMP%c%c#define s %c%s%c%c%c/*%c%cThis program will self replicate%c*/%c%cint compile_and_run(char *source_name, char *exec_name)%c{%c%cchar buf[64];%c%c%csprintf(buf, %c%%s %%s %%s -o %%s%c, CC, CCFLAGS, source_name, exec_name);%c%cif (system(buf))%c%c{%c%c%cprintf(%cCompilation Failed.%%c%c, 10);%c%c%creturn 1;%c%c}%c%csprintf(buf, %c./%%s%c, exec_name);%c%cif (system(buf))%c%c{%c%c%cprintf(%cExecution Failed.%%c%c, 10);%c%c%creturn 1;%c%c}%c%creturn 0;%c}%c%cint main() {%c%cchar source_name[16];%c%cchar exec_name[16];%c%cint X; %c%c%cint i = %d;%c%cX = i;%c#ifdef INNERCOMP%c%cX -= 1;%c#endif%c%cif (X < 0)%c%c%creturn 0;%c%csprintf(exec_name, %c%%s%%d%c, PREFIX, X);%c%csprintf(source_name, %c%%s%%s%c, exec_name, SUFFIX);%c%cFILE *file = fopen(source_name, %cw%c);%c%cif (file)%c%c{%c%c%cfprintf(file, s, 10, 10, 10, 34, 34, 10, 34, 34, 10, 34, 34, 10, 34, 34, 10, 34, s, 34, 10, 10, 10, 9, 10, 10, 10, 10, 10, 9, 10, 10, 9, 34, 34, 10, 9, 10, 9, 10, 9, 9, 34, 34, 10, 9, 9, 10, 9, 10, 9, 34, 34, 10, 9, 10, 9, 10, 9, 9, 34, 34, 10, 9, 9, 10, 9, 10, 9, 10, 10, 10, 10, 9, 10, 9, 10, 9, 10, 10, 9, X, 10, 9, 10, 10, 9, 10, 10, 9, 10, 9, 9, 10, 9, 34, 34, 10, 9, 34, 34, 10, 9, 34, 34, 10, 9, 10, 9, 10, 9, 9, 10, 9, 9, 10, 9, 9, 10, 9, 10, 9, 10, 10);%c%c%cfclose(file);%c%c%creturn compile_and_run(source_name, exec_name);%c%c}%c%creturn 1;%c}%c"

/*
	This program will self replicate
*/

int compile_and_run(char *source_name, char *exec_name)
{
	char buf[64];

	sprintf(buf, "%s %s %s -o %s", CC, CCFLAGS, source_name, exec_name);
	if (system(buf))
	{
		printf("Compilation Failed.%c", 10);
		return 1;
	}
	sprintf(buf, "./%s", exec_name);
	if (system(buf))
	{
		printf("Execution Failed.%c", 10);
		return 1;
	}
	return 0;
}

int main() {
	char source_name[16];
	char exec_name[16];
	int X; 

	int i = 5;
	X = i;
#ifdef INNERCOMP
	X -= 1;
#endif
	if (X < 0)
		return 0;
	sprintf(exec_name, "%s%d", PREFIX, X);
	sprintf(source_name, "%s%s", exec_name, SUFFIX);
	FILE *file = fopen(source_name, "w");
	if (file)
	{
		fprintf(file, s, 10, 10, 10, 34, 34, 10, 34, 34, 10, 34, 34, 10, 34, 34, 10, 34, s, 34, 10, 10, 10, 9, 10, 10, 10, 10, 10, 9, 10, 10, 9, 34, 34, 10, 9, 10, 9, 10, 9, 9, 34, 34, 10, 9, 9, 10, 9, 10, 9, 34, 34, 10, 9, 10, 9, 10, 9, 9, 34, 34, 10, 9, 9, 10, 9, 10, 9, 10, 10, 10, 10, 9, 10, 9, 10, 9, 10, 10, 9, X, 10, 9, 10, 10, 9, 10, 10, 9, 10, 9, 9, 10, 9, 34, 34, 10, 9, 34, 34, 10, 9, 34, 34, 10, 9, 10, 9, 10, 9, 9, 10, 9, 9, 10, 9, 9, 10, 9, 10, 9, 10, 10);
		fclose(file);
		return compile_and_run(source_name, exec_name);
	}
	return 1;
}
