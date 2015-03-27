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

;(define (delay exp) (lambda () exp)) ;; inefficient.
;(define (force delayed-object) (delayed-object))

;(define (cons-stream a b) (cons a (delay b)))
;(define (stream-car stream) (car stream))
;(define (stream-cdr stream) (force (cdr stream)))

;(define (stream-ref s n)
;  (if (= n 0)
;      (stream-car s)
;      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))

;(define (stream-map proc s)
;  (if (stream-null? s)
;      the-empty-stream
;      (cons-stream (proc (stream-car s))
;                   (stream-map proc (stream-cdr s)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (show x)
  (define (display-line d) (display d) (newline))
  (display-line x)
  x)

; What does the interpreter print in response to evaluating each expression in the following sequence?

(define x (stream-map show (stream-enumerate-interval 0 10)))

(stream-ref x 5)

;; (stream-ref (stream-cdr x) 4)
;; (stream-ref ((show 1) (stream-map ...) 4))
;; (stream-ref ((show 2) (stream-map ...) 3))
;; (stream-ref ((show 3) (stream-map ...) 2))
;; (stream-ref ((show 4) (stream-map ...) 1))
;; (stream-ref ((show 5) (stream-map ...) 0))
;; (show 5)

;; 1,2,3,4,5, 5 ?

(stream-ref x 7)

;; Note that internally:

;; x=(0 1 2 3 4 5 (stream-map ...)) ;; here we have a memoized stream.

;; (stream-ref (stream-cdr x) 6)

;; 6,7, 7.

