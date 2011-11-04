(define (make-list)
  (let ((base (make-named-object "list"))
        (data '()))
    (lambda (message)
      (case message
        ((append)
         (lambda (self . new-items)
           (set! data (append data new-items))))
        
        ((prepend)
         (lambda (self item)
           (set! data (cons item data))))
        
        ((find)
         (lambda (self pred)
           (findf pred data)))
        
        ((with-data)
         (lambda (self op)
           (op data)))
        
        ((for-each)
         (lambda (self op)
           (for-each op data)))
        
        ((remove)
         (lambda (self item-to-remove)
           (set! data (filter (lambda (item)
                                (not (equal? item item-to-remove)))
                              data))))
        
        (else (get-method base message))))))