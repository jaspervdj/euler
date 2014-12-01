#include <stdio.h>

#include "bit-vector.h"
#include "primes.h"

int main(int argc, char **argv) {
    const int limit = 1000 * 1000;
    sieve *s = sieve_create(limit);

    int first = 2, last = 2;
    int sum = 2;
    int num_primes = 1;
    int max_sum = 2;
    int max_num_primes = 1;

    while(first < limit && first != 0) {

        sum = first;
        last = first;
        num_primes = 1;
        while(sum < limit && last < limit && last != 0) {
            last = sieve_next_prime(s, last);
            sum += last;
            num_primes++;

            if(num_primes > max_num_primes &&
                    sum < limit &&
                    sieve_is_prime(s, sum)) {
                max_sum = sum;
                max_num_primes = num_primes;
            }
        }

        first = sieve_next_prime(s, first);
    }

    printf("%d (sum of %d primes)\n", max_sum, max_num_primes);

    sieve_free(s);
    return 0;
}
