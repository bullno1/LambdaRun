(register-command
 '((names (look l))
   (args ())
   (vararg? #t))
 (lambda params   
   (let ((current-room (ask main-character 'location)))
     (cond
       ((= (length params) 0);look at room        
        (describe-room current-room))
       ((= (length params) 1);look at object
        (let ((entities (ask current-room 'entities))
              (found #f))
          (ask entities 'for-each
               (lambda (object)
                 (if (equal? (ask object 'name) (car params))
                     (begin
                       (describe-object object)
                       (set! found #t)))))
          (if (not found)
              (begin
                (display "You can't see any ")
                (display (car params))
                (display " here")
                (newline)))))
       (else
        (print-lines "Wrong number of argument")))
     #f)))

(define (describe-room room)
  ;general description of the room
  (display "You are in ")
  (display (ask room 'name))
  (newline)
  (ask room 'describe)
  (newline)
  ;list objects
  (let ((entities (ask room 'entities)))
    (print-lines "Things in this room:")
    (ask entities 'for-each
         (lambda (ent)
           (print-lines (ask ent 'name)))))
  (newline)
  ;list exits
  (let ((exits (ask room 'exit-directions)))
    (print-lines "Available exits:")
    (for-each (lambda (exit)
                (display exit)
                (display ") ")
                (display (ask (ask room 'neighbor-towards exit) 'name))
                (newline))
              exits)))
   
(define (describe-object object)
  (ask object 'describe)
  (if (has-a? object "item")
      (print-lines "You can pick it up"))
  (if (has-a? object "weapon")
      (print-lines "It is a weapon"))
  (if (has-a? object "destructible")
      (display-multi "HP = " (ask object 'hp) "/" (ask object 'max-hp)))
  (if (has-a? object "fighter")
      (let ((weapon (ask object 'equipped-item)))
        (if weapon
            (begin
              (display-multi "Weapon in hand: " (ask weapon 'name))
              (describe-object weapon)))))
      )

(register-command
 '((names (talk t @))
   (args (string))
   (vararg? #t))
 (lambda (target-name . topic)
   (let ((target (get-object-in-room target-name))
         (topic (if (null? topic) "default" (car topic))))
     (cond
       ((eq? target main-character) (print-lines "Talking to yourself huh? Forever alone"))
       (target (ask target 'enquire topic))
       (else (print-lines "Huh? Who are you trying to talk to?")))
     #f)))

(register-command
 '((names (take))
   (args (string))
   (vararg? #f))
 (lambda (target-name)
   (let ((target (get-object-in-room target-name)))
     (cond
       ((not target) (print-lines "It's not here") #f)
       ((not (ask target 'find-component-by-name "item")) (print-lines "You can't pick that up") #f)
       (else
        (ask main-character 'take-item target)
        (ask main-character 'add-rest-time 1)
        #t)))))

(register-command
 '((names (equip eq))
   (args (string))
   (vararg? #f))
 (lambda (item-name)
   (let ((item (ask (ask main-character 'inventory) 'find
                    (lambda (item)
                      (equal? (ask item 'name) item-name)))))
     (if item
         (begin
           (ask main-character 'equip item)           
           (ask main-character 'add-rest-time 1)
           #t)
         (begin
           (print-lines "You don't have that")
           #f)))))

(register-command
 '((names (inventory i))
   (args ())
   (vararg? #f))
 (lambda ()
   (let* ((inventory (ask (ask main-character 'inventory) 'data))
          (options (append (map (lambda (item)
                                  (ask item 'name))
                                inventory)
                           '("quit"))))
     (menu "Choose an item to see its description"
           options
           (lambda (choice)
             (if (<= choice (length inventory))
                 (describe-object (list-ref inventory (- choice 1))))
             #f)))))

(register-command
 '((names (use u))
   (args (string))
   (vararg? #t))
 (lambda (item-name . target-name)
   (let* ((item (ask (ask main-character 'inventory) 'find
                    (lambda (item)
                      (equal? (ask item 'name) item-name))))
          (target (cond
                    ((null? target-name) main-character)
                    (else (get-object-in-room (car target-name))))))
     (cond
       ((not item) (print-lines "You don't have that item") #f)
       ((not target) (print-lines "Target is not in the room") #f)
       ((ask item 'find-component-by-name "weapon") (print-lines "A weapon must be equipped first"))
       (else
        (ask item 'use main-character target))))))

(register-command
 '((names (snsd))
   (args ())
   (vararg? #f))
 (lambda ()
   (ask (make-entity scythe) 'give main-character)))

(register-command
 '((names (wait))
   (args ())
   (vararg? #f))
 (lambda ()
   (ask main-character 'add-rest-time 4)
   (print-lines "You waited for while")
   #t))

(register-command
 '((names (drop))
   (args (string))
   (vararg? #f))
 (lambda (item-name)
   (let* ((item (ask (ask main-character 'inventory) 'find
                    (lambda (item)
                      (equal? (ask item 'name) item-name)))))
     (if item
         (begin
           (ask main-character 'drop-item item)
           (ask main-character 'add-rest-time 2)
           #t)
         (begin
           (print-lines "you don't have that")
           #f)))))