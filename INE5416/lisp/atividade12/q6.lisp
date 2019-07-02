(defun ocorrencias(lista n)
    (if (null lista)
        NIL
    )
    (setq oc 0)
    (dolist (x lista)
        (if (= x n)
            (setq oc (1+ oc))
        )
    )
    oc
)

(defun main()
    (write-line (write-to-string (ocorrencias '(1 2 3 4 5) 12)))
    (write-line (write-to-string (ocorrencias '(12 2 3 4 5) 12)))
    (write-line (write-to-string (ocorrencias '(12 2 3 12 5) 12)))
)

(main)