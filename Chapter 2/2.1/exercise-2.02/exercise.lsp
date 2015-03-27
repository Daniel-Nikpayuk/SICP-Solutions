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

(define (pair-constructor) (lambda (x y) (cons x y)))
(define (pair-selector-x) (lambda (z) (car z)))
(define (pair-selector-y) (lambda (z) (cdr z)))
(define (pair-operator op) (lambda (u v) (cons (op (car u) (car v)) (op (cdr u) (cdr v)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define make-segment (pair-constructor))
(define start-segment (pair-selector-x))
(define end-segment (pair-selector-y))

(define make-point (pair-constructor))
(define x-point (pair-selector-x))
(define y-point (pair-selector-y))
(define point-add (pair-operator +))
(define point-substract (pair-operator -))
(define point-multiply (pair-operator *))
(define point-divide (pair-operator /))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (midpoint-segment seg)
 (let
  (
   (x (start-segment seg))
   (y (end-segment seg))
  )
  (point-divide (point-add x y) (make-point 2 2))
 )
)

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(print-point (midpoint-segment (make-segment (make-point 1 2) (make-point -5 3))))

