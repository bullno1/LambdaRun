(define (make-carrier owner)
  (let ((base (make-component "carrier" owner))
        (inventory (make-list)))
    (lambda (message)
      (case message
        ((initialize)
         (lambda (self data)
           (for-each (lambda (item)
                       (ask inventory 'prepend item))
                     data)))
        
        ((inventory)
         (lambda (self) inventory))
        
        ((add-item)
         (lambda (self item)
           (ask inventory 'prepend item)))
        
        ((remove-item)
         (lambda (self item)
           (ask inventory 'remove item)))
        
        (else (get-method base message))))))

(define carrier (make-desc make-carrier))