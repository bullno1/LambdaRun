(define (register-move-command direction alias description)
  (register-command
   `((names (,direction ,alias))
     (args ()))
   (lambda ()
     ;(display "moving ")
     ;(display direction)
     ;(newline)
     (let* ((current-room (ask main-character 'location))
            (target (ask current-room 'neighbor-towards direction)))
       (if (and target
                (ask target 'can-enter? main-character))
           (begin
             (ask main-character 'move-to target)
             (ask main-character 'add-rest-time 2)
             (describe-room target)
             #t)
           (begin
             (print-lines "You can't go there")
             #f))))))

(register-move-command 'north 'n "Move north")
(register-move-command 'south 's "Move south")
(register-move-command 'east 'e "Move east")
(register-move-command 'west 'w "Move west")
(register-move-command 'up 'u "Move up")
(register-move-command 'down 'd "Move down")