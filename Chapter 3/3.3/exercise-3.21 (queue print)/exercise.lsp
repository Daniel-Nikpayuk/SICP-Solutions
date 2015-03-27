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

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))
(define (empty-queue? queue) (null? (front-ptr queue)))
(define (make-queue) (cons '() '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; if the cdr of rear is not null that means it points elsewhere, and is being used in a way not specified by
;; the queue design---that includes looping upon itself. We should only try printing until we reach the rear.

(define (print-queue queue)
 (define (print-safe begin end)
  (if (eq? (cdr begin) end) (list (car begin))
   (cons (car begin) (print-safe (cdr begin) end))
  )
 )
 (let
  (
   (queue-begin (front-ptr queue))
   (queue-end (rear-ptr queue))
  )
  (cond
   ((null? queue-begin) '())
   ((not (pair? queue-begin)) (error "Unable to Print: not a queue" queue))
   (else
    (let ((queue-limit (cdr queue-end)))
     (if (null? queue-limit) queue-begin (print-safe queue-begin queue-limit))
    )
   )
  )
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" (print-queue queue))
      (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           (print-queue queue))
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           (print-queue queue)))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" (print-queue queue)))
        (else
         (set-front-ptr! queue (cdr (front-ptr queue)))
         (print-queue queue))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define q1 (make-queue))
(insert-queue! q1 'a)
;((a) a)
(insert-queue! q1 'b)
;((a b) b)
(set-cdr! (rear-ptr q1) (front-ptr q1))
(print-queue q1)
;(delete-queue! q1)
;((b) b)
;(delete-queue! q1)
;(() b)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

