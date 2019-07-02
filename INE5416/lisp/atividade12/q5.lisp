(defun busca(lista n)
    (if (null lista)
        NIL
        (if (= (car lista) n) 
            T
            (busca (cdr lista) n)
        )
    )
)

(defun main()
    (write-line (write-to-string (busca '(12 2 3 4 5) 1)))
    (write-line (write-to-string (busca '(12 2 3 4 5) 12)))
)

(main)