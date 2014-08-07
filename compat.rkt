(define null '())

(define (null? lst)
  (equal? lst null))

(define (void) 'void)

(define (findf proc lst)
  (let ((result (filter proc lst)))
    (if (null? result)
      #f
      (car result))))

(define random random-integer)

(define (exact? num) (= (round num) num))
