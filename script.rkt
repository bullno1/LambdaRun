(define (make-script name . args)
  (lambda (owner)
    (let ((base (make-component name owner))
          (msgs (pair-up args '())))
      (lambda (message)
        (let ((respond (assoc message msgs)))
          (if respond
              (cdr respond)
              (get-method base message)))))))

(define script make-script)