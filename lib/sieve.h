#ifndef SIEVE_H
#define SIEVE_H

#include "bit-vector.h"

typedef struct {
    bit_vector *bv;
    int limit;
} sieve;

sieve *sieve_create(int limit);
void sieve_free(sieve *s);

int sieve_next_prime(sieve *s, int n);
int sieve_is_prime(sieve *s, int n);

#endif
