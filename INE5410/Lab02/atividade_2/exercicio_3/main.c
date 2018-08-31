//! Copyright 2018 Thigo

#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

//    (pai)
//      |
//   filho_1

// ~~~ printfs  ~~~
//        filho (ao iniciar): "Processo %d iniciado\n"
//          pai (ao iniciar): "Processo pai iniciado\n"
// pai (após filho terminar): "Filho retornou com código %d,%s encontrou silver\n"
//                            , onde %s é
//                              - ""    , se filho saiu com código 0
//                              - " não" , caso contrário

// Obs:
// - processo pai deve esperar pelo filho
// - filho deve trocar seu binário para executar "grep silver text"
//   + dica: use execl(char*, char*...)
//   + dica: em "grep silver text",  argv = {"grep", "silver", "text"}

int main(int argc, char** argv) {
    printf("Processo principal iniciado\n");

    fflush(stdout);
    int pid = fork();
    if (pid > 0) {
        int ret;
        do {
            waitpid(pid, &ret, 0);
            if (WIFEXITED(ret) > 0) {
                break;
            }
        } while (1);

        int status = WEXITSTATUS(ret);
        if (status == 0) {
            printf("Filho retornou com código 0, encontrou silver\n");
        } else {
            printf("Filho retornou com código %d, não encontrou silver\n", status);
        }
    } else if (pid == 0) {
        printf("Processo %d iniciado\n", getpid());
        fflush(stdout);
        execlp("grep", "grep", "silver", "text", NULL);
    }
    return 0;
}
