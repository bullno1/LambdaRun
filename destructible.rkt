(define (make-destructible owner)
  (let ((base (make-component "destructible" owner))
        (hp 0))
    (lambda (message)
      (case message
        ((initialize)
         (lambda (self data)
           (set! hp (dict-get data 'hp 0))))
        
        ((hp)
         (lambda (self) hp))
        
        ((damage)
         (lambda (self amount)
           (set! hp (+ hp amount))
           (if (<= hp 0)
               (ask owner 'destroy))))
        
        ((heal)
         (lambda (self amount)
           (set! hp (- hp amount))))
        
        ((dump)
         (lambda (self)
           (display "hp = ")
           (display hp)
           (newline)))
        
        (else (get-method base message))))))

(define destructible (make-desc make-destructible))