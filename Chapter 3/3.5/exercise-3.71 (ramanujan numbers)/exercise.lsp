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

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1)) (s2car (stream-car s2)))
          (let ((s1car-weight (weight s1car)) (s2car-weight (weight s2car)))
           (cond ((< s1car-weight s2car-weight)
                  (cons-stream s1car (merge-weighted (stream-cdr s1) s2 weight)))
                 ((> s1car-weight s2car-weight)
                  (cons-stream s2car (merge-weighted s1 (stream-cdr s2) weight)))
                 (else
                  (cons-stream s1car
                               (merge-weighted (stream-cdr s1)
                                      (stream-cdr s2) weight)))))))))

(define (weighted-pairs s t weight);; assumes if b < c then (weight (a b)) < (weight (a c))
 (cons-stream
  (list (stream-car s) (stream-car t));; assumes if a is least of s and b is least of t, then (a b) is least under weight.
  (merge-weighted
   (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t));; by assumption, this stream meets the standard of
								   ;; being already weighted.
   (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
   weight
  )
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (sum-of-two-cubes i j) (+ (* (i i i) (* j j j))))
(define (pair-sum-of-two-cubes p) (let ((i (car p)) (j (cadr p))) (sum-of-two-cubes i j)))

(define (stream-ramanujan pairs)
 (let ((match (pair-sum-of-two-cubes (stream-car pairs))))
  (if (= (pair-sum-of-two-cubes (stream-car (stream-cdr pairs))) match)
   (cons-stream
    (stream-car pairs)
    (stream-ramanujan (stream-cdr (stream-cdr pairs)))
   )
   (stream-ramanujan (stream-cdr pairs))
  )
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define w (weighted-pairs integers integers pair-sum-of-two-cubes))
(stream-car w)
(stream-cdr w)

;;(stream-ref w 2)
;;(stream-ref w 3)
;(stream-ramanujan (weighted-pairs integers integers sum-of-two-cubes))

;(define ramanujan-numbers
; (stream-ramanujan (weighted-pairs integers integers sum-of-two-cubes))
;)

;(define (first-n-ramanujan n)
; (define (first-k ramanujan numbers k)
; (if (= k 0) (reverse ramanujan)
;  (if (stream-car numbers)
;   (first-k (cons ) )
;  )
; )
;)

