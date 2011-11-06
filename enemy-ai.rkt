(define (make-enemy-ai owner)
  (let ((base (make-component "enemy-ai" owner)))
    (lambda (message)
      (case message
        ((act)
         (lambda (self)
           ;(dislplay-multi (ask owner 'name) "'s turn")
           (let ((weapon-in-hand (ask owner 'equipped-item))
                 (weapon-in-inventory (ask (ask owner 'inventory) 'find
                                           (lambda (item)
                                             (has-a? item "weapon"))))
                 (weapon-in-room (ask (ask (ask owner 'location) 'entities) 'find
                                      (lambda (item)
                                        (has-a? item "weapon"))))
                 (main-char-here? (eq? (ask main-character 'location) (ask owner 'location))))
             (cond
               ((and weapon-in-hand main-char-here?) (ask owner 'attack main-character))
               ((and weapon-in-inventory
                     (not weapon-in-hand)
                     main-char-here?)
                (ask owner 'equip weapon-in-inventory))
               (weapon-in-room (ask owner 'take-item weapon-in-room))
               (main-char-here?
                (ask owner 'talk '("I will kill you with my eye power!!"))
                (ask owner 'add-rest-time 4))))))
        (else (get-method base message))))))

(define enemy-ai make-enemy-ai)