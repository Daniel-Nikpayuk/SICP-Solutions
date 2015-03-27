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

(define (average-damp f)
 (define (average a b)
  (/ (+ a b) 2)
 )
  (lambda (x) (average x (f x)))
)

(define tolerance 0.00001)

(define (fixed-point f first-guess)
 (define (close-enough? v1 v2)
  (< (abs (- v1 v2)) tolerance)
 )
 (define (try guess)
  (let ((next (f guess)))
   (display next)
   (newline)
   (if (close-enough? guess next)
       next
       (try next)
   )
  )
 )
 (try first-guess)
)

(newline)
;(display (fixed-point (lambda (x) (+ 1 (/ 1 x))) 0.5))
;(display (fixed-point (lambda (x) (/ (log 1000) (log x))) 2))
(display (fixed-point (average-damp (lambda (x) (/ (log 1000) (log x)))) 2))

