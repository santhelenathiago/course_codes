#include <sys/wait.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int first_proc_id;
int ex_count = 1;

int fork_with_print() {
    int prior_id = getpid();
    int id = fork();
    if (id == 0) {
        printf("fork,%d,%d\n", getpid(), prior_id);
        fflush(stdout);
    } else {
        // printf("I am process %d, parent of %d!\n I have just forked it!\n", getpid(), id);
    }
    return id;
}

void finish_exercise() {
    while (wait(NULL) > 0) {}
    printf("start,%d,%d\n", ex_count, getpid());
    fflush(stdout);
    ex_count++;
}

void exercise_1() {
    for (int i = 0; i < 3; ++i) {
        if (!fork_with_print()) {
            exit(1);
        }
    }
    finish_exercise();
}

void exercise_2() {
    fflush(stdout);
    int pid_son_1 = fork_with_print();
    if (pid_son_1 > 0) {  // root
        fflush(stdout);
        int pid_son_2 = fork_with_print();
        if (pid_son_2 > 0) {  // root
            fflush(stdout);
            int pid_son_3 = fork_with_print();  // from here, root to finish
            if (pid_son_3 == 0) {  // son 3
                fflush(stdout);
                int pid_gchild_3_1 = fork_with_print();
                if (pid_gchild_3_1 > 0) {  // son 3
                    fflush(stdout);
                    int pid_gchild_3_2 = fork_with_print();
                    if (pid_gchild_3_2 > 0) {  // son 3
                        while (wait(NULL) > 0) {}
                        exit(1);
                    } else if (pid_gchild_3_2 == 0) {  // grand son 3_2
                        fflush(stdout);
                        int pid_gg_child_3_2_1 = fork_with_print();
                        if (pid_gg_child_3_2_1 > 0) {
                            while (wait(NULL) > 0) {}
                            exit(1);
                        } else if (pid_gg_child_3_2_1 == 0) {  // last child
                            exit(1);
                        }
                    }
                } else if (pid_gchild_3_1 == 0) {  // grand son 3_1
                    exit(1);
                }
            }
        } else if (pid_son_2 == 0) {  // son 2
            fflush(stdout);
            int pid_gchild_2_1 = fork_with_print();
            if (pid_gchild_2_1 > 0) {  // son 2
                while (wait(NULL) > 0) {}
                exit(1);

            } else if (pid_gchild_2_1 == 0) {  // grand son 2_1
                exit(1);
            }
        }

    } else if (pid_son_1 == 0) {  // son 1
        exit(1);
    }

    finish_exercise();
}

void exercise_3() {
    for (int i = 0; i < 2; i++) {
        fflush(stdout);
        int pid1 = fork_with_print();
        if (pid1 == 0) {  // son
            fflush(stdout);
            int pid2 = fork_with_print();
            if (pid2 > 0) {  // son
                fflush(stdout);
                int pid3 = fork_with_print();
                if (pid3 > 0) {  // son
                    while (wait(NULL) > 0) {}
                    exit(1);
                } else if (pid3 == 0) {  // grand son 2
                    exit(1);
                }
            } else if (pid2 == 0) {  // grand son 1
                exit(1);
            }
        }
    }
    finish_exercise();
}

void exercise_4() {
    fflush(stdout);
    int pid = fork_with_print();
    if (pid > 0) {  // root
        for (int i = 0; i < 2; i++) {
            fflush(stdout);
            int pid1 = fork_with_print();
            if (pid1 == 0) {  // son
                fflush(stdout);
                int pid2 = fork_with_print();
                if (pid2 > 0) {  // son
                    fflush(stdout);
                    int pid3 = fork_with_print();
                    if (pid3 > 0) {  // son
                        while (wait(NULL) > 0) {}
                        exit(1);
                    } else if (pid3 == 0) {  // grand son 2
                        exit(1);
                    }
                } else if (pid2 == 0) {  // grand son 1
                    exit(1);
                }
            }
        }
    } else if (pid == 0) {
        exit(1);
    }
    finish_exercise();
}

void exercise_5() {
    fflush(stdout);
    int pid1 = fork_with_print();
    if (pid1 > 0) {  // root
        fflush(stdout);
        int pid2 = fork_with_print();
        if (pid2 == 0) {  // ramo 2
            fflush(stdout);
            int pid6 = fork_with_print();
            if (pid6 > 0) {  // ramo 2
                fflush(stdout);
                int pid7 = fork_with_print();
                if (pid7 > 0) {  // ramo 2
                    while (wait(NULL) > 0) {}
                    exit(1);
                } else if (pid7 == 0) {  // ramo 2 -> 2
                    fflush(stdout);
                    int pid8 = fork_with_print();
                    if (pid8 > 0) {
                        while (wait(NULL) > 0) {}
                        exit(1);
                    } else if (pid8 == 0) {  // ramo 2 -> 2 -> 1
                        exit(1);
                    }
                }
            } else if (pid6 == 0) {  // ramo 2 -> 1
                fflush(stdout);
                int pid9 = fork_with_print();
                if (pid9 > 0) {  // ramo 2 -> 1
                    while (wait(NULL) > 0) {}
                    exit(1);
                } else if (pid9 == 0) {  // ramo  2 -> 1 -> 1
                    exit(1);
                }
            }
        }
    } else if (pid1 == 0) {  // ramo 1
        fflush(stdout);
        int pid3 = fork_with_print();
        if (pid3 > 0) {  // ramo 1
            while (wait(NULL) > 0) {}
            exit(1);

        } else if (pid3 == 0) {  // ramo 1 -> 1
            fflush(stdout);
            int pid4 = fork_with_print();
            if (pid4 > 0) {  // ramo 1 -> 1
                fflush(stdout);
                int pid5 = fork_with_print();
                if (pid5 > 0) {  // ramo 1-> 1
                    while (wait(NULL) > 0) {}
                    exit(1);
                } else if (pid5 == 0) {  // ramo 1 -> 1 -> 2
                    exit(1);
                }
            } else if (pid4 == 0) {  // ramo 1 -> 1 -> 1
                exit(1);
            }
        }
    }
    finish_exercise();
}

void exercise_6() {
    fflush(stdout);
    int first_son = fork_with_print();
    if (first_son > 0) {  // root
        fflush(stdout);
        int second_son = fork_with_print();
        if (second_son == 0) {  // second_son, root goes to finish
            exit(1);
        }
    } else if (first_son == 0) {  // first son
        fflush(stdout);
        int first_grand_son = fork_with_print();
        if (first_grand_son > 0) {  // first son
            fflush(stdout);
            int second_grand_son = fork_with_print();
            if (second_grand_son > 0) {  // first son
                while (wait(NULL) > 0) {}
                exit(1);
            } else if (second_grand_son == 0) {  // second grand son
                exit(1);
            }
        } else if (first_grand_son == 0) {  // first grand son
            fflush(stdout);
            int first_g_grand_son = fork_with_print();
            if (first_g_grand_son > 0) {  // first grand son
                fflush(stdout);
                int second_g_grand_son = fork_with_print();
                if (second_g_grand_son > 0) {  // first grand son
                    while (wait(NULL) > 0) {}
                    exit(1);
                } else if (second_g_grand_son == 0) {  // second grand son
                    exit(1);
                }
            } else if (first_g_grand_son == 0) {  // first grand grand son
                exit(1);
            }
        }
    }
    finish_exercise();
}

void exercise_7() {
    for (int i  = 0; i < 3; i++) {
        fflush(stdout);
        int son = fork_with_print();
        if (son == 0) {  // son, root skips
            fflush(stdout);
            int grand_son = fork_with_print();
            if (grand_son > 0) {  // son
                while (wait(NULL) > 0) {}
                exit(1);
            } else if (grand_son == 0) {  // grand son
                fflush(stdout);
                int first_g_grand_son = fork_with_print();
                if (first_g_grand_son > 0) {  // grand son
                    fflush(stdout);
                    int second_g_grand_son = fork_with_print();
                    if (second_g_grand_son > 0) {  // grand son
                        while (wait(NULL) > 0) {}
                        exit(1);
                    } else if (second_g_grand_son == 0) {  // second g g son
                        exit(1);
                    }
                } else if (first_g_grand_son == 0) {  // first grand grand son
                    exit(1);
                }
            }
        }
    }
    finish_exercise();
}

void exercise_8() {
    fflush(stdout);
    int son = fork_with_print();
    if (son == 0) {  // son, root skips
        fflush(stdout);
        int first_grand_son = fork_with_print();
        if (first_grand_son > 0) {  // son
            fflush(stdout);
            int second_grand_son = fork_with_print();
            if (second_grand_son > 0) {  // son
                fflush(stdout);
                int third_grand_son = fork_with_print();
                if (third_grand_son > 0) {  // son
                    while (wait(NULL) > 0) {}
                    exit(1);
                } else if (third_grand_son == 0) {
                    exit(1);
                }
            } else if (second_grand_son == 0) {
                exit(1);
            }
        } else if (first_grand_son == 0) {  // first grand son
            fflush(stdout);
            int g_grand_son = fork_with_print();
            if (g_grand_son > 0) {  // first grand son
                while (wait(NULL) > 0) {}
                exit(1);
            } else if (g_grand_son == 0) {  // grand grand son
                fflush(stdout);
                int first_last_child = fork_with_print();
                if (first_last_child > 0) {  // grand grand son
                    fflush(stdout);
                    int second_last_child = fork_with_print();
                    if (second_last_child > 0) {  // grand grand son
                        fflush(stdout);
                        int third_last_child = fork_with_print();
                        if (third_last_child > 0) {  // grand grand son
                            while (wait(NULL) > 0) {}
                            exit(1);
                        } else if (third_last_child == 0) {
                            exit(1);
                        }
                    } else if (second_last_child == 0) {
                        exit(1);
                    }
                } else if (first_last_child == 0) {
                    exit(1);
                }
            }
        }
    }
    finish_exercise();
}

int main(int argc, char** argv) {
    printf("start,%d,%d\n", ex_count, getpid());
    ex_count++;
    first_proc_id = getpid();
    fflush(stdout);
    exercise_1();
    exercise_2();
    exercise_3();
    exercise_4();
    exercise_5();
    exercise_6();
    exercise_7();
    exercise_8();
    printf("end,0,8\n");
    return 0;
}
