(define (make-room owner)
  (let ((base (make-component "room" owner))
        (events '())
        (entities (make-list))
        (exits '()))
    (lambda (message)
      (case message
        ((initialize)
         (lambda (self data)
           (set! exits (dict-get data 'exits))))
        
        ((post-event)
         (lambda (self event)
           (set! events (append events event))))
        
        ((process-event)
         (lambda (self proc)
           (for-each proc events)))
        
        ((clear-events)
         (lambda (self)
           (set! events '())))
        
        ((can-enter?)
         (lambda (self entity)
           #t))
        
        ((add-entity)
         (lambda (self entity)
           (ask entities 'prepend entity)
           (ask self 'post-event (list 'entity-enter entity))))
        
        ((remove-entity)
         (lambda (self entity)
           (ask entities 'remove entity)
           (ask self 'post-event (list 'entity-leave entity))))
        
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
         (lambda (direction)
           (dict-get exits direction)))
        
        (else (get-method base message))))))
;alias
(define room make-room)