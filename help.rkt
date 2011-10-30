(define topics
  '((about ("Le Viet Bach"))
    ))

(register-command 
 '((names (help h ?))
   (args ())
   (vararg? #t))
 
 (lambda command
   (if (null? command)
       (print-lines
        "Usage:"
        "'help <command>' to know more about a command"
        "'help <topic>' to know more about a topic"
        "'help commands' for a list of commands"
        "'help topics' for a list of topics")
       (let* ((arg (car command))
              (descriptor (dict-get name->descriptor arg))
              (info (dict-get topics arg)))
         (cond 
           (info
            (apply print-lines info))
           (else (print-lines "I know nothing about that")))))
   #f))