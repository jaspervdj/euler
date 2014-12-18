#include <stdio.h>

#include "matrix.h"

int main(int argc, char **argv) {
    int x, y, val, current, neighbour, improved;
    matrix *m, *s;

    (void) argc;
    (void) argv;

    m = matrix_create(80, 80);
    s = matrix_create(80, 80);
    matrix_parse(m, argv[1]);

    matrix_put(s, 0, 0, matrix_get(m, 0, 0));

    improved = 1;
    while (improved) {
        printf("Starting iteration...\n");
        improved = 0;

        for (y = 0; y < s->height; y++) {
            for (x = 0; x < s->height; x++) {
                val = matrix_get(m, x, y);

                if (matrix_in_bounds(s, x - 1, y)) {
                    neighbour = matrix_get(s, x - 1, y);
                    current = matrix_get(s, x, y);
                    if ((matrix_get(s, x, y) == 0 ||
                            neighbour + val < current) &&
                            neighbour != 0) {
                        matrix_put(s, x, y, neighbour + val);
                        improved = 1;
                    }
                }

                if (matrix_in_bounds(s, x, y - 1)) {
                    neighbour = matrix_get(s, x, y - 1);
                    current = matrix_get(s, x, y);
                    if ((matrix_get(s, x, y) == 0 ||
                            neighbour + val < current) &&
                            neighbour != 0) {
                        matrix_put(s, x, y, neighbour + val);
                        improved = 1;
                    }
                }

                if (matrix_in_bounds(s, x, y + 1)) {
                    neighbour = matrix_get(s, x, y + 1);
                    current = matrix_get(s, x, y);
                    if ((matrix_get(s, x, y) == 0 ||
                            neighbour + val < current) &&
                            neighbour != 0) {
                        matrix_put(s, x, y, neighbour + val);
                        improved = 1;
                    }
                }

                if (matrix_in_bounds(s, x + 1, y)) {
                    neighbour = matrix_get(s, x + 1, y);
                    current = matrix_get(s, x, y);
                    if ((matrix_get(s, x, y) == 0 ||
                            neighbour + val < current) &&
                            neighbour != 0) {
                        matrix_put(s, x, y, neighbour + val);
                        improved = 1;
                    }
                }
            }
        }
    }

    printf("%d\n", matrix_get(s, s->width - 1, s->height - 1));

    matrix_free(m);
    matrix_free(s);
    return 0;
}
