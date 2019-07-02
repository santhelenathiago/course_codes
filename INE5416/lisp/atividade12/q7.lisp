(defun enesimo(lista n)
    (if (null lista)
        NIL
    )
    (if (= n 0)
        (car lista)
        (enesimo (cdr lista) (1- n))
    )
)

(defun main()
    (write-line (write-to-string (enesimo '(12 2 3 4 5) 1)))
    (write-line (write-to-string (enesimo '(12 2 3 4 5) 2)))
)

(main)