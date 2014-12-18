#include <stdlib.h>
#include <stdio.h>

#include "digits.h"

int main(int argc, char **argv) {
    int limit = 10000;
    int sum = 0;
    int x, y, z;
    int found_pandigital;

    (void) argc;
    (void) argv;

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
