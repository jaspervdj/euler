#ifndef MATRIX_H
#define MATRIX_H

typedef struct {
    int width;
    int height;
    int *data;
} matrix;

matrix *matrix_create(int width, int height);
void matrix_free(matrix *m);

void matrix_parse(matrix *m, const char *filename);
void matrix_print(matrix *m);

int matrix_in_bounds(matrix *m, int x, int y);

int matrix_get(matrix *m, int x, int y);
void matrix_put(matrix *m, int x, int y, int val);

#endif
