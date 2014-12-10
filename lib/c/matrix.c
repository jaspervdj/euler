#include <stdlib.h>
#include <stdio.h>

#include "matrix.h"

matrix *matrix_create(int width, int height) {
    matrix *m = malloc(sizeof(matrix));
    m->width  = width;
    m->height = height;
    m->data   = calloc(width * height, sizeof(int));
    return m;
}

void matrix_free(matrix *m) {
    free(m->data);
    free(m);
}

void matrix_parse(matrix *m, const char *filename) {
    int x, y;
    FILE *f;

    f = fopen(filename, "r");
    for (y = 0; y < m->height; y++) {
        for (x = 0; x < m->width; x++) {
            fscanf(f, "%d", &m->data[y * m->width + x]);
            fgetc(f);  /* Skip comma or newline */
        }
    }

    fclose(f);
}

void matrix_print(matrix *m) {
    int x, y;

    for (y = 0; y < m->height; y++) {
        for (x = 0; x < m->width; x++) {
            printf("%d", m->data[y * m->width + x]);
            if (x + 1 == m->width) {
                printf("\n");
            } else {
                printf(",");
            }
        }
    }
}

int matrix_in_bounds(matrix *m, int x, int y) {
    return x >= 0 && y >= 0 && x < m->width && y < m->height;
}

int matrix_get(matrix *m, int x, int y) {
    return m->data[y * m->width + x];
}

void matrix_put(matrix *m, int x, int y, int val) {
    m->data[y * m->width + x] = val;
}
