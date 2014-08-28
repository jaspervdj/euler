#include <stdio.h>

int is_abundant_number(int n) {
    int x;
    int s = 0;

    for (x = 1; x * x <= n; x++) {
        if (n % x == 0) {
            s += x;
            if (x != 1 && x * x != n) s += n / x;
        }
    }

    return s > n;
}

int main(int argc, char **argv) {
    int n;
    int x;
    long int s = 0;

    for (n = 1; n < 28123; n++) {

        x = 1;
        while (x <= n / 2 &&
                !(is_abundant_number(x) && is_abundant_number(n - x))) {
            x++;
        }

        if (x <= n / 2) {
            printf("%d is a sum two abundant numbers: %d and %d\n",
                    n, x, n - x);
        } else {
            s += (long) n;
        }
    }

    printf("Sum of numbers which are not a sum of two abundant numbers: %ld\n",
            s);

    return 0;
}
