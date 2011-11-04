(define (make-item owner)
  (let ((base (make-component "item" owner))
        (location #f)
        (holder #f)
        (hardness 0))
    (lambda (message)
      (case message
        ((initialize)
         (lambda (self data)
           (set! hardness (dict-get data 'hardness))))
        
        ((drop)
         (lambda (self room)
           (if (not (ask room 'find-component-by-name "room"))
               (error "An item can only be dropped into a room"))
           (if holder
               (ask holder 'remove-item owner))
           (ask room 'add-entity owner)
           (set! location room)
           (set! holder #f)))
        
        ((give)
         (lambda (self carrier)
           (if (not (ask carrier 'find-component-by-name "carrier"))
               (error "An item can only be given to a carrier"))
           (if location
               (ask location 'remove-entity owner))
           (ask carrier 'add-item owner)
           (set! holder carrier)
           (set! location #f)))
        
        ((owned)
         (lambda (self) (null? holder)))
        
        ((holder)
         (lambda (self) holder))
        
        ((location)
         (lambda (self) location))
        
        ((hardness)
         (lambda (self) hardness))
        
        (else (get-method base message))))))

(define item (make-desc make-item))