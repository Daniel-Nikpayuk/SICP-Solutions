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

(define (count-pairs x)
;; not efficient, but first implementation.
 (define (known-pair? p pair-list)
  (cond
   ((null? pair-list) #f)
   ((eq? p (car pair-list)) #t)
   (else (known-pair? p (cdr pair-list)))
  )
 )
 (define (data-structure->unique-list ds ul)
;; arbitrary return, add (eq? (cdr s) '()) to "or" if skip (x '()) pairs.
  (define (traverse s)
   (if (not (pair? s)) #t
    (begin
     (if (known-pair? s ul) #t (append! ul (list s)))
     (traverse (car s))
     (traverse (cdr s))
    )
   )
  )
  (traverse ds)
  (length ul)
 )
 (data-structure->unique-list x (list x))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
(define x0 (list 0))
(define x1 (cons 1 x0))
(define x2 (cons 2 x1))
(count-pairs x2)
;3

(define x0 (list 0))
(define x1 (cons x0 x0))
(define x2 (cons 2 x1))
(count-pairs x2)
;4

(define x0 (list 0))
(define x1 (cons x0 x0))
(define x2 (cons x1 x1))
(count-pairs x2)
;7

;(define x0 (list 0))
;(set-cdr! x0 x0)
;(count-pairs x0)

