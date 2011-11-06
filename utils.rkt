
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

(define command-queue '())

(define (prompt)
  (let ((result (if (null? command-queue)
                    (read-line)
                    (let ((command (car command-queue)))
                      (print-lines command)
                      (set! command-queue (cdr command-queue))
                      command))))
    (if (eq? result eof)
        ""
        result)))

(define (print-lines . msgs)
  (for-each
   (lambda (msg)
     (display msg)
     (newline))
   msgs))

(define (display-multi . args)
  (for-each
   (lambda (arg)
     (display arg))
   args)
  (newline))

(define (debug what)
  (display what)
  (newline)
  what)

(define (loop from to op)
    (if (< from to)
        (begin
          (op from)
          (loop (+ from 1) to op))))

(define (pair-up definitions acc)
  (if (null? definitions)
      acc
      (pair-up (cddr definitions)
               (cons (cons (car definitions) (cadr definitions))
                     acc))))