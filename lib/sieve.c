#include <stdlib.h>

#include "sieve.h"

void sieve_initialize(sieve *s) {
    int prime, product;

    bit_vector_set(s->bv, 0, 1);
    bit_vector_set(s->bv, 1, 1);

    prime = 2;

    while(prime != 0 && prime < s->limit) {
        for (product = prime + prime; product < s->limit; product += prime) {
            bit_vector_set(s->bv, product, 1);
        }
        prime = sieve_next_prime(s, prime);
    }
}

sieve *sieve_create(int limit) {
    sieve *s = malloc(sizeof(s));

    s->bv = bit_vector_create(limit);
    s->limit = limit;

    sieve_initialize(s);

    return s;
}

void sieve_free(sieve *s) {
    bit_vector_free(s->bv);
    free(s);
}

int sieve_next_prime(sieve *s, int n) {
    n++;

    while(n < s->limit && bit_vector_get(s->bv, n)) {
        n++;
    }

    if(n >= s->limit) {
        return 0;
    } else {
        return n;
    }
}

int sieve_is_prime(sieve *s, int n) {
    return !bit_vector_get(s->bv, n);
}
