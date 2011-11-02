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
               (ask location 'remove-entity owner))
           (set! location new-loc)
           (ask location 'add-entity owner)))
        
        ((destroy)
         (lambda (self)
           (ask location 'remove-entity owner)))
        
        (else (get-method base message))))))

(define dweller make-dweller)