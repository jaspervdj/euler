#include <stdlib.h>

#include "bit-vector.h"

bit_vector *bit_vector_create(int size) {
    int num_bytes = (size + 7) / 8;
    bit_vector *bv;

    bv = malloc(sizeof(bit_vector));
    bv->bytes = calloc(num_bytes, 1);
    bv->size = size;

    return bv;
}

void bit_vector_free(bit_vector *bv) {
    free(bv->bytes);
    free(bv);
}

void bit_vector_set(bit_vector *bv, int idx, unsigned char val) {
    int byte = idx / 8;
    if(val) {
        bv->bytes[byte] |= (1 << (idx - byte * 8));
    } else {
        bv->bytes[byte] &= ~(1 << (idx - byte * 8));
    }
}

unsigned char bit_vector_get(bit_vector *bv, int idx) {
    int byte = idx / 8;
    return bv->bytes[byte] & (1 << (idx - byte * 8));
}

int bit_vector_popcount(bit_vector *bv) {
    int num_bytes = (bv->size + 7) / 8;
    int popcount = 0;
    int i;
    for(i = 0; i < num_bytes; i++) {
        /* TODO (jaspervdj): use something portable here? */
        popcount += __builtin_popcount(bv->bytes[i]);
    }
    return popcount;
}
