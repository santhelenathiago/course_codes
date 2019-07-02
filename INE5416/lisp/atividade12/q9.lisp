(defun inverter(lista)
    (if (null lista)
        ()
        (append (inverter (cdr lista)) (list (car lista)))
    )
)

(defun main()
    (write-line (write-to-string (inverter '(1 2 3 4 5))))
    (write-line (write-to-string (inverter (inverter '(1 2 3 4 5)))))
)

(main)