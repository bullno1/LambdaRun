(define (perform-attack attacker target damage chance)  
  (cond
    ((not (ask target 'find-component-by-name "destructible"));not destructible
     #f)
    ((<= (ask target 'hp) 0)
     #f)
    ((> (random 100) chance)     
     #f)
    (else ;hit
     (let ((old-hp (ask target 'hp)))
       (ask target 'damage damage)
       #t))))

(register-command
 '((names (attack a))
   (args (string))
   (vararg? #f))
 
 (lambda (target-name)
   (let ((target (get-object-in-room target-name)))
     (if target
         (begin
           (ask main-character 'attack target)
           #t)
         (begin
           (print-lines "Target is not in this room")
           #f)))))