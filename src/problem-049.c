#include <stdio.h>
#include <stdlib.h>

#include "sieve.h"
#include "digits.h"

int main(int argc, char **argv) {
    const int limit = 10000;
    int x, y, z;
    sieve *s;

    (void) argc;
    (void) argv;

    s = sieve_create(limit);

    x = sieve_next_prime(s, 1000);
    while(x < limit && x > 0) {
        y = sieve_next_prime(s, x);
        z = y + y - x;

        while(y < limit && y > 0 && z < limit && z > 0) {

            if(sieve_is_prime(s, z) &&
                    is_digit_permutation(x, y) &&
                    is_digit_permutation(x, z)) {
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
