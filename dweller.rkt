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
        
        ((post-event)
         (lambda (self event)
           (ask location 'post-event event)))
        
        ((destroy)
         (lambda (self)
           (ask location 'remove-entity owner)
           (display (ask owner 'name))
           (display " went to heaven")
           (newline)))
        
        (else (get-method base message))))))

(define dweller make-dweller)