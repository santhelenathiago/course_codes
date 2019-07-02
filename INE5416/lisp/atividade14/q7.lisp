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
    (setq l '(1 2 3 4 5 6 7 8 9))
    (write "Lista = ")
    (write-line (write-to-string l))
    (write-line (write-to-string (filtrar l (lambda (x) (= (mod x 2) 0)))))
)

(main)