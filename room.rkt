(define (make-room owner)
  (let ((base (make-component "room" owner))
        (entities (make-list))
        (exits '()))
    
    (lambda (message)
      (case message
        ((initialize)
         (lambda (self data)
           (set! exits (dict-get data 'exits))))
        
        ((post-event)
         (lambda (self event)
           (ask entities 'for-each
                (lambda (entity)
                  (ask entity 'on-room-event event)))))
        
        ((can-enter?)
         (lambda (self entity)
           #t))
        
        ((add-entity)
         (lambda (self entity)
           (ask entities 'prepend entity)))
        
        ((remove-entity)
         (lambda (self entity)
           (ask entities 'remove entity)))
        
        ((link)
         (lambda (self other direction)
           (set! exits (cons (cons direction other) exits))))
        
        ((entities)
         (lambda (self) entities))
        
        ((exit-directions)
         (lambda (self)
           (map car exits)))
        
        ((neighbors)
         (lambda (self)
           (map cdr exits)))
        
        ((neighbor-towards)
         (lambda (self direction)
           (dict-get exits direction #f)))
        
        (else (get-method base message))))))
;alias
(define room make-room)