#include <stdio.h>

#include "digits.h"

int num_digits(unsigned int x) {
    int d = 0;

    if(x == 0) {
        return 1;
    }

    while(x != 0) {
        x /= 10;
        d++;
    }

    return d;
}

int is_digit_permutation(int x, int y) {
    int i;
    char x_digit;
    char y_str[100];
    int y_digits;

    y_digits = snprintf(y_str, 100, "%d", y);

    while(x > 0) {
        x_digit = '0' + (x % 10);

        i = 0;
        while(i < y_digits && y_str[i] != x_digit) {
            i++;
        }

        if(i >= y_digits) {
            return 0;
        } else {
            y_str[i] = '\0';
        }

        x /= 10;
    }

    return 1;
}

pandigital_set pandigital_set_create(int num_digits) {
    pandigital_set mask = 0;
    int i;
    for(i = 1; i <= num_digits; i++) {
        mask |= (1 << i);
    }
    return mask;
}

int pandigital_set_subtract(pandigital_set *mask, int n) {
    int digit;

    while(n > 0) {
        digit = n % 10;

        if(*mask & (1 << digit)) {
            *mask &= ~(1 << digit);
        } else {
            return 0;
        }

        n /= 10;
    }

    return 1;
}

int pandigital_set_empty(pandigital_set *mask) {
    return *mask == 0;
}

int is_pandigital(int x) {
    pandigital_set set = pandigital_set_create(num_digits(x));
    return pandigital_set_subtract(&set, x) &&
            pandigital_set_empty(&set);
}

int is_pandigital_3(int x, int y, int z) {
    pandigital_set set = pandigital_set_create(9);
    return pandigital_set_subtract(&set, x) &&
            pandigital_set_subtract(&set, y) &&
            pandigital_set_subtract(&set, z) &&
            pandigital_set_empty(&set);
}
