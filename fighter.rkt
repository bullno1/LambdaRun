(define (fighter owner)
  (define (is-weapon? item)
    (ask item 'find-component-by-name "weapon"))
  
  (let ((base (make-component "fighter" owner))
        (equipped-item #f))        
    (lambda (message)
      (case message        
        ((equip)
         (lambda (self item)
           (set! equipped-item item)
           (ask owner 'post-event `(equip ,owner ,item))))
        
        ((unequip)
         (lambda (self)
           (set! equipped-item #f)))
        
        ((equipped-item)
         (lambda (self) equipped-item))
        
        ((attack)
         (lambda (self target)
           (cond
             ((not equipped-item)
              (display (ask owner 'name))
              (display " cannot attack without a weapon.")
              (newline))
             
             ((is-weapon? equipped-item)
              (ask target 'on-attacked owner)  
              (ask equipped-item 'use owner target))
             
             (else
              (let ((improvised-melee-accuracy (ask owner 'get-property 'improvised-melee-accuracy)))
                (display-multi (ask owner 'name) " attacked " (ask target 'name) " using " (ask equipped-item 'name))
                (if improvised-melee-accuracy
                    (perform-attack owner
                                    target
                                    (ask equipped-item 'hardness)
                                    improvised-melee-accuracy)
                    (ask owner 'add-rest-time 5)))))))
        
        (else (get-method base message))))))

(define dweller make-dweller)