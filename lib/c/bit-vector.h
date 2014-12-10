#ifndef BIT_VECTOR_H
#define BIT_VECTOR_H

typedef struct {
    unsigned char *bytes;
    int size;
} bit_vector;

bit_vector *bit_vector_create(int size);
void bit_vector_free(bit_vector *bv);
void bit_vector_set(bit_vector *bv, int idx, unsigned char val);
unsigned char bit_vector_get(bit_vector *bv, int idx);

#endif
