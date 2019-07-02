(defun palindrome(a)
    (setq r (reverse_list a))

    (equal r a)
)

(defun reverse_list(l)
    (if (null l)
        ;then
        '()
        ;else
        (append (reverse_list (cdr l)) (list (car l)))
    )

)

(defun main()

    (write-line (write-to-string (palindrome '(1 2 3))))
    (write-line (write-to-string (palindrome '(1 2 3 2 1))))
)

(main)