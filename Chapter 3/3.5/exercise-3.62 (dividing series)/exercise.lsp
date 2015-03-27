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

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define (invert-series series)
 (if (stream-null? series) the-empty-stream
  (cons-stream (- (stream-car series)) (invert-series (stream-cdr series)))
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (mul-series s1 s2)
 (if (stream-null? s1) the-empty-stream ;; is this right?
  (add-streams 
   (scale-stream s2 (stream-car s1))
   (cons-stream 0 (mul-series (stream-cdr s1) s2))
  )
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (invert-unit-series s)
 (cond
  ((stream-null? s) the-empty-stream)
  ((not (= (stream-car s) 1)) (error "Not a unit series!"))
  (else
   (define i (cons-stream 1 (additive-invert (mul-series (stream-cdr s) i))))
   i
  )
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; I recognize this could be optimized at least in terms of redundancy of stream-null? checks.

(define (div-series s1 s2)
 (cond
  ((or (stream-null? s1) (stream-null? s2)) the-empty-stream)
  ((not (= s2 zero-series)) (error "Divide by zero!")) ;; need to define zero-series as well as a way of testing equality of series.
  ((= (stream-car s2) 1) (mul-series s1 (invert-unit-series s2)))
  (else
   (let ((c (/ 1 (stream-car s2)))) ;; doesn't test for zero!
    (scale-stream (mul-series s1 (invert-unit-series (scale-stream s2 c))) c) ;; to be cautious one could instead of scaling
 ;; s2 would scale (cdr s2) and cons 1 in front (not risking round-off error).
   )
  )
 )
)

(define tangent-series (div-series sine-series cosine-series))

