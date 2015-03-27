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

;; Doesn't do as many safety checks as it should, but I'm lazy as this is only an exercise.

(define (make-deque)
 (let ((front-ptr '()) (rear-ptr '()))
;;
  (define (make-node) (list '() '() '()))
  (define (item-node node) (cadr node))
  (define (prev-node node) (car node))
  (define (next-node node) (caddr node))
  (define (item-list node)
   (cons (item-node node)
    (if (null? (next-node node)) () (item-list (next-node node)))
   )
  )
  (define (set-item-node! node item) (set-car! (cdr node) item))
  (define (set-prev-node! node item) (set-car! node item))
  (define (set-next-node! node item) (set-car! (cddr node) item))
  (define (front-insert-node! item)
   (set-prev-node! front-ptr (make-node))
   (set-next-node! (prev-node front-ptr) front-ptr)
   (set! front-ptr (prev-node front-ptr))
   (set-item-node! front-ptr item)
  )
  (define (rear-insert-node! item)
   (set-next-node! rear-ptr (make-node))
   (set-prev-node! (next-node rear-ptr) rear-ptr)
   (set! rear-ptr (next-node rear-ptr))
   (set-item-node! rear-ptr item)
  )
  (define (front-delete-node!)
   (set! front-ptr (next-node front-ptr))
   (set-next-node! (prev-node front-ptr) '())
   (set-prev-node! front-ptr '())
  )
  (define (rear-delete-node!)
   (set! rear-ptr (prev-node rear-ptr))
   (set-prev-node! (next-node rear-ptr) '())
   (set-next-node! rear-ptr '())
  )
;;
  (define (empty-deque?) (null? front-ptr))
  (define (front-deque) (if (empty-deque?) '() (item-node front-ptr)))
  (define (rear-deque) (if (empty-deque?) '() (item-node rear-ptr)))
  (define (print-deque) (if (empty-deque?) '() (item-list front-ptr)))
  (define (initial-insert-deque?)
   (if (empty-deque?) (begin (set! front-ptr (make-node)) (set! rear-ptr front-ptr) #t) #f)
  )
  (define (front-insert-deque! item)
   (if (initial-insert-deque?) (set-item-node! front-ptr item) (front-insert-node! item))
  )
  (define (rear-insert-deque! item)
   (if (initial-insert-deque?) (set-item-node! rear-ptr item) (rear-insert-node! item))
  )
  (define (front-delete-deque!)
   (if (empty-deque?) (error "Call to delete on empty!") (front-delete-node!))
  )
  (define (rear-delete-deque!)
   (if (empty-deque?) (error "Call to delete on empty!") (rear-delete-node!))
  )
;;
  (define (dispatch m)
   (cond
    ((eq? m 'empty-deque?) (empty-deque?))
    ((eq? m 'front-deque) (front-deque))
    ((eq? m 'rear-deque) (rear-deque))
    ((eq? m 'print-deque) (print-deque))
    ((eq? m 'front-insert-deque!) front-insert-deque!)
    ((eq? m 'rear-insert-deque!) rear-insert-deque!)
    ((eq? m 'front-delete-deque!) (front-delete-deque!))
    ((eq? m 'rear-delete-deque!) (rear-delete-deque!))
   )
  )
  dispatch
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define d (make-deque))
(d 'print-deque)
((d 'front-insert-deque!) 5)
(d 'print-deque)
((d 'front-insert-deque!) 4)
(d 'print-deque)
((d 'rear-insert-deque!) 6)
(d 'print-deque)
(d 'front-delete-deque!)
(d 'print-deque)

