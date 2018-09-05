#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <pthread.h>

//                 (main)      
//                    |
//    +----------+----+------------+
//    |          |                 |   
// worker_1   worker_2   ....   worker_n


// ~~~ argumentos (argc, argv) ~~~
// ./program n_threads

// ~~~ printfs  ~~~
// pai (ao criar filho): "Contador: %d\n"
// pai (ao criar filho): "Esperado: %d\n"

// Obs:
// - pai deve criar n_threds (argv[1]) worker threads
// - cada thread deve incrementar contador_global n_threads*1000
// - pai deve esperar pelas worker threads  antes de imprimir!

int contador_global = 0;

void* thread_work(void* n) {
    int repeats = *((int*) n);
    for (int i = 0; i < repeats; i++)
        contador_global += 1;

    pthread_exit(0);
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("n_threads é obrigatório!\n");
        printf("Uso: %s n_threads\n", argv[0]);
        return 1;
    }

    int n_threads = atoi(argv[1]);
    pthread_t* workers = (pthread_t*) malloc(sizeof(pthread_t) * n_threads);

    int* arg = (int*) malloc(sizeof(int));
    *arg = n_threads;
    for (int i = 0; i < n_threads; i++) {
        workers[i] = i;

        pthread_create(&workers[i],
                       NULL,
                       thread_work,
                       (void*) arg);
    }

    for (int i = 0; i < n_threads; i++) {
        pthread_join(workers[i], NULL);
    }

    free(arg);
    printf("Contador: %d\n", contador_global);
    printf("Esperado: %d\n", n_threads*n_threads*1000);
    return 0;
}
