(defun qualOrdem(listaNumeros)
    (cond
        ((crescente listaNumeros) "não-decrescente")
        ((decrescente listaNumeros) "não-crescente")
        (T "sem ordem")
    )
)

(defun crescente(l)
    (if (null (cadr l))
        T
        (if (<= (car l) (cadr l))
            ;then
            (crescente (cdr l))
            ;else
            NIL        
        )
    )
)

(defun decrescente(l)
    (if (null (cadr l))
        T
        (if (>= (car l) (cadr l))
            ;then
            (decrescente (cdr l))
            ;else
            NIL
        )
    )
)


(defun main()
    (write-line (write-to-string (qualOrdem '(10 9 8 10 10 10 7))))
    (write-line (write-to-string (qualOrdem '(1 2 3 4 5 6 7 8 9))))
    (write-line (write-to-string (qualOrdem '(1 2 3 4 5 6 7 9 8))))
    (write-line (write-to-string (qualOrdem '(10 9 8 7 6 5 4 3 2 1))))
)

(main)