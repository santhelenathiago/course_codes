#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef struct ThreadData {
    int arg;
    int sum;
} thread_data_t;

// Função usImprime resultados na telaada na correção do exercício -- definida em helper.c
void imprimir_resultados(int n, int** results);

// Função escrita por um engenheiro
void compute(int arg, int* sum) {
    if (arg < 2) {
        *sum += arg;
    } else {
        compute(arg - 1, sum);
        compute(arg - 2, sum);
    }
}

// Função wrapper que pode ser usada com pthread_create() para criar uma 
// thread que retorna o resultado de compute(arg
void* compute_thread(void* arg) {
    thread_data_t* data = malloc(sizeof(thread_data_t));
    data = (thread_data_t*) arg;
    compute(data->arg, &data->sum);
    free(data);
    return NULL;
}


int main(int argc, char** argv) {
    // Temos n_threads?
    if (argc < 2) {
        printf("Uso: %s n_threads x1 x2 ... xn\n", argv[0]);
        return 1;
    }
    // n_threads > 0 e foi dado um x para cada thread?
    int n_threads = atoi(argv[1]);
    if (!n_threads || argc < 2+n_threads) {
        printf("Uso: %s n_threads x1 x2 ... xn\n", argv[0]);
        return 1;
    }

    thread_data_t* args = (thread_data_t*) malloc(n_threads*sizeof(thread_data_t));
    int* results[n_threads];
    for (int i = 0; i < n_threads; ++i) {
        results[i] = (int*) malloc(sizeof(int));
    }
    pthread_t threads[n_threads];
    //Cria threads repassando argv[] correspondente
    for (int i = 0; i < n_threads; ++i)  {
        args[i].arg = atoi(argv[2+i]);
        args[i].sum = 0;
        pthread_create(&threads[i], NULL, compute_thread, &args[i]);
    }
    // Faz join em todas as threads e salva resultados
    for (int i = 0; i < n_threads; ++i) {
        pthread_join(threads[i], NULL);
        *results[i] = args[i].sum; 
    }

    // Imprime resultados na tela
    // Importante: deve ser chamada para que a correção funcione
    imprimir_resultados(n_threads, results);

    // Faz o free para os resultados criados nas threads
    for (int i = 0; i < n_threads; ++i) {
        free(results[i]);
    }
    
    return 0;
}
