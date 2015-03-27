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

(define (monte-carlo trials experiment)
 (define (iter trials-remaining trials-passed)
  (cond
   ((= trials-remaining 0) (/ trials-passed trials))
   ((experiment) (iter (- trials-remaining 1) (+ trials-passed 1)))
   (else (iter (- trials-remaining 1) trials-passed)))
 )
 (iter trials 0)
)

(define (make-rand x)
 (lambda () (random x))
)

(define (estimate-pi trials . rand-init)
 (define rand (make-rand (if (null? rand-init) 10000 (car rand-init))))
 (define (cesaro-test) (= (gcd (rand) (rand)) 1))
 (sqrt (/ 6 (monte-carlo trials cesaro-test)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (make-interval-rand a b)
 (let ((diff (- (* 1.0 b) a)))
  (lambda () (+ a (random diff)))
 )
)

(define (estimate-integral in-region? x1 x2 y1 y2 trials)
 (define x-rand (make-interval-rand x1 x2))
 (define y-rand (make-interval-rand y1 y2))
 (define (cesaro-test) (in-region? (x-rand) (y-rand)))
 (* 1.0 (monte-carlo trials cesaro-test) (* (- x2 x1) (- y2 y1)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(estimate-pi 10000)

(define (square x) (* x x))
(define (sum-of-squares x y) (+ (square x) (square y)))
(estimate-integral (lambda (x y) (<= (sum-of-squares x y) 1)) -2 2 -2 2 100000)

