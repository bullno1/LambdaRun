(define (make-destructible owner)
  (let ((base (make-component "destructible" owner))
        (hp 0)
        (max-hp 0)
        (damage-threshold 0))
    (lambda (message)
      (case message
        ((initialize)
         (lambda (self data)
           (set! max-hp (dict-get data 'max-hp 0))
           (set! hp (dict-get data 'hp max-hp))
           (set! damage-threshold (dict-get data 'damage-threshold 0))))
        
        ((max-hp)
         (lambda (self) max-hp))
        
        ((hp)
         (lambda (self) hp))
        
        ((damage-threshold)
         (lambda (self) damage-threshold))
        
        ((damage)
         (lambda (self amount)
           (if (>= amount damage-threshold)
               (begin
                 (set! hp (- hp amount))
                 (if (<= hp 0)
                     (ask owner 'destroy))))))
        
        ((heal)
         (lambda (self amount)
           (set! hp (min max-hp (+ hp amount)))))
        
        ((dump)
         (lambda (self)
           (display "hp = ")
           (display hp)
           (newline)))
        
        (else (get-method base message))))))

(define destructible (make-desc make-destructible))