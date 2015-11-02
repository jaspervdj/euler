#include <stdio.h>
#include <math.h>

#define LIMIT 50

#define SQUARE(x) ((x) * (x))
#define ABS(x) ((x) >= 0 ? (x) : -(x))

int is_right_triangle(int x1, int y1, int x2, int y2) {
    int a_squared;
    int b_squared;
    int c_squared;

    a_squared = SQUARE(x1) + SQUARE(y1);
    b_squared = SQUARE(ABS(x2 - x1)) + SQUARE(ABS(y2 - y1));
    c_squared = SQUARE(x2) + SQUARE(y2);

    if(a_squared == 0 || b_squared == 0 || c_squared == 0) {
        return 0;
    } else if(a_squared >= b_squared && a_squared >= c_squared) {
        return a_squared == b_squared + c_squared;
    } else if(b_squared >= a_squared && b_squared >= c_squared) {
        return b_squared == a_squared + c_squared;
    } else if(c_squared >= a_squared && c_squared >= b_squared) {
        return c_squared == a_squared + b_squared;
    } else {
        return 0;
    }
}

int main(int argc, char **argv) {
    int x1, y1;
    int x2, y2;
    int total = 0;

    (void) argc;
    (void) argv;


    for(x1 = 0; x1 <= LIMIT; x1++) {
        for(y1 = 0; y1 <= LIMIT; y1++) {
            for(x2 = x1; x2 <= LIMIT; x2++) {
                for(y2 = (x1 == x2 ? y1 : 0); y2 <= LIMIT; y2++) {
                    if(is_right_triangle(x1, y1, x2, y2)) {
                        total += 1;
                    }
                }
            }
        }
    }

    printf("%d\n", total);
    return 0;
}
