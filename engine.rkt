(define (tokenize string)
  (map
   (lambda (token);try to convert number if possible
     (let ((number (string->number token)))
       (if number
           number
           token)))
   (filter;remove blank tokens
    (lambda (token)
      (not (equal? "" token)))
    (regexp-split (regexp " ") string))))

(define commands '())

(define (register-command descriptor proc)
  (let ((names (dict-get descriptor 'names '())))
    (for-each
     (lambda (name)
       (set! commands
             (cons (list name proc descriptor)
                   commands)))
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
         
  (if (null? string)
      #f
      (let* ((command-name (car string))
             (command-entry (dict-get commands (string->symbol command-name))))
        (if command-entry
            (let* ((proc (car command-entry))
                   (descriptor (cadr command-entry))
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