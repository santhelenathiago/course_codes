(defun duasVezes(a m n)
    (setq vec (mat_to_vec a m n))

    (remove-duplicates 
        (filtrar vec 
            (lambda(x) 
                (if (= (count_r vec x) 2)
                    ;then
                    T
                    ;else
                    NIL
                )
            )
        )
    )
)

(defun filtrar(lista f)
    (if (null lista)
        ()
        (if (funcall f (car lista))
            (append (list (car lista)) (filtrar (cdr lista) f))
            (filtrar (cdr lista) f)
        )
    )
)


(defun mat_to_vec(a m n)
    (setq output '())
    (dotimes (i m)
        (dotimes (j n)
            (setq output (append output (list (aref a i j))))
        )
    )

    output
)

(defun count_r(l e) 
    (if (null l)
        ;then
        0
        ;else
        (if (= e (car l))
            ;then
            (1+ (count_r (cdr l) e))
            ;else
            (count_r (cdr l) e)
        )

    )
)

(setf matriz (make-array '(3 3)
    :initial-contents '(
            (1 2 3)
            (4 5 6)
            (1 5 6)
        )
    )
)

(setf matriz2 (make-array '(3 3)
    :initial-contents '(
            (1 2 3)
            (4 5 6)
            (7 8 9)
        )
    )
)

(setf matriz3 (make-array '(3 3)
    :initial-contents '(
            (1 2 3)
            (1 3 2)
            (3 2 1)
        )
    )
)

(defun main()
    (write-line (write-to-string matriz))
    (write-line (write-to-string (duasVezes matriz 3 3)))

    (write-line (write-to-string matriz2))
    (write-line (write-to-string (duasVezes matriz2 3 3)))
    
    (write-line (write-to-string matriz3))
    (write-line (write-to-string (duasVezes matriz3 3 3)))
)

(main)