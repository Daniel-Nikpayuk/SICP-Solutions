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

; (a,b) := 2^a * 3^b

(define (factor-count n m)
 (define (factor q r c)
  (cond
   ((or (not (= r 0)) (= q 0)) c)
   (else
    (let
     (
      (d (floor (/ q m)))
     )
     (factor d (- q (* d m)) (+ c 1))
    )
   )
  )
 )
 (factor n 0 -1)
)

(define (cons x y)
 (* (expt 2 x) (expt 3 y))
)

(define (car z)
 (factor-count z 2)
)

(define (cdr z)
 (factor-count z 3)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(newline)

(define z (cons 13 7))
(car z)
(cdr z)

