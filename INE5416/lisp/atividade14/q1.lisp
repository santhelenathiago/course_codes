(defun main()
    (write-line (write-to-string ((lambda (x y) (or (and x y) (and (not x) (not y)))) NIL NIL)))
    (write-line (write-to-string ((lambda (x y) (or (and x y) (and (not x) (not y)))) NIL T)))
    (write-line (write-to-string ((lambda (x y) (or (and x y) (and (not x) (not y)))) T NIL)))
    (write-line (write-to-string ((lambda (x y) (or (and x y) (and (not x) (not y)))) T T)))
)

(main)