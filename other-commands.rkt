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
  ;list objects
  (let ((entities (ask room 'entities)))
    (print-lines "Things in this room:")
    (ask entities 'for-each
         (lambda (ent)
           (print-lines (ask ent 'name)))))
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
  (display "This is ")
  (display (ask object 'name))
  (newline)
  (ask object 'describe))