(define (make-component name owner)
  (let ((base (make-named-object name)))
    (lambda (message)
      (case message        
        ((initialize)
         (lambda (self data)
           (void)))
        
        ((post-initialize)
         (lambda (self)
           (void)))
        
        ((destroy)
         (lambda (self)
           (void)))
        
        ((owner) (lambda (self) owner))
        
        (else (get-method base message))))))

(define (make-entity template)
  (let* ((base (make-named-object "entity"))
         (components '())
         (self
          (lambda (message)
            (case message
              ((attach-component)
               (lambda (self component)
                 (set! components (cons component components))
                 (ask component 'post-initialize)))
              
              ((find-component)
               (lambda (self pred)
                 (findf pred components)))
              
              ((find-component-by-name)
               (lambda (self name)
                 (ask self 'find-component (lambda (comp)
                                             (equal? name (ask comp 'name))))))
              
              (else
               (let ((base-method (get-method base message)))
                 (if base-method
                     base-method
                     (lambda params
                       (let ((dispatched #f)
                             (result (void)))
                         (for-each
                          (lambda (comp)
                            (let ((method (get-method comp message)))
                              (if method
                                  (begin
                                    (set! dispatched #t)
                                    (set! result (apply method (cons comp params)))))))
                          components)
                         (if dispatched
                             result))))))))))
    
    ;create all components
    (for-each
     (lambda (template-entry)
       (let* ((component-constructor                
               (if (pair? template-entry)
                   (car template-entry)
                   template-entry))
              
              (component (component-constructor self)))
         
         (if (pair? template-entry)
             (ask component 'initialize (cdr template-entry)))
         (set! components (cons component components))))
     template)
    ;post-initialize
    (for-each
     (lambda (component)
       (ask component 'post-initialize))
     components)
    self))