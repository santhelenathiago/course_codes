(defun mapear(lista f)
    (if (null lista)
        ()
        (append (list (funcall f (car lista))) (mapear (cdr lista) f) )
    )
)

(defun pow2(x)
    (* x x)
)

(defun main()
    (write-line (write-to-string (mapear '(1 2 3 4 5) #'pow2)))
)

(main)