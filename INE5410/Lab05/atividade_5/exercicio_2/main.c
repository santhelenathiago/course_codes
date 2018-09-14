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
sem_t bin_sem_p;
sem_t bin_sem_c;

int indice_produtor, indice_consumidor, tamanho_buffer;
int* buffer;

//Você deve fazer as alterações necessárias nesta função e na função
//ConsumidorFunc para que usem semáforos para coordenar a produção
//e consumo de elementos do buffer.
void *ProdutorFunc(void *arg) {
    //arg contem o número de itens a serem produzidos
    int max = *((int*)arg);
    for (int i = 0; i < max; ++i) {
        sem_wait(&prod_sem);
        int produto;
        sem_wait(&bin_sem_p);
        produto = produzir(i); //produz um elemento normal

        indice_produtor = (indice_produtor + 1) % tamanho_buffer; //calcula posição próximo elemento
        buffer[indice_produtor] = produto; //adiciona o elemento produzido à lista
        sem_post(&bin_sem_p);

        sem_post(&cons_sem);
    }
    return NULL;
}

void *ConsumidorFunc(void *arg) {
    while (1) {

        sem_wait(&cons_sem);
        sem_wait(&bin_sem_c);
        indice_consumidor = (indice_consumidor + 1) % tamanho_buffer; //Calcula o próximo item a consumir
        int produto = buffer[indice_consumidor]; //obtém o item da lista
        sem_post(&bin_sem_c);


        //Podemos receber um produto normal ou um produto especial
        if (produto >= 0) {
            consumir(produto); //Consome o item obtido.
            sem_post(&prod_sem);
        } else {
            sem_post(&prod_sem);
            break; //produto < 0 é um sinal de que o consumidor deve parar
        }
    }
    return NULL;
}

int main(int argc, char *argv[]) {
    if (argc < 5) {
        printf("Uso: %s tamanho_buffer itens_produzidos n_produtores n_consumidores \n", argv[0]);
        return 0;
    }

    tamanho_buffer = atoi(argv[1]);
    int itens = atoi(argv[2]);
    int n_produtores = atoi(argv[3]);
    int n_consumidores = atoi(argv[4]);

    //Iniciando buffer
    indice_produtor = 0;
    indice_consumidor = 0;
    buffer = malloc(sizeof(int) * tamanho_buffer);

    // Crie threads e o que mais for necessário para que n_produtores
    // threads criem cada uma n_itens produtos e o n_consumidores os
    // consumam.

    sem_init(&prod_sem, 0, tamanho_buffer);
    sem_init(&cons_sem, 0, 0);
    sem_init(&bin_sem_p, 0, 1);
    sem_init(&bin_sem_c, 0, 1);
    pthread_t prod[n_produtores];
    pthread_t cons[n_consumidores];
    
    for (int i = 0; i < n_produtores; i++) {
        pthread_create(&prod[i], NULL, ProdutorFunc, &itens);
    }

    for (int i = 0; i < n_consumidores; i++) {
        pthread_create(&cons[i], NULL, ConsumidorFunc, NULL);
    }

    for (int i = 0; i < n_produtores; i++) {
        pthread_join(prod[i], NULL);
    }


    // Putting -1 on buffer to kill threads
    for (int i = 0; i < n_consumidores; i++) {
        sem_wait(&prod_sem);
        indice_produtor = (indice_produtor + 1) % tamanho_buffer; //calcula posição próximo elemento
        buffer[indice_produtor] = -1; //adiciona o elemento produzido à lista
        sem_post(&cons_sem);
    }

    for (int i = 0; i < n_consumidores; i++) {
        pthread_join(cons[i], NULL);
    }
    sem_destroy(&prod_sem);
    sem_destroy(&cons_sem);
    sem_destroy(&bin_sem_p);
    sem_destroy(&bin_sem_c);
    
    //Libera memória do buffer
    free(buffer);

    return 0;
}

