#include <stdio.h>

unsigned int num_bits(unsigned int n) {
    unsigned int b = 0;
    while (n != 0) {
        n >>= 1;
        b++;
    }
    return b;
}

int is_binary_palindrome(unsigned int n) {
    unsigned int b;
    unsigned int num = num_bits(n);
    for (b = 0; b < num / 2; b++) {
        if (((n >> b) & 1) != (n >> (num - b - 1) & 1)) return 0;
    }

    return 1;
}

unsigned int decimal_power(unsigned int n) {
    unsigned int p = 1;
    while (n > p * 10) p *= 10;
    return p;
}

int is_decimal_palindrome(unsigned int n) {
    unsigned int left = decimal_power(n);
    unsigned int right = 1;

    while (left > right) {
        if ((n / left) % 10 != (n / right) % 10) return 0;
        left /= 10;
        right *= 10;
    }

    return 1;
}

int main(int argc, char **argv) {
    unsigned int n;
    unsigned long int s = 0;
    for (n = 0; n < 1000 * 1000; n++) {
        if (is_binary_palindrome(n) && is_decimal_palindrome(n)) s += n;
    }
    printf("%lu\n", s);
    return 0;
}
