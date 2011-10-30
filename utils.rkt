(define (dict-get dict key . default)
  (let ((pair (assoc key dict)))
    (cond
      (pair (if (list? pair)
                (cadr pair)
                (cdr pair)))
      ((not (null? default)) (car default))
      (else #f))))

(define (load-all files)
  (for-each
   (lambda (file)
     (load (string-append (symbol->string file) ".rkt")))
   files))

(define (print-lines . msgs)
  (for-each
   (lambda (msg)
     (display msg)
     (newline))
   msgs))