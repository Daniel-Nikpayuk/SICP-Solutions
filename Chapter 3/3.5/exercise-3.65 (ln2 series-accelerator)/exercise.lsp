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

(define (partial-sums terms)
 (define sums (cons-stream (stream-car terms) (add-streams (stream-cdr terms) sums)))
 (if (stream-null? terms) the-empty-stream sums)
)

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))           ; Sn-1
        (s1 (stream-ref s 1))           ; Sn
        (s2 (stream-ref s 2)))          ; Sn+1
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))


;; The textbook solves this problem with (cons-stream (/ 1.0 n) (stream-map - (...)))

(define (ln2-even n) (cons-stream (- (/ 1.0 n)) (ln2-odd (+ n 1))))
(define (ln2-odd n) (cons-stream (/ 1.0 n) (ln2-even (+ n 1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define ln2-stream (partial-sums (ln2-odd 1.0)))

(define accelerated-ln2 (accelerated-sequence euler-transform ln2-stream))

(stream-ref accelerated-ln2 0)
(stream-ref accelerated-ln2 1)
(stream-ref accelerated-ln2 2)
(stream-ref accelerated-ln2 3)
(stream-ref accelerated-ln2 4)

