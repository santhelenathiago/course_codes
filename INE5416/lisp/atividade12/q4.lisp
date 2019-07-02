(defun menor(lista)
    (setq min (car lista))
    (if (null lista)
        0
        (dolist (n lista)
            (if (< n min)
                (setq min n)
            )
        )
    )
    min
)

(defun maior(lista)
    (setq max (car lista))
    (if (null lista)
        0
        (dolist (n lista)
            (if (> n max)
                (setq max n)
            )
        )
    )
    max
)

(defun diferencaMaiorMenor(lista)
    (if (null lista)
        0
        (- (maior lista) (menor lista))
    )
)

(defun main()
    (write-line (write-to-string (diferencaMaiorMenor '(12 2 3 4 5))))
)

(main)