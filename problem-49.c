#include <stdio.h>
#include <stdlib.h>

#include "sieve.h"

int is_permutation(int x, int y) {
    int i;
    char x_digit;
    char y_str[100];
    int y_digits;

    y_digits = snprintf(y_str, 100, "%d", y);

    while(x > 0) {
        x_digit = '0' + (x % 10);

        i = 0;
        while(i < y_digits && y_str[i] != x_digit) {
            i++;
        }

        if(i >= y_digits) {
            return 0;
        } else {
            y_str[i] = '\0';
        }

        x /= 10;
    }

    return 1;
}

int main(int argc, char **argv) {
    const int limit = 10000;
    int x, y, z;
    sieve *s;

    s = sieve_create(limit);

    x = sieve_next_prime(s, 1000);
    while(x < limit && x > 0) {
        y = sieve_next_prime(s, x);
        z = y + y - x;

        while(y < limit && y > 0 && z < limit && z > 0) {

            if(sieve_is_prime(s, z) &&
                    is_permutation(x, y) &&
                    is_permutation(x, z)) {
                printf("Found sequence: %d, %d, %d\n", x, y, z);
            }

            y = sieve_next_prime(s, y);
            z = y + y - x;
        }

        x = sieve_next_prime(s, x);
    }

    sieve_free(s);
    return 0;
}
