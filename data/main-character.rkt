(define main-char-script
  (script
   "description-of-main-char"
   
   'describe
   (lambda (self)
     (display "Your name is ")
     (display character-name)
     (display " in case you've forgotten"))
   
   'act
   (lambda (self)
     (prompt-and-execute-command))
   
   'on-room-event
   (lambda (self event)
     (case (car event)
       ((entity-left)
        (let ((entity (cadr event))
              (dest (caddr event)))
          (display-multi (ask entity 'name) " moved to " (ask dest 'name))))
       
       ((take-item)
        (let ((entity (cadr event))
              (item (caddr event)))
          (display-multi (ask entity 'name) " took " (ask item 'name))))
       
       ((drop-item)
        (let ((entity (cadr event))
              (item (caddr event)))
          (display-multi (ask entity 'name) " dropped " (ask item 'name))))
       ))
   
   'destroy
   (lambda (self)
     (print-lines "Game over :("))))

(define main-character
  (make-entity
   (extend-template
    character
    "you"    
    (destructible 
     '((max-hp 200)))
    main-char-script)))