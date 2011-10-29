(define (dict-get dict key . default)
  (let ((pair (assoc key dict)))
    (cond
      (pair (cdr pair))
      ((not (null? default)) (car default))
      (else #f))))