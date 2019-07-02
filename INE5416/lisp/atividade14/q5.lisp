(defun main()
    (write "a=")
    (setq a (read))
    (write "b=")
    (setq b (read))
    (write "c=")
    (setq c (read))
    (write-line 
        (write-to-string 
            ((lambda (a b c)
                (if (> a b)  
                    (if (> a c) 
                        a 
                        c
                    ) 
                    (if (> b c) 
                        b
                        c
                    )
                )     
            ) a b c)
        )        
    )
)

(main)