//! Copyright 2018 Thigo

#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


//       (pai)
//         |
//    +----+----+
//    |         |
// filho_1   filho_2


// ~~~ printfs  ~~~
// pai (ao criar filho): "Processo pai criou %d\n"
//    pai (ao terminar): "Processo pai finalizado!\n"
//  filhos (ao iniciar): "Processo filho %d criado\n"

// Obs:
// - pai deve esperar pelos filhos antes de terminar!


int main(int argc, char** argv) {
    int pid1 = fork();
    if (pid1 > 0) {      // Processo pai
        printf("Processo pai criou %d\n", pid1);

        int pid2 = fork();
        if (pid2 > 0) {      // Processo pai
            printf("Processo pai criou %d\n", pid2);
            while (wait(NULL) > 0) {}
            printf("Processo pai finalizado!\n");

        } else if (pid2 == 0) {      // Processo filho2
            printf("Processo filho %d criado\n", getpid());
        }


    } else if (pid1 == 0) {      // Processo filho1
        printf("Processo filho %d criado", getpid());
    }

    while (wait(NULL) > 0) {}
    return 0;
}
