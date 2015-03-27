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

(define pi 3.14159265358979323846264338327950288419716939937510)

(define (iterator op init term a next b)
 (define (succ accum a)
  (if (> a b) accum
   (succ (op accum (term a)) (next a))
  )
 )
 (succ init a)
)

(define (id n) n)
(define (inc n) (+ n 1))
(define (dec n) (- n 1))
(define (int-div n m) (/ (- n (remainder n m)) m))
(define (square x) (* x x))
(define (cube x) (* x x x))

(define (sum term a next b) (iterator + 0 term a next b))
(define (prod term a next b) (iterator * 1 term a next b))

(define (factorial n) (prod id 1 inc n))

(define (wallis n)
 (define (num-term k) (* 2 (int-div (inc k) 2)))
 (define (denom-term k) (inc (num-term k)))
 (define (wall-num n) (iterator * 1 num-term 1 inc n))
 (define (wall-denom n) (iterator * 1 denom-term 1 inc n))
 (/ (wall-num (inc n)) (* 2.0 (wall-denom n)))
)

