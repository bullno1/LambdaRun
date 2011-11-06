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
           (set! damage (dict-get data 'damage 0))
           (set! accuracy (dict-get data 'accuracy 0))))
        
        (else (get-method base message))))))

(define weapon (make-desc make-weapon))

(define (make-simple-weapon owner)
  (let ((base (make-component "simple-weapon" owner))
        (attack-count 1)
        (weapon null))
    (lambda (message)
      (case message
        ((initialize)
         (lambda (self data)
           (set! attack-count (dict-get data 'attack-count attack-count))))
        
        ((post-initialize)
         (lambda (self)
           (set! weapon (ask owner 'find-component-by-name "weapon"))
           (if (not weapon)
               (error "simple-weapon requires weapon"))))
          
        ((use)
         (lambda (self attacker target)
           (display-multi (ask attacker 'name) " attacked " (ask target 'name) " using " (ask owner 'name))
           (let ((damage (ask weapon 'damage))
                 (cost (ask weapon 'cost))
                 (accuracy (ask weapon 'accuracy))                 
                 (hit 0))
             (loop 0 attack-count
                   (lambda (i)
                     (if (perform-attack attacker target damage accuracy)
                         (set! hit (+ hit 1)))
                     (ask attacker 'add-rest-time cost)))
             (newline))))
        
        (else (get-method base message))))))

(define simple-weapon (make-desc make-simple-weapon))