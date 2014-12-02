#include <stdio.h>

#include "sieve.h"
#include "math.h"

int next_odd_composite(sieve *s, int n) {
    n += 2;
    while(sieve_is_prime(s, n)) {
        n += 2;
    }
    return n;
}

int search_goldbach(int limit) {
    sieve *s = sieve_create(limit);
    int composite = 9;
    int prime;
    int square;
    int found;

    while(composite < limit) {

        prime = 2;
        found = 0;
        while(prime + 2 <= composite && !found) {
            square = sqrt((composite - prime) / 2);
            if(prime + 2 * square * square == composite) {
                found = 1;
            }

            prime = sieve_next_prime(s, prime);
        }

        if(!found) {
            sieve_free(s);
            return composite;
        }

        composite = next_odd_composite(s, composite);
    }

    sieve_free(s);
    return -1;
}

int main(int argc, char **argv) {
    int composite = search_goldbach(10000);
    printf("%d\n", composite);
    return 0;
}
