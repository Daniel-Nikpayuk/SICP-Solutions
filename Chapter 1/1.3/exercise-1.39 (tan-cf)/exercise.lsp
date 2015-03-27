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

(define (cont-frac-i n d k)
 (define (div frac k)
  (cond
   ((= k 0) frac)
   (else (div (/ (n k) (+ (d k) frac)) (- k 1)))
  )
 )
 (div (/ (n k) (d k)) (- k 1))
)

(define (tan-cf x k)
 (define (n k) (if (= k 1) x (* (- x) x)))
 (define (d k) (+ 1 (* 2 (- k 1))))
 (cont-frac-i n d k)
)

(display 1.618035190615836)
(newline)
(display (tan-cf (/ 3.14159265358979 4) 5))
(newline)
(display (tan (/ 3.14159265 4)))

