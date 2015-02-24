#include <stdio.h>
#include <math.h>

int num_cuboids(int m, int n) {
    int solutions = 0;
    int x = n <= m ? (n - 1) : m;
    int y = n - x;

    while (x >= y) {
        solutions++;
        x--;
        y++;
    }

    return solutions;
}

int num_integer_shortes_routes(int m, int n) {
    int square = m * m + n * n;
    int root = (int) sqrt((double) square);

    if(root * root == square) {
        return num_cuboids(m, n);
    } else {
        return 0;
    }
}

int main(int argc, char **argv) {
    int goal = 1000000;
    int solutions = 0;
    int m = 0;
    int n = 1;

    (void) argc;
    (void) argv;

    while (solutions < goal) {
        m++;

        for(n = 2; n <= 2 * m; n++) {
            solutions += num_integer_shortes_routes(m, n);
        }
    }

    printf("m = %d\n", m);
    return 0;
}
