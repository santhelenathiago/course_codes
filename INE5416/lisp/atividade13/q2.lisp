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

(defun occorenciasElemento(arv x)
    (if (null arv)
        0
        (+ 
            (if (= (no-n arv) x) 1 0) 
            (+ 
                (occorenciasElemento (no-esq arv) x) 
                (occorenciasElemento (no-dir arv) x)
            )
        )
    )
)

(defun maioresQueElemento(arv x)
    (if (null arv)
        0
        (+ 
            (if (> (no-n arv) x) 1 0) 
            (+ 
                (maioresQueElemento (no-esq arv) x) 
                (maioresQueElemento (no-dir arv) x)
            )
        )
    )
)

(defun quantidade(arv)
    (if (null arv)
        0
        (+
            1
            (+
                (quantidade (no-esq arv))
                (quantidade (no-dir arv))
            )
        )
    )
)

(defun mediaElementos(arv)
    (float (/ (soma arv) (quantidade arv)))
)

(defun elementos(arv)
    (if (null arv)
        NIL
        (append (list (no-n arv)) (elementos (no-esq arv)) (elementos (no-dir arv)))
    )
)

(defun substituir(arv x y)
    (if (not (null arv))
        (progn
            (if (= (no-n arv) x)
                (progn
                    (setf (no-n arv) y)
                )
            )
            (substituir (no-esq arv) x y)
            (substituir (no-dir arv) x y)
        )
    )
)

(defun posordem(arv)
    (if (null arv)
        NIL
        (append (posordem (no-esq arv)) (posordem (no-dir arv)) (list (no-n arv)) )
    )
)

(defun preordem(arv)
    (if (null arv)
        NIL
        (append (list (no-n arv)) (preordem (no-esq arv)) (preordem (no-dir arv)))
    )
)

(defun emordem(arv)
    (if (null arv)
        NIL
        (append (emordem (no-esq arv)) (list (no-n arv)) (emordem (no-dir arv)))
    )
)

(defun subtraiParesImpares(arv)
    (if (null arv)
        0
        (+ 
            (* (no-n arv) (expt -1 (mod (no-n arv) 2))) 
            (subtraiParesImpares (no-esq arv)) 
            (subtraiParesImpares (no-dir arv))
        )
    )
)

(defun novoNo(x)
    (make-no 
        :n x
        :esq NIL
        :dir NIL
    )
)

(defun insere(arv x)
    (if (not (null arv))
        (if (> (no-n arv) x)
            (if (null (no-esq arv))
                (setf (no-esq arv) (novoNo x))
                (insere (no-esq arv) x)
            )
            (if (null (no-dir arv))
                (setf (no-dir arv) (novoNo x))
                (insere (no-dir arv) x)
            )
        )
    )
)

(defun main()
    (write-line (write-to-string (soma minhaArvore)))
    (write-line (write-to-string (buscaElemento minhaArvore 35)))
    (write-line (write-to-string (buscaElemento minhaArvore 36)))
    (write-line (write-to-string (minimoElemento minhaArvore)))
    ;; (write-line (write-to-string (incrementa minhaArvore 2)))
    (write-line (write-to-string minhaArvore))

    (write-line (write-to-string "ocorrenciaslemento 52"))
    (write-line (write-to-string (occorenciasElemento minhaArvore 52)))
    (write-line (write-to-string "ocorrenciaslemento 12"))
    (write-line (write-to-string (occorenciasElemento minhaArvore 12)))
    (write-line (write-to-string "ocorrenciaslemento 2"))
    (write-line (write-to-string (occorenciasElemento minhaArvore 2)))


    (write-line (write-to-string "maioresQueelemento 52"))
    (write-line (write-to-string (maioresQueElemento minhaArvore 52)))
    (write-line (write-to-string "maioresQueelemento 12"))
    (write-line (write-to-string (maioresQueElemento minhaArvore 12)))
    (write-line (write-to-string "maioresQueelemento 2"))
    (write-line (write-to-string (maioresQueElemento minhaArvore 2)))

    (write-line (write-to-string "mediaElementos"))
    (write-line (write-to-string (mediaElementos minhaArvore)))

    (write-line (write-to-string "quantidade"))
    (write-line (write-to-string (quantidade minhaArvore)))

    (write-line (write-to-string "elementos"))
    (write-line (write-to-string (elementos minhaArvore)))

    (write-line (write-to-string "substituir 12 por 2"))
    (substituir minhaArvore 12 2)
    (write-line (write-to-string (elementos minhaArvore)))
    (write-line (write-to-string "substituir 2 por 12"))
    (substituir minhaArvore 2 12)
    (write-line (write-to-string (elementos minhaArvore)))

    (write-line (write-to-string "posordem"))
    (write-line (write-to-string (posordem minhaArvore)))
    (write-line (write-to-string "preordem"))
    (write-line (write-to-string (preordem minhaArvore)))
    (write-line (write-to-string "emordem"))
    (write-line (write-to-string (emordem minhaArvore)))
    
    (write-line (write-to-string "subtraiParesImpares"))
    (write-line (write-to-string (subtraiParesImpares minhaArvore)))

    (write-line (write-to-string "novoNo"))
    (write-line (write-to-string (novoNo 100)))

    (write-line (write-to-string "insere 100"))
    (insere minhaArvore 100)
    (write-line (write-to-string (emOrdem minhaArvore)))
    (write-line (write-to-string "insere 10"))
    (insere minhaArvore 10)
    (write-line (write-to-string (emOrdem minhaArvore)))
    (write-line (write-to-string "insere 44"))
    (insere minhaArvore 44)
    (write-line (write-to-string (emOrdem minhaArvore)))
)

(main)