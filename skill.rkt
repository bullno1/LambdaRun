(define (disarm user target)
  (if (and (ask target 'fighter)
           (ask target 'equipped-item))
      (begin
        (display-multi (ask user 'name) " kicked " (ask target 'name) "'s hand")
        (ask user 'add-rest-time 8)
        (ask target 'drop-item (ask target 'equipped-item)))
      (display-multi (ask user 'name) " can't disarm " (ask target 'name))))

(define (perform-with-delay time op)
    (let ((timer (make-entity
                  (make-template
                   "timer"
                   actor
                   (script
                    "timer"
                    'act
                    (lambda (self)
                      (op)
                      (ask (ask self 'owner) 'destroy)))))))
      (ask timer 'add-rest-time time)))

(define (headshot user target)  
  (display-multi (ask user 'name) " took a deep breath and aimed at " (ask target 'name))
  (perform-with-delay 10
                      (lambda ()                        
                        (if (and (ask user 'equipped-item)
                                 (= (ask user 'rest-time) 1));uninterupted
                            (begin
                              (display-multi (ask target 'name) " got a headshot from " (ask user 'name))
                              (ask target 'on-attacked 'user)
                              (perform-attack user target 200 100)))))
  (ask user 'add-rest-time 11))

(define (rush user target)
  (display-multi (ask user 'name) " felt an adrenaline rush")
  (ask user 'attack target)
  (ask user 'attack target))

(define (judo-throw user target)
  (display-multi (ask user 'name) " grabbed " (ask target 'name) "'s arm")
  (ask user 'add-rest-time 7)
  (if (< (random 100) 60)
      (begin
        (display-multi (ask user 'name) " threw " (ask target 'name) " to the ground")
        (ask target 'add-rest-time 20))
      (display-multi (ask target 'name) " escaped from " (ask user 'name) "'s grab")))

(define skill-set null)

(register-command
 '((names (skill sk))
   (args (string string))
   (vararg? #f))
 (lambda (skill-name target-name)
   (let* ((skill (dict-get skill-set (string->symbol skill-name) #f))
          (target (get-object-in-room target-name)))
     (cond
       ((not skill) (display-lines "You don't know such skills"))
       ((not target) (display-lines "Target is not this room"))
       (else
        (skill main-character target))))))

(register-command
 '((names (skills sks))
   (args ())
   (vararg? #f))
 (lambda ()
   (apply print-lines (cons "Here are the skills that you have:"
                              (map car skill-set)))))