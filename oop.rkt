;;; Simple object system with inheritance



(define (ask object message . args)  ;; See your Scheme manual to explain `.'

  (let ((method (get-method object message)))

    (if (method? method)

	(apply method (cons object args))

	(error "No method" message (cadr method)))))



(define (get-method object message)

  (object message))



(define (no-method name)

  (list 'no-method name))



(define (method? x)

  (not (no-method? x)))



(define (no-method? x)

  (if (pair? x)      

      (eq? (car x) 'no-method)

      #f))



;;; ----------------------------------------------------------------------------



;;; Persons, places, and things will all be kinds of named objects

(define (make-named-object name)

  (lambda (message) 

    (case message

      ((name) (lambda (self) name))

      (else (no-method name)))))
