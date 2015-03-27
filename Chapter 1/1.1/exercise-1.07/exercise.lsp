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

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

;for really small numbers, the square is smaller than the original; equivalently, the sqrt is larger than the original.
;lisp-mit "(sqrt 0.000001)"
;3.1260655525445276e-2
;as such, the bound 0.001 is the number these approximations converge toward as a number such as 0.03126... has square
;close to 0.001 and if the original x is much much smaller than abs(square(0.03126...)-x) ~ abs(square(0.03126...)) as
;the small number x does not make much of a difference.
;lisp-mit "(square 3.1260655525445276e-2)"
;9.772285838805523e-4

;for very large numbers you must truncate the accuracy, thus the constrained precision forces the guess to always maintain
;a level of distance (a gap) from the original regardless of the 0.001.
;in fact, for really large numbers, the level of accuracy should never be able to become as close as 0.001 and so one
;would get stuck in an infinite loop.
;lisp-mit "(sqrt 999999999999999998)"
;1000000000.
;here if you take the square and abs, the difference is 2 which is much larger than 0.001

;(define (good-enough? guess x)
;  (< (abs (- (square guess) x)) 0.001))

;(define (sqrt-iter guess x)
;  (if (good-enough? guess x)
;      guess
;      (sqrt-iter (improve guess x)
;                 x)))

;(define (sqrt x)
;  (sqrt-iter 1.0 x))

;this does work much better for very small and very large numbers.
;defining an error estimate relative to itself localizes the context with itself as the origin. Error becomes relative
;to it, and not to any external source.

(define (good-enough? guess0 guess1)
  (< (abs (- guess0 guess1)) (* 0.001 guess0)))

(define (sqrt-iter guess0 guess1 x)
  (if (good-enough? guess0 guess1)
      guess0
      (sqrt-iter guess1 (improve guess1 x)
                 x)))

(define (sqrt x)
  (sqrt-iter 1.0 (improve 1.0 x) x))
