;get the object refered to in the command
(define (get-object-in-room name)
  (let* ((current-room (ask main-character 'location))
         (entities (ask current-room 'entities)))
    (ask entities 'find
         (lambda (entity)
           (equal? (ask entity 'name) name)))))