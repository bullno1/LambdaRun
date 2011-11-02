(define (loop from to op)
    (if (< from to)
        (begin
          (op from)
          (loop (+ from 1) to op))))

(define (pair-up definitions acc)
  (if (null? definitions)
      acc
      (pair-up (cddr definitions)
               (cons (cons (car definitions) (cadr definitions))
                     acc))))

(define (make-area area-map . definitions)  
  (let ((mapdata (make-grid area-map))
        (rooms (pair-up definitions '())))
    
    (define (get-room-at x y)
      (if (or (< x 0)
              (< y 0)
              (>= x (ask mapdata 'width))
              (>= y (ask mapdata 'height)))
          #f
          (let ((cell (ask mapdata 'get x y)))
            (dict-get rooms cell))))
    
    (define (try-link room x y to from)
      (let ((target (get-room-at x y)))
        (if target
            (begin
              (ask room 'link target to)
              (ask target 'link room from)
              ;(display (ask room 'name))
              ;(display "<->")
              ;(display (ask target 'name))
              ;(newline)
              ))))
    
    (loop 0 
          (ask mapdata 'width)
          (lambda (x)
            (loop 0
                  (ask mapdata 'height)
                  (lambda (y)
                    (let ((room (get-room-at x y)))
                      (if room
                          (begin
                            (try-link room (- x 1) y 'west 'east)
                            (try-link room x (- y 1) 'north 'south))))))))
    rooms))

(define (make-grid definition)
  (let ((base (make-named-object 'grid))
        (height (length definition))
        (width (length (car definition))))
    (lambda (message)
      (case message
        ((get)
         (lambda (self x y)
           (list-ref (list-ref definition y) x)))
        ((width)
         (lambda (self) width))
        ((height)
         (lambda (self) height))
        (else (get-method base message))))))