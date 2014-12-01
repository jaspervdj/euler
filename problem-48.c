#include <stdio.h>

#define TRIM(x) x %= 10000000000

int main(int argc, char** argv) {
    int i, j;
    unsigned long sum;
    unsigned long product;

    sum = 0;
    for(i = 1; i <= 1000; i++) {
        product = i;
        for(j = 2; j <= i; j++) {
            product *= i;
            TRIM(product);
        }
        sum += product;
        TRIM(sum);
    }

    printf("%lu\n", sum);

    return 0;
}
