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

(define (cont-frac-r n d k)
 (define (r i)
  (if (= i k)
   (/ (n k) (d k))
   (/ (n i) (+ (d i) (r (+ i 1))))
  )
 )
 (r 1)
)

(display 1.618035190615836)
(newline)
;(display (cont-frac-i (lambda (x) 1.0) (lambda (x) 1.0) 11))
;(display (cont-frac-r (lambda (x) 1.0) (lambda (x) 1.0) 10))

