#include <stdio.h>
#include <math.h>

#include "sieve.h"
#include "bit-vector.h"

int main(int argc, char **argv) {
    const int limit = 50 * 1000 * 1000;
    int sieve_limit;
    sieve *s;
    bit_vector *solutions;
    int x, y, z, sum;

    (void) argc;
    (void) argv;

    sieve_limit = (int) ceil(sqrt((double) limit));
    s = sieve_create(sieve_limit);
    solutions = bit_vector_create(limit);

    x = 2;
    while (x > 0 && x * x < limit) {
        y = 2;
        while (y > 0 && x * x + y * y * y < limit) {
            z = 2;
            sum = x * x + y * y * y + z * z * z * z;
            while (z > 0 && sum < limit) {
                if (sum < limit) {
                    bit_vector_set(solutions, sum, 1);
                }
                z = sieve_next_prime(s, z);
                sum = x * x + y * y * y + z * z * z * z;
            }
            y = sieve_next_prime(s, y);
        }
        x = sieve_next_prime(s, x);
    }

    printf("solutions = %d\n", bit_vector_popcount(solutions));

    sieve_free(s);
    bit_vector_free(solutions);
    return 0;
}
