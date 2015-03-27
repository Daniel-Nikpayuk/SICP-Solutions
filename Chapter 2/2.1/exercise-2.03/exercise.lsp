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
(define (pair-repeater) (lambda (v) (cons v v)))
(define (pair-selector i) (cond ((= i 0)(lambda (z)(car z))) ((= i 1)(lambda(z)(cdr z))) (else error)))
(define (pair-dropper i) (cond ((= i 0)(lambda (z)(cons 0 (cdr z)))) ((= i 1)(lambda (z)(cons (car z) 0))) (else error)))
(define (pair-operator op) (lambda (u v) (cons (op (car u) (car v)) (op (cdr u) (cdr v)))))
(define (pair-accumulator op) (lambda (u) (op (car u) (cdr u))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define make-point (pair-constructor))
(define rep-point (pair-repeater))
(define x-point (pair-selector 0))
(define y-point (pair-selector 1))
(define x-drop-point (pair-dropper 0))
(define y-drop-point (pair-dropper 1))
(define add-point (pair-operator +))
(define subtract-point (pair-operator -))
(define multiply-point (pair-operator *))
(define divide-point (pair-operator /))
(define cross-add-point (pair-accumulator +))
(define cross-multiply-point (pair-accumulator -))
(define cross-subtract-point (pair-accumulator *))
(define cross-divide-point (pair-accumulator /))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define make-segment (pair-constructor))
(define start-segment (pair-selector 0))
(define end-segment (pair-selector 1))

(define (midpoint-segment seg)
 (let
  (
   (x (start-segment seg))
   (y (end-segment seg))
  )
  (divide-point (add-point x y) (rep-point 2))
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;implementation 1:

;(define (make-rectangle p w h) (cons p (cons w h)))
;(define (bottom-left-rectangle r) (car r))
;(define (bottom-right-rectangle r) (let ((p (car r))(w (y-drop-point (cdr r)))) (add-point p w)))
;(define (top-right-rectangle r) (let ((p (car r))(d (cdr r))) (add-point p d)))
;(define (top-left-rectangle r) (let ((p (car r))(h (x-drop-point (cdr r)))) (add-point p h)))
;(define (width-rectangle r) (car (cdr r)))
;(define (height-rectangle r) (cdr (cdr r)))

;implementation 2:

(define (make-rectangle top-left bottom-right) (list (car top-left) (cdr top-left) (car bottom-right) (cdr bottom-right)))
(define (bottom-left-rectangle r) (cons (car r) (cadddr r)))
(define (bottom-right-rectangle r) (cons (caddr r) (cadddr r)))
(define (top-right-rectangle r) (cons (caddr r) (cadr r)))
(define (top-left-rectangle r) (cons (car r) (cadr r)))
(define (width-rectangle r) (- (caddr r) (car r)))
(define (height-rectangle r) (- (cadr r) (cadddr r)))

(define (perimeter-rectangle r) (+ (* 2 (width-rectangle r)) (* 2 (height-rectangle r))))
(define (area-rectangle r) (* (width-rectangle r) (height-rectangle r)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(newline)

;implementation 1:

;(define rect (make-rectangle (make-point 0 1) 2 3))

;implementation 2:

(define rect (make-rectangle (make-point 0 1) (make-point 2 (- 3))))

rect
(bottom-left-rectangle rect)
(bottom-right-rectangle rect)
(top-right-rectangle rect)
(top-left-rectangle rect)
(width-rectangle rect)
(height-rectangle rect)
(perimeter-rectangle rect)
(area-rectangle rect)

