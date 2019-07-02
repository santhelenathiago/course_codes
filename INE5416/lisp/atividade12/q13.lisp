(defun apagarEnquanto(f lista)
    (if (funcall f (car lista))
        (apagarEnquanto f (cdr lista))
        lista
    )
)

(defun par(x)
    (= (mod x 2) 0)
)

(defun impar(x)
    (= (mod x 2) 1)
)

(defun less_than_3(x)
    (< x 3)
)

(defun greater_than_3(x)
    (> x 3)
)

(defun main()
    (write-line (write-to-string (apagarEnquanto 'par '(1 2 3 4 5))))
    (write-line (write-to-string (apagarEnquanto 'impar '(1 2 3 4 5))))
    (write-line (write-to-string (apagarEnquanto 'less_than_3 '(1 2 3 4 5))))
    (write-line (write-to-string (apagarEnquanto 'greater_than_3 '(5 4 3 2 1))))
)

(main)