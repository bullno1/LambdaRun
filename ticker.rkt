(define tickers (make-list))

(define (make-ticker owner)
  (let* ((base (make-component "ticker" owner))
         (self 
          (lambda (message)
            (case message
              ((destroy);remove self from list of tickers
               (lambda (self)
                 (ask tickers 'remove self)))
              (else (get-method base message))))))
    ;register ticker
    (ask tickers 'prepend self)
    self))

(define ticker make-ticker)

(define (update-tickers)
  (ask tickers 'for-each (lambda (tck)
                           (ask (ask tck 'owner) 'tick))))