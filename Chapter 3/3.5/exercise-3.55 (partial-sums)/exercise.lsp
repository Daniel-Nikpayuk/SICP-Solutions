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

(define (mul-streams s1 s2)
 (stream-map * s1 s2)
)

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define factorials (cons-stream 1 (mul-streams (stream-cdr integers) factorials)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (partial-sums terms)
 (define sums (cons-stream (stream-car terms) (add-streams (stream-cdr terms) sums)))
 (if (stream-null? terms) the-empty-stream sums)
)

;; (t_2 t_3 t_4 ...)
;; (S_1 S_2 S_3 ...)

;; (t_2 t_3 t_4 ...) + (S_1 S_2 S_3 ...)
;; (t_2+S_1 t_3+S_2 t_4+S_3 ...)
;; (S_2 S_3 S_4 ...)

(define (partial-sums terms)
 (if (stream-null? terms) the-empty-stream
  (cons-stream
   (stream-car terms)
   (add-streams (stream-cdr terms) (partial-sums terms))
  )
 )
)

;; (t_2 t_3 t_4 ...)
;; (S_1 S_2 S_3 ...)

;; (t_2 t_3 t_4 ...) + (S_1 S_2 S_3 ...)
;; (t_2+S_1 t_3+S_2 t_4+S_3 ...)
;; (S_2 S_3 S_4 ...)

(define (partial-sums terms)
 (if (stream-null? terms) the-empty-stream
  (let ((first-terms (cons-stream (stream-car terms) first-terms)))
   (define (partial ts)
    (if (stream-null? ts) the-empty-stream
     (cons-stream
      (stream-car ts)
      (add-streams first-terms (partial-sums (stream-cdr ts)))
     )
    )
   )
   (partial terms)
  )
 )
)

;; (t_1 t_2 t_3 ...)
;; (S_1 S_2 S_3 ...)

;; (t_2 t_3 t_4 ...)
;; (S_2-t_1 S_3-t_1 S_4-t_1 ...)

