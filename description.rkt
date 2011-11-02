(define (make-description owner)
  (let ((base (make-component "description" owner))
        (description "Nothing special about it"))
    (lambda (message)
      (case message
        ((set-description)
         (lambda (self desc)
           (set! description desc)))
        
        ((dump)
         (lambda (self)
           (print-lines description)))
        
        ((describe)
         (lambda (self)
           (print-lines description)))
        
        (else (get-method base message))))))

(define (description dsc)
  (lambda (owner)
    (let ((description (make-description owner)))
      (ask description 'set-description dsc)      
      description)))