(define (make-weapon owner)
  (let ((base (make-component "weapon" owner))
        (cost 0)
        (damage 0)
        (accuracy 0))
    (lambda (message)
      (case message
        ((cost)
         (lambda (self) cost))
        
        ((damage)
         (lambda (self) damage))
        
        ((accuracy)
         (lambda (self) accuracy))
        
        ((initialize)
         (lambda (self data)
           (set! cost (dict-get data 'cost 0))
           (set! damage (dict-get data damage 0))
           (set! accuracy (dict-get data accuracy 0))))
        
        (else (get-method base message))))))

(define weapon (make-desc make-weapon))
;combat code
(defnie (attack attacker target weapon)
  )