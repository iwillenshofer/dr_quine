#include <stdio.h>

/*
    This is a comment outside the program
*/

void print() {
    char *s = "#include <stdio.h>%c%c/*%c    This is a comment outside the program%c*/%c%cvoid print() {%c    char *s = %c%s%c;%c    printf(s, 10, 10, 10, 10, 10, 10, 10, 34, s, 34, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);%c}%c%cint main() {%c    /*%c        This is a comment inside the program%c    */%c    print();%c    return 0;%c}%c";
    printf(s, 10, 10, 10, 10, 10, 10, 10, 34, s, 34, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
}

int main() {
    /*
        This is a comment inside the program
    */
    print();
    return 0;
}
