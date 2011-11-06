(define boss-room
  (make-entity
   (make-template
    "Boss room"
    room
    (description "A big room for an epic battle")
    )))

(define boss
  (make-entity
   (extend-template
    character   
    "Ben"
    (destructible '((max-hp 500)))
    enemy-ai
    ticker
    (description "You sense a distrubance in the force")
    (long-description '("  ^^^^^"
                        " |  λ  |"
                        " |-   -|"
                        "(|  ^  |)"
                        " | === |"
                        "  \\___/"
                        "  |   |"))    
    (talker '((default ("How cool is that?"))
              (fallback ("How cool is that?"))))
    (script
     "boss"
     'destroy
     (lambda (self)
       (ask boss 'talk '("Nooooooooo"))
       (ask main-character 'move-to server-room)
       (print-lines "You are teleported back to server room"))
     
     'tick
     (lambda (self)
       (if (and (eq? (ask main-character 'location) (ask boss 'location))
                (< (random 100) 7))
           (begin
             (ask ben 'talk '("I will be able to control anyone in this world with the nanobot technology"
                              "How cool is that?"))
             )))))))

(ask boss 'move-to boss-room)
(ask (make-entity 
      (extend-template
       laser-saber
       "laser-saber"
       (weapon '((cost 30)
                 (damage 70)
                 (accuracy 90)))))
      'give boss)