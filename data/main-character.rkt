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
          (display (ask entity 'name))
          (display " moved to ")
          (display (ask dest 'name))
          (newline)))))))

(define main-character
  (make-entity
   (extend-template
    character
    "you"    
    (destructible 
     '((hp 100)))
    main-char-script)))