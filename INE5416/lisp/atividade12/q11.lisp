(defun primeiros(n lista)
    (if (= n 0)
        ()
        (append (list (car lista)) (primeiros (1- n) (cdr lista)))
    )
)


(defun main()
    (write-line (write-to-string (primeiros 0 '(1 2 3 4 5))))
    (write-line (write-to-string (primeiros 1 '(1 2 3 4 5))))
    (write-line (write-to-string (primeiros 2 '(1 2 3 4 5))))
    (write-line (write-to-string (primeiros 3 '(1 2 3 4 5))))
    (write-line (write-to-string (primeiros 4 '(1 2 3 4 5))))
    (write-line (write-to-string (primeiros 5 '(1 2 3 4 5))))
)

(main)