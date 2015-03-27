;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Copyright 2015 Daniel Nikpayuk
;;
;; This file is part of SICP Solutions.
;;
;; SICP Solutions is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
;;
;; SICP Solutions is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
;; of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License along with SICP Solutions. If not, see
;; <http://www.gnu.org/licenses/>.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (clear! cell)
  (set-car! cell #f))

(define (test-and-set! cell)
  (if (car cell)
      #t
      (begin (set-car! cell #t)
             #f)))

(define (make-mutex)
  (let ((cell (list #f)))            
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))
            ((eq? m 'value) (car cell))))
    the-mutex))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; a) In terms of mutexes:

(define (clear-list! mutex-list)
 (cond
  ((null? mutex-list) #t)
  (((car mutex-list) 'value) ((car mutex-list) 'release))
  (else (clear-list (cdr mutex-list)))
 )
)

(define (test-and-set-list! mutex-list)
 (cond
  ((null? mutex-list) #t)
  ((not ((car mutex-list) 'acquire)) #f)
  (else (test-and-set-list! (cdr mutex-list)))
 )
)

(define (make-mutex-list mutex-list num)
 (if (= num 0) mutex-list
  (make-mutex-list (cons (make-mutex) mutex-list) (- num 1))
 )
)

;; Not efficient, it's only programmed with the intent of being functional.
(define (make-semaphore n)
 (let ((mutex-list (make-mutex-list '() n)))
  (define (the-semaphore m)
   (cond
    ((eq? m 'acquire)
     (if (test-and-set-list! mutex-list) (the-semaphore 'acquire))
    )
    ((eq? m 'release)
     (clear-list! mutex-list)
    )
   )
  )
  the-semaphore
 )
)

;; b) In terms of atomic test-and-set! operations:

(define (clear-list! mutex-list)
 (cond
  ((null? mutex-list) #t)
  ((car mutex-list) (set-car! mutex-list #f))
  (else (clear-list (cdr mutex-list)))
 )
)

(define (test-and-set-list! mutex-list)
 (cond
  ((null? mutex-list) #t)
  ((not (car mutex-list)) #f)
  (else (test-and-set-list! (cdr mutex-list)))
 )
)

(define (make-mutex-list mutex-list num)
 (if (= num 0) mutex-list
  (make-mutex-list (cons #f mutex-list) (- num 1))
 )
)

;; Not efficient, it's only programmed with the intent of being functional.
(define (make-semaphore n)
 (let ((mutex-list (make-mutex-list '() n)))
  (define (the-semaphore m)
   (cond
    ((eq? m 'acquire)
     (if (test-and-set-list! mutex-list) (the-semaphore 'acquire))
    )
    ((eq? m 'release)
     (clear-list! mutex-list)
    )
   )
  )
  the-semaphore
 )
)

