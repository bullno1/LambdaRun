(define (tokenize string)
  (map
   (lambda (token);try to convert number if possible
     (let ((number (string->number token)))
       (cond
         (number number)
         ((or (equal? token "me")
              (equal? token "self"))
          "you")
         (else token))))
   (filter;remove blank tokens
    (lambda (token)
      (not (equal? "" token)))
    (regexp-split (regexp " ") string))))

(define name->proc '())
(define name->descriptor '())

(define (register-command descriptor proc)
  (let ((names (dict-get descriptor 'names '())))
    (for-each
     (lambda (name)
       (set! name->proc
             (cons (cons name proc)
                   name->proc))
       (set! name->descriptor
             (cons (list name descriptor)
                   name->descriptor)))
     names)))

(define (execute-string string)
  (define (check-arity args arg-types vararg?)
    (if vararg?
        (>= (length args) (length arg-types))
        (= (length args) (length arg-types))))
  
  (define (check-type args arg-types)
    (define (helper args arg-types)
      (if (null? arg-types)
          #t
          (case (car arg-types)
            ((number) (if (number? (car args))
                          (helper (cdr args) (cdr arg-types))
                          #f))
            ((string) (if (string? (car args))
                          (helper (cdr args) (cdr arg-types))
                          #f))
            (else (error "Uknown type" (car arg-types))))))
    (helper args arg-types))
         
  (if (or (null? string)
          (not (string? (car string))))
      #f
      (let* ((command-name (string->symbol (car string)))
             (proc (dict-get name->proc command-name)))
        (if proc
            (let* ((descriptor (dict-get name->descriptor command-name))
                   (args (cdr string))
                   (arg-types (dict-get descriptor 'args))
                   (arity (length arg-types))
                   (vararg? (dict-get descriptor 'vararg? #f)))
              (cond
                ((not (check-arity args arg-types vararg?))
                 (display "Wrong number of arguments")
                 (newline)
                 #f)
                ((not (check-type args arg-types))
                 (display "Wrong argument type")
                 (newline)
                 #f)
                (else
                 (apply proc args))))                  
                   
            (begin
              (display "Uknown command")
              (newline)
              #f)))))

(define (prompt-and-execute-command)
  (newline)
  (display ">")
  (let* ((input (prompt))
         (time-passed (execute-string (tokenize input))))
    (if (not time-passed)
        (prompt-and-execute-command))))

(define (start-game-loop)
  (update-tickers)
  (update-actors)
  (start-game-loop))