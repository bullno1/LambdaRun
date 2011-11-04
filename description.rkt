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

(define (make-long-description owner)
  (let ((base (make-component "long-description" owner))
        (description null))
    (lambda (message)
      (case message
        ((set-description)
         (lambda (self desc)
           (set! description desc)))
        
        ((dump)
         (lambda (self)
           (apply print-lines description)))
        
        ((describe)
         (lambda (self)
           (apply print-lines description)))
        
        (else (get-method base message))))))

(define (long-description dsc)
  (lambda (owner)
    (let ((description (make-long-description owner)))
      (ask description 'set-description dsc)      
      description)))