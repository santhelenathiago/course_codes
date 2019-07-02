(defstruct no
    n
    esq
    dir
)

(setq minhaArvore
    (make-no 
        :n 52
        :esq (make-no :n 32               ;pode omitir o NIL 
                      :esq (make-no :n 12 :esq NIL :dir NIL) 
                      :dir (make-no :n 35 :esq NIL :dir NIL)
             )
        :dir (make-no :n 56 
                      :esq (make-no :n 55 :esq NIL :dir NIL) 
                      :dir (make-no :n 64 :esq NIL :dir NIL)
             ) 
    )
)

(setq minhaArvore5
    (make-no 
        :n 0
        :esq (make-no :n 1               ;pode omitir o NIL 
                      :esq (make-no :n 2 :esq NIL :dir NIL) 
                      :dir(make-no :n 3 
                                    :esq (make-no :n 6
                                                  :esq NIL
                                                  :dir NIL
                                    
                                    )
                                    :dir NIL
                            ) 
             )
        :dir (make-no :n 1 
                      :esq (make-no :n 4 
                                    :esq (make-no :n 8
                                                  :esq NIL
                                                  :dir NIL
                                    
                                    )
                                    :dir (make-no :n 9
                                                  :esq NIL
                                                  :dir NIL
                                    
                                    )
                            ) 
                      :dir (make-no :n 5 
                                    :esq (make-no :n 55
                                                  :esq NIL
                                                  :dir NIL
                                    
                                    ) 
                                    :dir (make-no :n 78
                                                  :esq NIL
                                                  :dir NIL
                                    
                                    )
                            ) 
             ) 
    )
)

(setq minhaArvore4
    (make-no 
        :n 1
        :esq (make-no :n 2               ;pode omitir o NIL 
                      :esq (make-no :n 4 :esq NIL :dir NIL) 
                      :dir (make-no :n 52 :esq NIL :dir NIL)
             )
        :dir (make-no :n 3
                      :esq (make-no :n 6 :esq NIL :dir NIL) 
                      :dir (make-no :n 7 :esq NIL :dir NIL)
             ) 
    )
)

(setq minhaArvore2
    (make-no 
        :n 52
        :esq (make-no :n 32               ;pode omitir o NIL 
                      :esq (make-no :n 12 
                                    :esq (
                                        make-no :n 1
                                                :esq NIL
                                                :dir NIL

                                    )
                                    :dir NIL
                            ) 
                      :dir (make-no :n 35 :esq NIL :dir NIL)
             )
        :dir (make-no :n 56 
                      :esq (make-no :n 55 :esq NIL :dir NIL) 
                      :dir (make-no :n 64 :esq NIL :dir NIL)
             ) 
    )
)

(setq minhaArvore3
    (make-no 
        :n 52
        :esq (make-no :n 32               ;pode omitir o NIL 
                      :esq (make-no :n 12 
                                    :esq (
                                        make-no :n 1
                                                :esq NIL
                                                :dir NIL

                                    )
                                    :dir NIL
                            ) 
                      :dir (make-no :n 13 
                                    :esq (
                                        make-no :n 1
                                                :esq NIL
                                                :dir NIL

                                    )
                                    :dir NIL
                            ) 
             )
        :dir (make-no :n 56 
                      :esq (make-no :n 55 :esq NIL :dir NIL) 
                      :dir (make-no :n 64 :esq NIL :dir NIL)
             ) 
    )
)

(defun soma (arv)
    (if (null arv)
        0
        (+ 
            (no-n arv) 
            (soma (no-esq arv)) 
            (soma (no-dir arv))
        )
    )
)

(defun buscaElemento (arv x)
    (if (null arv)
        NIL
        (or 
            (= (no-n arv) x)
            (buscaElemento (no-esq arv) x) 
            (buscaElemento (no-dir arv) x)
        )
    )
)

(defun minimo (x y)
    (if (< x y)
        x
        y
    )
)

(setq INF 1000)

(defun minimoElemento (arv)
    (if (null arv)
        INF
        (minimo 
            (no-n arv) 
            (minimo 
                (minimoElemento (no-esq arv)) 
                (minimoElemento (no-dir arv))
            )
        )
    )
)

(defun incrementa (arv x)
    (if (not (null arv))
        (progn
            (setf (no-n arv) (+ (no-n arv) x))
            (incrementa (no-esq arv) x)
            (incrementa (no-dir arv) x)
        )
    )
)

(defun altura(arv)
    (cond
        ((or (null arv) (and (null (no-esq arv)) (null (no-dir arv)))) 0)
        (T 
            (1+ (max (altura (no-esq arv)) (altura (no-dir arv)) ))
        )
    )
)

(defun soma_lista(lista)
    (if (null lista)
        0
        (+ (car lista)  (soma_lista (cdr lista)))
    )
)

(defun media_lista(lista)
    (if (null lista)
        0
        (/ (soma_lista lista) (comprimento_lista lista))
    )
)

(defun comprimento_lista(lista)
    (if (null lista)
        0
        (1+ (comprimento_lista (cdr lista)))
    )
)
(defun distanciaMediaFolhas(arv)
    (float (media_lista (dMedFolhasAux arv 0)))
)

(defun dMedFolhasAux(arv h)
    (if (not (and (null (no-esq arv)) (null (no-dir arv))))
        ;then
        (cond
            ((null (no-esq arv)) (dMedFolhasAux (no-dir arv) (1+ h)))
            ((null (no-dir arv)) (dMedFolhasAux (no-esq arv) (1+ h)))
            (T (append (dMedFolhasAux (no-esq arv) (1+ h)) (dMedFolhasAux (no-dir arv) (1+ h))))
        )
        ;else
        (list h)
    )
)

(defun elementosIguais(arvA arvb)
    (setq vec_A (remove-duplicates (emOrdem arvA)))
    ;; (write-line (write-to-string (sort vec_A #'<)))
    (setq vec_B (remove-duplicates (emOrdem arvB)))
    ;; (write-line (write-to-string (sort vec_B #'<)))
    (comprimento_lista (intersection vec_A vec_B))
)

(defun emOrdem(arv)
    (if (null arv)
        NIL
        (append (emOrdem (no-esq arv)) (list (no-n arv)) (emOrdem (no-dir arv)))
    )
)

(defun nosMaisDistantesQue(arv n)
    (if (null arv)
        ;then
        NIL
        ;else
        (nosMaisDistantesQue_aux arv n 0)
    )
)

(defun nosMaisDistantesQue_aux(arv n h)
    (cond 
        ((null arv) NIL)
        ((> h n)    (append 
                        (list (no-n arv)) 
                        (nosMaisDistantesQue_aux (no-esq arv) n (1+ h)) 
                        (nosMaisDistantesQue_aux (no-dir arv) n (1+ h))
                    )
        )
        (T  (append
                (nosMaisDistantesQue_aux (no-esq arv) n (1+ h)) 
                (nosMaisDistantesQue_aux (no-dir arv) n (1+ h))
            )
                    
        )
    )
)

(defun mapear(lista f)
    (if (null lista)
        ()
        (append (list (funcall f (car lista))) (mapear (cdr lista) f) )
    )
)


(defun arvoreDeBits(arv)
    (setq ord (sort (emOrdem arv) #'>))
    (setq ordSorted (sort ord #'>))
    (setq fib_list (fib_to (car ord)))

    (setq ord (sort ord #'<))


    (write-line (write-to-string fib_list))
    (write-line (write-to-string ord))

    (mapear ord (lambda(x) (if (member x fib_list) 1 0)))
)


(defun fib_to(v)
    (fib_to_aux v 0)
)

(defun fib_to_aux(v n)
    (setq fib_val (fib n))
    (if (<= fib_val v)
        ;then
        (append (list fib_val) (fib_to_aux v (1+ n)))
        ;else
        NIL
    )
)

(defun fib(n)
    (cond
        ((= n 0) 0)
        ((= n 1) 1)
        (T (+ (fib (1- n)) (fib (- n 2))))
    )
)

(defun main()
    (write-line "Item A")
    (write-line (write-to-string (distanciaMediaFolhas minhaArvore)))
    (write-line (write-to-string (distanciaMediaFolhas minhaArvore2)))

    (write-line "Item B")
    (write-line (write-to-string (elementosIguais minhaArvore minhaArvore2)))
    (write-line (write-to-string (elementosIguais minhaArvore3 minhaArvore2)))
    (write-line (write-to-string (elementosIguais minhaArvore minhaArvore4)))

    (write-line "Item C")
    (write-line (write-to-string (nosMaisDistantesQue minhaArvore 0)))
    (write-line (write-to-string (nosMaisDistantesQue minhaArvore 1)))
    (write-line (write-to-string (nosMaisDistantesQue minhaArvore 2)))
    (write-line (write-to-string (nosMaisDistantesQue minhaArvore3 0)))
    (write-line (write-to-string (nosMaisDistantesQue minhaArvore3 1)))
    (write-line (write-to-string (nosMaisDistantesQue minhaArvore3 2)))

    (write-line "Item D")
    (write-line (write-to-string (arvoreDeBits minhaArvore)))
    (write-line (write-to-string (arvoreDeBits minhaArvore5)))
    
)

(main)