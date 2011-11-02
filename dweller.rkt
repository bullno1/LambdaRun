(define (make-dweller owner)
  (let ((base (make-component "dweller" owner))
        (location '()))
    (lambda (message)
      (case message
        ((location)
         (lambda (self) location))
        
        ((move-to)
         (lambda (self new-loc)
           (set! location new-loc)))
        
        ((destroy)
         (lambda (self)
           (ask location 'remove-entity self)))
        
        (else (get-method base message))))))

(define dweller make-dweller)