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

(define (has-cycle? x)
;; not efficient, but first implementation.
 (define (member? p pairs)
  (cond
   ((null? pairs) #f)
   ((eq? p (car pairs)) #t)
   (else (member? p (cdr pairs)))
  )
 )
 (let ((known-pairs '()))
  (define (has? p)
   (cond
    ((not (pair? p)) #f)
    ((member? p known-pairs) #t)
    (else
;;can't use append! because list can't be void.
     (set! known-pairs (cons p known-pairs))
     (or (has? (car p)) (has? (cdr p)))
    )
   )
  )
  (has? x)
 )
)

(define (make-cycle x) (set-cdr! (last-pair x) x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define x0 (list 0))
(set-cdr! x0 x0)
(has-cycle? x0)

(define x1 '(0 1 2 3))
(has-cycle? x1)
(make-cycle x1)
(has-cycle? x1)

(define x2 '(0 1 2 3))
(set-car! (cdr x2) x2)
(has-cycle? x2)

