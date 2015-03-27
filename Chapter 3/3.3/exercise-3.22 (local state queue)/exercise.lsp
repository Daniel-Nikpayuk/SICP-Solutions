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

(define (make-queue)
 (let
  ((front-ptr '())
   (rear-ptr '())
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (define (set-front-ptr! item) (set! front-ptr item))
  (define (set-rear-ptr! item) (set! rear-ptr item))
  (define (empty-queue?) (null? front-ptr))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (define (front-queue)
   (if (empty-queue?) (error "FRONT called with an empty queue" front-ptr)
    (car front-ptr)
   )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (define (insert-queue! item)
   (let ((new-pair (cons item '())))
    (cond
     ((empty-queue?) (set-front-ptr! new-pair) (set-rear-ptr! new-pair) front-ptr)
     (else (set-cdr! rear-ptr new-pair) (set-rear-ptr! new-pair) front-ptr)
    )
   )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (define (delete-queue!)
   (cond
    ((empty-queue?) (error "DELETE! called with an empty queue" front-ptr))
    (else (set-front-ptr! (cdr front-ptr)) front-ptr)
   )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (define (dispatch m)
   (cond
    ((eq? m 'set-front-ptr!) set-front-ptr!)
    ((eq? m 'set-rear-ptr!) set-rear-ptr!)
    ((eq? m 'empty-queue?) empty-queue?)
    ((eq? m 'front-queue) front-queue)
    ((eq? m 'insert-queue!) insert-queue!)
    ((eq? m 'delete-queue!) (delete-queue!))
    (else (error "Unknown message:" m))
   )
  )
  dispatch
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define q1 (make-queue))
((q1 'insert-queue!) 'a)
;((a) a)
((q1 'insert-queue!) 'b)
;((a b) b)
(q1 'delete-queue!)
;((b) b)
(q1 'delete-queue!)
;(() b)

