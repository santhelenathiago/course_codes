//! Copyright 2018 Thigo

#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

//                          (principal)
//                               |
//              +----------------+--------------+
//              |                               |
//           filho_1                         filho_2
//              |                               |
//    +---------+-----------+          +--------+--------+
//    |         |           |          |        |        |
// neto_1_1  neto_1_2  neto_1_3     neto_2_1 neto_2_2 neto_2_3

// ~~~ printfs  ~~~
//      principal (ao finalizar): "Processo principal %d finalizado\n"
// filhos e netos (ao finalizar): "Processo %d finalizado\n"
//    filhos e netos (ao inciar): "Processo %d, filho de %d\n"

// Obs:
// - netos devem esperar 5 segundos antes
//   de imprmir a mensagem de finalizado (e terminar)
// - pais devem esperar pelos seu descendentes diretos antes de terminar

void neto() {
    printf("Processo %d, filho de %d\n", getpid(), getppid());
    sleep(5);
    printf("Processo %d finalizado\n", getpid());
}

void filho() {
    printf("Processo %d, filho de %d\n", getpid(), getppid());

    fflush(stdout);
    int pid_neto_1 = fork();
    if (pid_neto_1 > 0) {  // filho
        fflush(stdout);
        int pid_neto_2 = fork();
        if (pid_neto_2 > 0) {  // filho
            fflush(stdout);
            int pid_neto_3 = fork();
            if (pid_neto_3 > 0) {  // filho
                printf("Processo %d finalizado\n", getpid());

            } else if (pid_neto_3 == 0) {  // neto
                neto();
            }
        } else if (pid_neto_2 == 0) {  // neto
            neto();
        }

    } else if (pid_neto_1 == 0) {  // neto
        neto();
    }
}

int main(int argc, char** argv) {
    int pid_filho_1 = fork();
    if (pid_filho_1 > 0) {  // principal
        int pid_filho_2 = fork();

        if (pid_filho_2 > 0) {  // principal
            while (wait(NULL) > 0) {}
            printf("Processo principal %d finalizado\n", getpid());
        } else if (pid_filho_2 == 0) {  // filho_2
            filho();
        }

    } else if (pid_filho_1 == 0) {  // filho_1
        filho();
    }

    while (wait(NULL) > 0) {}
    return 0;
}
