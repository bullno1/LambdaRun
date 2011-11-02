(define (menu-helper options count)
  (if (not (null? options))
      (begin
        (display count)
        (display ") ")
        (display (car options))
        (newline)
        (menu-helper (cdr options) (+ count 1)))))
      
(define (menu title options handler)
  (display title)
  (newline)
  (menu-helper options 1)
  (let ((choice (string->number (prompt))))
    (if (and choice
             (exact? choice)
             (>= choice 1)
             (<= choice (length options)))
        (handler choice)
        (begin
          (display "Invalid input")
          (newline)
          (menu title options handler)))))
        