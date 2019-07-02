(defun possiveis(n pecas) 
    (filtrar
        pecas
        (lambda(x)
            (member n x)
        )
    )
)

(defun joga_domino(colocadas pecas)
    (cond 
        (null colocadas)
            ;then
            (progn 
                (setq colocadas (list (car pecas)))
                (setq pecas (cdr pecas))
                (setq poss (append (possiveis (nth 0 (last colocadas))  (possiveis (nth 1 (last colocadas))))))
            )
        (= (comprimento colocadas) 2)
            ;then
            (progn
                (setq connection (intersection (nth 0 colocadas) (nth 1 colocadas)))
                (setq colocadas
                    (list
                        (if (= connection(nth 0 (car colocadas)))
                            ;then
                            '((nth 1 (car colocadas)) (nth 0 (car colocadas)))
                            ;else
                            '((nth 0 (car colocadas)) (nth 1 (car colocadas)))

                        )
                        (if (= connection(nth 0 (last colocadas)))
                            ;then
                            '((nth 1 (last colocadas)) (nth 0 (last colocadas)))
                            ;else
                            '((nth 0 (last colocadas)) (nth 1 (last colocadas)))

                        )
                    )
                ) 
            )
        T 
            ;then
            (progn
                (setq poss (possiveis (nth 1 (last colocadas))))
            )
    )
    (if (null (joga_domino_bt colocadas pecas possiveis))
        ;then
        NIL
    )
)

(defun joga_domino_bt(colocadas pecas possiveis)

)

(defun comprimento(lista)
    (if (null lista)
        0
        (1+ (comprimento (cdr lista)))
    )
)

(defun filtrar(lista f)
    (if (null lista)
        ()
        (if (funcall f (car lista))
            (append (list (car lista)) (filtrar (cdr lista) f))
            (filtrar (cdr lista) f)
        )
    )
)

(defun main()
    (setq pecas '('(2 1) '(4 3) '(1 3) '(4 5) '(2 4) '(1 5)))
    (setq pecas '('(2 1) '(4 3) '(1 3) '(4 5) '(2 4) '(1 5)))
)

(main)