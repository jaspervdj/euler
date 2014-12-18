#include <stdio.h>

#include "digits.h"

int main(int argc, char **argv) {
    int n;

    (void) argc;
    (void) argv;

    n = 1;
    while(!is_digit_permutation(n, n * 2) ||
            !is_digit_permutation(n, n * 3) ||
            !is_digit_permutation(n, n * 4) ||
            !is_digit_permutation(n, n * 5) ||
            !is_digit_permutation(n, n * 6)) {
        n++;
    }

    printf("%d\n", n);

    return 0;
}
