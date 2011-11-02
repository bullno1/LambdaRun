(define (fighter owner)
  (let ((base (make-component "fighter" owner))
        (left-hand #f)
        (right-hand #f)
        (dweller '()))
    (lambda (message)
      (case message
        ((post-initialize)
         (lambda (self)
           (set! dweller (ask owner 'find-component-by-name "dweller"))
           (if (not dweller)
               (error "A fighter must also be a dweller"))))
        
        ((equip)
         (lambda (self hand item)
           (case hand
             ((left) (set! left-hand item))
             ((right) (set! right-hand item))
             (else (error "Unkwown hand " hand)))))
        
        ((unequip)
         (lambda (self hand item)
           (ask self 'equip hand #f)))
        
        ((get-equipped-item)
         (lambda (self hand)
           (case hand
             ((left) left-hand)
             ((right) right-hand)
             (else (error "Unkwown hand " hand)))))
        
        (else (get-method base message))))))

(define dweller make-dweller)