#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define MAX_NUM 20

double media(int* V, int tam);
double desvio(int* V, int tam);

int main(int argc, char** argv) {
    if (argc == 2) {
        int tam = atoi(argv[1]);

        srand(time(NULL));

        int* vector = (int*) malloc(tam * sizeof(int));
        for (int i = 0; i < tam; i++) {
            vector[i] = rand() % MAX_NUM;
        }

        double mid = media(vector, tam);
        double desv = desvio(vector, tam);

        printf("%.2f\n", mid);
        printf("%.2f\n", desv);

        for (int i = 0; i < tam; i++) {
            printf("%d, ", vector[i]);
        }
        printf("\n");

        free(vector);
    } else {
        int* vector = (int*) malloc(sizeof(int));
        int len = 0;
        int input;
        int result = 0;

        result = scanf("%d", &input);
        while(result != EOF) {
            len++;
            vector = realloc(vector, len*sizeof(int));
            vector[len-1] = input;
            result = scanf("%d", &input);
        }

        printf("Media = %.4f", media(vector, len));
        printf("\nDesvio padrao = %.4f", desvio(vector, len));
    }
    return 0;
}

double media(int* V, int tam) {
    int acum = 0;
    for (int i = 0; i < tam; i++) {
        acum += V[i];
    }

    return ((double)acum)/tam;
}

double desvio(int* V, int tam) {
    double mid = media(V, tam);
    double var = 0;

    for (int i = 0; i < tam; i += 1) {
        var += pow((V[i] - mid), 2);
    }

    return sqrt(var/tam);
}
