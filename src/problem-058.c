#include <stdio.h>

#include "sieve.h"

int main(int argc, char **argv) {
    int num_primes = 0;
    int num_total = 1;
    int iteration = 1;
    int side = 3;
    int base = 1;
    int found = 0;

    (void) argc;
    (void) argv;

    while(!found) {

        if(is_prime(base + side - 1)) {
            num_primes++;
        }

        if(is_prime(base + 2 * (side - 1))) {
            num_primes++;
        }

        if(is_prime(base + 3 * (side - 1))) {
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

    return 0;
}
