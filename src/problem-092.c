#include <stdio.h>
#include <stdlib.h>

#define LIMIT 10000000

int next(int x) {
    int sum = 0;
    int digit;

    while(x > 0) {
        digit = x % 10;
        sum += digit * digit;
        x /= 10;
    }

    return sum;
}

int find_end(char *cache, int n) {
    int end;

    if(cache[n]) {
        return cache[n];
    } else {
        end = find_end(cache, next(n));
        cache[n] = end;
        return end;
    }
}

int main(int argc, char **argv) {
    char *cache;
    int count = 0;
    int n;

    (void) argc;
    (void) argv;

    cache = calloc(LIMIT, sizeof(char));
    cache[1] = 1;
    cache[89] = 89;

    for(n = 1; n < LIMIT; n++) {
        if(find_end(cache, n) == 89) {
            count++;
        }
    }

    printf("%d\n", count);
    free(cache);
    return 0;
}
