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

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream s1car (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream s2car (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream s1car
                               (merge (stream-cdr s1)
                                      (stream-cdr s2)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (merge-weighted s1 s2 weight)
 (cond
  ((stream-null? s1) s2)
  ((stream-null? s2) s1)
  (else
   (let ((s1car (stream-car s1)) (s2car (stream-car s2)))
    (let ((s1car-weight (weight (car s1car) (cadr s1car))) (s2car-weight (weight (car s2car) (cadr s2car))))
     (cond
      ((< s1car-weight s2car-weight) (cons-stream s1car (merge-weighted (stream-cdr s1) s2 weight)))
      ((> s1car-weight s2car-weight) (cons-stream s2car (merge-weighted s1 (stream-cdr s2) weight)))
      (else (cons-stream s1car (merge-weighted (stream-cdr s1) (stream-cdr s2) weight)))
     )
    )
   )
  )
 )
)

;; the sort would return a stream where each coordinate is what's been sorted so far.

;; (S1 S2 S3 S4 S5 ...)
;; (t1 t2 t3 t4 t5 ...)
;; ((t1) (merge (t2) S1) (merge (t3) S2) ...)
;; Sn=merge (tn) S{n-1}
;; (cons (t1) (map merge t S)

(define (stream-sort stream weight)
 (define partial-sorts
  (cons-stream
   (cons-stream (stream-car stream) the-empty-stream)
   (stream-map (lambda (partial term) (merge-weighted partial (cons-stream term the-empty-stream) weight)) partial-sorts (stream-cdr stream))
  )
 )
 (if (stream-null? stream) the-empty-stream partial-sorts)
)

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

;; unless you know two streams are sorted by your given weight in advance,
;; this is the best you can do in sorting infinite streams.

(define (weighted-pairs s t weight)
 (stream-sort (pairs s t) weight)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; The following version of weighted pairs, though looks general, simply takes that form for ease and style of programming,
;; is actually very fussy about what it can take as input for it to make sense.

;(define (weighted-pairs s t weight);; assumes if b < c then (weight (a b)) < (weight (a c))
; (cons-stream
;  (list (stream-car s) (stream-car t));; assumes if a is least of s and b is least of t, then (a b) is least under weight.
;  (merge-weighted
;   (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t));; by assumption, this stream meets the standard of being already weighted.
;   (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
;   weight
;  )
; )
;)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

;; a)

(define w (pairs integers integers))
(define w-sum (weighted-pairs integers integers (lambda (i j) (+ i j))))

(stream-ref w-sum 0)
(stream-ref w-sum 1)
(stream-ref (stream-ref w-sum 1) 1)

(stream-ref w-sum 2)
(stream-ref (stream-ref w-sum 2) 1)
(stream-ref (stream-ref w-sum 2) 2)

(stream-ref w-sum 3)
(stream-ref (stream-ref w-sum 3) 1)
(stream-ref (stream-ref w-sum 3) 2)

(stream-ref w-sum 4)
(stream-ref (stream-ref w-sum 4) 1)
(stream-ref (stream-ref w-sum 4) 2)
(stream-ref (stream-ref w-sum 4) 3)

(stream-ref w-sum 5)
(stream-ref w-sum 6)
(stream-ref w-sum 7)
(stream-ref w-sum 8)
(stream-ref w-sum 9)
(stream-ref w-sum 10)

;; satifies if i is least of s and j is least of t, then i+j is least of weight. If k+l < i+j, then i < k and j < l ==> i+j < k+l
;; contradiction. Let a in s, and b < c in t, then a+b < a+c. Thus this weighing works.

;; b)

;(define (div-by-2-3-5 n)
; (or (= (remainder n 2) 0) (= (remainder n 3) 0) (= (remainder n 5) 0))
;)

;(stream-filter (lambda (i j) (not (or (div-by-2-3-5 i) (div-by-2-3-5 j))))
; (weighted-pairs integers integers (lambda (i j) (+ (* 2 i) (* 3 j) (* 5 i j))))
;)

;; i < k and j < l: 2i < 2k , 3j < 3l , ij < kl , 5ij < 5kl , 2i+3j+5ij < 2k+3l+5kl
;; so (i j) is the least of weight.

;; b < c , 3b < 3c , 5ab < 5ac , 2a+3b+5ab < 2a+3c+5ac ==> (weight (a b)) < (weight (a c))
;; So weighted-pairs is applicable to this given weight as well.

