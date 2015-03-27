
;(define (non-zero args)
; (if (null? args) '()
;  (if (eq? (car args) 0) (non-zero (cdr args))
;   (cons (car args) (non-zero (cdr args)))
;  )
; )
;)

;(define (numbers? args)
; (if (null? args) #t
;  (if (number? (car args))
;   (numbers? (cdr args))
;   #f
;  )
; )
;)

