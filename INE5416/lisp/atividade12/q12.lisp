(defun apagar(n lista)
    (if (= n 0)
        lista
        (apagar (1- n) (cdr lista))
    )
)


(defun main()
    (write-line (write-to-string (apagar 0 '(1 2 3 4 5))))
    (write-line (write-to-string (apagar 1 '(1 2 3 4 5))))
    (write-line (write-to-string (apagar 2 '(1 2 3 4 5))))
    (write-line (write-to-string (apagar 3 '(1 2 3 4 5))))
    (write-line (write-to-string (apagar 4 '(1 2 3 4 5))))
    (write-line (write-to-string (apagar 5 '(1 2 3 4 5))))
)

(main)