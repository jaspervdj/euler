#include <stdio.h>

#include "sieve.h"
#include "digits.h"

int main(int argc, char **argv) {
    const int limit = 1 * 1000 * 1000 * 1000;
    sieve *s = sieve_create(limit);
    int p;

    p = sieve_previous_prime(s, limit);
    while(p > 0 && !is_pandigital(p)) {
        p = sieve_previous_prime(s, p);
    }

    printf("%d\n", p);

    sieve_free(s);
    return 0;
}
