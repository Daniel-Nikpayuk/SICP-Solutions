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

(define (integrate-series terms)
 (stream-map / terms integers)
)

(define (additive-invert-series series)
 (if (stream-null? series) the-empty-stream
  (cons-stream (- (stream-car series)) (additive-invert-series (stream-cdr series)))
 )
)

(define exp-series (cons-stream 1 (integrate-series exp-series)))

(define cosine-series (cons-stream 1 (integrate-series (additive-invert-series sine-series))))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; s(t,0) := series of stream t (terms) starting at 0.

;; s(a,0)*s(b,0)=( a_0 + s(a,1)x ) * ( b_0 + s(b,1)x )
;; = a_0b_0 + (a_0s(b,1) + b_0s(a,1))x + s(a,1)s(b,1)x^2
;; = a_0b_0 + (a_0( b_1+s(b,2)x ) + b_0( a_1+s(a,2)x ))x + s(a,1)s(b,1)x^2
;; = a_0b_0 + ( a_0b_1 + a_0s(b,2)x + b_0a_1 + b_0s(a,2)x )x + s(a,1)s(b,1)x^2
;; = a_0b_0 + a_0b_1x + a_0s(b,2)x^2 + b_0a_1x + b_0s(a,2)x^2 + s(a,1)s(b,1)x^2
;; = a_0b_0 + (a_0b_1 + b_0a_1)x + (a_0s(b,2) + b_0s(a,2) + s(a,1)s(b,1))x^2

;; s(a,0)*s(b,0)=( a_0 + s(a,1)x )*s(b,0)
;; s(a,0)*s(b,0)=a_0*s(b,0) + s(a,1)*s(b,0)x

(define (mul-series s1 s2)
 (if (stream-null? s1) the-empty-stream ;; is this right?
  (add-streams 
   (scale-stream s2 (stream-car s1))
   (cons-stream 0 (mul-series (stream-cdr s1) s2))
  )
 )
)

;; s(a,0)*s(b,0)=a_0b_0 + ( a_0*s(b,1) + s(a,1)*s(b,0) )x
;; this form is more similar to the exercise, though I still include my own stream-null? test:

(define (mul-series s1 s2)
 (if (stream-null? s1) the-empty-stream ;; is this right?
  (cons-stream
   (* (stream-car s1) (stream-car s2))
   (add-streams 
    (scale-stream (stream-cdr s2) (stream-car s1))
    (mul-series (stream-cdr s1) s2)
   )
  )
 )
)

(define sine-squared-series (mul-series sine-series sine-series))
(define cosine-squared-series (mul-series cosine-series cosine-series))
(define one-series (add-streams sine-squared-series cosine-squared-series))

(stream-car one-series)
(stream-car (stream-cdr one-series))
(stream-car (stream-cdr (stream-cdr one-series)))
(stream-car (stream-cdr (stream-cdr (stream-cdr one-series))))

; (add-streams 
;  (scale-stream sine-series (stream-car sine-series))
;  (cons-stream 0 (mul-series (stream-cdr sine-series) sine-series))
; )

;; I would rather not go through the extreme technical gory details of showing this evaluation
;; turns into (1 0 0 0 0 ...).
