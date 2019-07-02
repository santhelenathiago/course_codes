(defun sequencia(n)
    (if (> n 0)
        ;then
        (+ (- (* n 10)) (sequencia (1- n)))
        ;else
        1000
    )
)


(defun main()
    (write-line "n=")
    (setq n (read ))

    (write-line (write-to-string (sequencia n)))
)

(main)