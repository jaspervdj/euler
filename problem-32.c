#include <stdlib.h>
#include <stdio.h>

typedef int pandigital_set;

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

int is_pandigital_3(int x, int y, int z) {
    pandigital_set set = pandigital_set_create(9);
    return pandigital_set_subtract(&set, x) &&
            pandigital_set_subtract(&set, y) &&
            pandigital_set_subtract(&set, z) &&
            pandigital_set_empty(&set);
}

int main(int argc, char **argv) {
    int limit = 10000;
    int sum = 0;
    int x, y, z;
    int found_pandigital;

    for(z = 1; z < limit; z++) {
        found_pandigital = 0;
        for(x = 1; x * x < z && !found_pandigital; x++) {
            if(z % x == 0) {
                y = z / x;
                if(is_pandigital_3(x, y, z)) {
                    printf("%d x %d = %d\n", x, y, z);
                    sum += z;
                    found_pandigital = 1;
                }
            }
        }
    }

    printf("Sum of products: %d\n", sum);
    return 0;
}
