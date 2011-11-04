(define (make-dweller owner)
  (let ((base (make-component "dweller" owner))
        (location '()))
    (lambda (message)
      (case message
        ((location)
         (lambda (self) location))
        
        ((move-to)
         (lambda (self new-loc)
           (if (not (null? location))
               (begin (ask location 'remove-entity owner)
                      (ask location 'post-event `(entity-left ,owner ,new-loc))))
           
           (set! location new-loc)
           (ask location 'add-entity owner)
           (ask location 'post-event `(entity-entered ,owner))))
        
        ((destroy)
         (lambda (self)
           (ask location 'remove-entity owner)))
        
        (else (get-method base message))))))

(define dweller make-dweller)