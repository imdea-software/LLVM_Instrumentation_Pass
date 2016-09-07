#include <stdio.h>
#include <limits.h>

int intermediate = 0;

int inc(int input) {
    return input + 1;
}

void add(int input) {
    intermediate += input;
}

int main() {
    for(int i = 0; i < 100000000; i++) {
        int result = inc(i);
        if(result % 100000 == 0) {
            add(result);
        }
    }
    printf("%i", intermediate);
    return 0;
}
