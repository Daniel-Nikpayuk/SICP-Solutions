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

(define (make-rat n d)
 (define (sign)
  (let
   (
    (bn (and (< n 0) (< d 0)))
    (bp (and (> n 0) (> d 0)))
   )
   (if (or bn bp) + -)
  )
 )
 (define (make s pn pd g)
  (cons (s (/ pn g)) (/ pd g))
 )
 (cond
  ((= d 0) error)
  ((= n 0) (cons 0 1))
  (else
   (make (sign) (abs n) (abs d) (gcd n d))
  )
 )
)

(define x (make-rat 2 3))
(display x)

(define x (make-rat (- 2) 3))
(display x)

(define x (make-rat 2 (- 3)))
(display x)

(define x (make-rat (- 2) (- 3)))
(display x)

