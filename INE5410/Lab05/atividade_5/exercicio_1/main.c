#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <pthread.h>
#include <time.h>
#include <semaphore.h>

int produzir(int value);    //< definida em helper.c
void consumir(int produto); //< definida em helper.c
void *ProdutorFunc(void *arg);
void *ConsumidorFunc(void *arg);

sem_t prod_sem;
sem_t cons_sem;

int indice_produtor, indice_consumidor, tamanho_buffer;
int* buffer;

//Você deve fazer as alterações necessárias nesta função e na função
//ConsumidorFunc para que usem semáforos para coordenar a produção
//e consumo de elementos do buffer.
void *ProdutorFunc(void *arg) {
    //arg contem o número de itens a serem produzidos
    int max = *((int*)arg);
    for (int i = 0; i <= max; ++i) {
        sem_wait(&prod_sem);
        int produto;
        if (i == max)
            produto = -1;          //envia produto sinlizando FIM
        else 
            produto = produzir(i); //produz um elemento normal

        indice_produtor = (indice_produtor + 1) % tamanho_buffer; //calcula posição próximo elemento
        buffer[indice_produtor] = produto; //adiciona o elemento produzido à lista
        sem_post(&cons_sem);
    }
    return NULL;
}

void *ConsumidorFunc(void *arg) {
    while (1) {
        sem_wait(&cons_sem);
        indice_consumidor = (indice_consumidor + 1) % tamanho_buffer; //Calcula o próximo item a consumir
        int produto = buffer[indice_consumidor]; //obtém o item da lista

        //Podemos receber um produto normal ou um produto especial
        if (produto >= 0) {
            consumir(produto); //Consome o item obtido.
            sem_post(&prod_sem);
        }
        else
            break; //produto < 0 é um sinal de que o consumidor deve parar
    }
    return NULL;
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        return 0;
    }

    tamanho_buffer = atoi(argv[1]);
    int n_itens = atoi(argv[2]);

    //Iniciando buffer
    indice_produtor = 0;
    indice_consumidor = 0;
    buffer = malloc(sizeof(int) * tamanho_buffer);
    // Crie threads e o que mais for necessário para que uma produtor crie 
    // n_itens produtos e o consumidor os consuma

    sem_init(&prod_sem, 0, tamanho_buffer);
    sem_init(&cons_sem, 0, 0);
    pthread_t prod;
    pthread_t cons;

    pthread_create(&prod, NULL, ProdutorFunc, &n_itens);
    pthread_create(&cons, NULL, ConsumidorFunc, NULL);

    pthread_join(prod, NULL);
    pthread_join(cons, NULL);

    sem_destroy(&prod_sem);
    sem_destroy(&cons_sem);
    
    //Libera memória do buffer
    free(buffer);

    return 0;
}

