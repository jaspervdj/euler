#include <stdio.h>

#include "sieve.h"

int main(int argc, char **argv) {
    /* Around 125 Megabyte in a bit vector. */
    const int limit = 1000 * 1000 * 1000;

    int num_primes = 0;
    int num_total = 1;
    int iteration = 1;
    int side = 3;
    int base = 1;
    int found = 0;
    sieve *s;

    s = sieve_create(limit);

    while(side * side < limit && !found) {

        if(sieve_is_prime(s, base + side - 1)) {
            num_primes++;
        }

        if(sieve_is_prime(s, base + 2 * (side - 1))) {
            num_primes++;
        }

        if(sieve_is_prime(s, base + 3 * (side - 1))) {
            num_primes++;
        }

        num_total += 4;

        if (num_primes * 10 < num_total) {
            printf("%d\n", side);
            found = 1;
        }

        iteration++;
        base = side * side;
        side = iteration * 2 + 1;
    }

    sieve_free(s);

    return 0;
}
