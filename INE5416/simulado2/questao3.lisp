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

(setq minhaArvore2
    (make-no 
        :n 52
        :esq (make-no :n 32               ;pode omitir o NIL 
                      :esq (make-no :n 12 
                                    :esq NIL 
                                    :dir NIL) 
                                    
                      :dir (make-no :n 35 
                                    :esq (make-no :n 1
                                                  :esq NIL
                                                  :dir NIL
                                         )
                                    :dir (make-no :n 2
                                                  :esq NIL
                                                  :dir NIL
                                         ))
             )
        :dir (make-no :n 56 
                      :esq (make-no :n 55 
                                    :esq NIL 
                                    :dir NIL
                            ) 
                      :dir (make-no :n 64 
                                    :esq NIL 
                                    :dir NIL
                            )
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

(defun main()
    ;; (write-line (write-to-string minhaArvore))
    ;----------------------------------------------------
    (write-line "Item A")
    (write-line (write-to-string (altura minhaArvore)))
    (write-line (write-to-string (altura minhaArvore2)))


    ;----------------------------------------------------
    (write-line "Item B")


    ;----------------------------------------------------
    (write-line "Item C")

)

(main)