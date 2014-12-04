#ifndef DIGITS_H
#define DIGITS_H

int num_digits(unsigned int x);

int is_digit_permutation(int x, int y);

typedef int pandigital_set;

pandigital_set pandigital_set_create(int num_digits);

int pandigital_set_subtract(pandigital_set *mask, int n);

int pandigital_set_empty(pandigital_set *mask);
int is_pandigital(int x);
int is_pandigital_3(int x, int y, int z);

#endif
