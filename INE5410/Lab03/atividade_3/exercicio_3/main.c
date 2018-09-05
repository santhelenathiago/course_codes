#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <pthread.h>

// Lê o conteúdo do arquivo filename e retorna um vetor E o tamanho dele
// Se filename for da forma "gen:%d", gera um vetor aleatório com %d elementos
//
// +-------> retorno da função, ponteiro para vetor malloc()ado e preenchido
// |         usado como 2o retorno! <-----+
// v                                      v
double* load_vector(const char* filename, int* out_size);

typedef struct Data {
    double* a;
    double* b;

    double total;

    int init;
    int end;
} data_t;

void* thread_work(void* arg) {
    data_t* input = (data_t*) arg;

    for (int i = input->init; i < input->end; i++) {
        input->total += input->a[i] * input->b[i];
    }

    pthread_exit(0);
}

int main(int argc, char* argv[]) {
    srand(time(NULL));

    //Temos argumentos suficientes?
    if(argc < 4) {
        printf("Uso: %s n_threads a_file b_file\n"
               "    n_threads    número de threads a serem usadas na computação\n"
               "    *_file       caminho de arquivo ou uma expressão com a forma gen:N,\n"
               "                 representando um vetor aleatório de tamanho N\n", 
               argv[0]);
        return 1;
    }
  
    //Quantas threads?
    int n_threads = atoi(argv[1]);
    if (!n_threads) {
        printf("Número de threads deve ser > 0\n");
        return 1;
    }
    //Lê números de arquivos para vetores alocados com malloc
    int a_size = 0, b_size = 0;
    double* a = load_vector(argv[2], &a_size);
    if (!a) {
        //load_vector não conseguiu abrir o arquivo
        printf("Erro ao ler arquivo %s\n", argv[2]);
        return 1;
    }
    double* b = load_vector(argv[3], &b_size);
    if (!b) {
        printf("Erro ao ler arquivo %s\n", argv[3]);
        return 1;
    }
    
    //Garante que entradas são compatíveis
    if (a_size != b_size) {
        printf("Vetores a e b tem tamanhos diferentes! (%d != %d)\n", a_size, b_size);
        return 1;
    }

    //Calcula produto escalar. Paralelize essa parte
    double result = 0;

    data_t* data = malloc(sizeof(data_t)*n_threads);
    for (int i = 0; i < n_threads; i++) {
        data[i].a = a;
        data[i].b = b;
    }

    int frag =  a_size/n_threads;
    for (int i = 0; i < n_threads; i++) {
        data[i].init = i*frag;
        data[i].end = data[i].init + frag;

    }
    data[n_threads-1].end = a_size;

    pthread_t* workers = (pthread_t*) malloc(n_threads*sizeof(pthread_t));
    for (int i = 0; i < n_threads; i++) {
        workers[i] = i;
        pthread_create(&workers[i],
                       NULL,
                       thread_work,
                       (void*) &data[i]);
    }

    for (int i = 0; i < n_threads; i++) {
        pthread_join(workers[i], NULL);
    }

    // Acumula o resultado obtido por cada thread de forma paralela
    // para evitar problemas com condições de corrida
    for (int i = 0; i < n_threads; i++) {
        result += data[i].total;
    }

    //Imprime resultado
    printf("Produto escalar: %g\n", result);    

    //Libera memória
    free(a);
    free(b);

    return 0;
}
