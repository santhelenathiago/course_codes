(defun menor(lista)
    (defvar min (car lista))
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

(defun main()
    (write-line (write-to-string (menor '(12 2 3 4 5))))
)

(main)