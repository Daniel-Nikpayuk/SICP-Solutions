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

(define (pairs s t)
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x))
               t)
   (pairs (stream-cdr s) (stream-cdr t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(pairs integers integers)

; (interleave
;  (stream-map (lambda (x) (list (stream-car integers) x)) integers)
;  (pairs (stream-cdr integers) (stream-cdr integers))
; )

; (interleave
;  (stream-map (lambda (x) (list (stream-car (1 2 3 4 5 ...)) x)) (1 2 3 4 5 ...))
;  (pairs (stream-cdr (1 2 3 4 5 ...)) (stream-cdr (1 2 3 4 5 ...)))
; )

; (interleave
;  (stream-map (lambda (x) (list 1 x)) (1 2 3 4 5 ...))
;  (pairs (2 3 4 5 ...) (2 3 4 5 ...))
; )

; (interleave
;  ((1 1) (1 2) (1 3) (1 4) (1 5) ...)
;  (pairs (2 3 4 5 ...) (2 3 4 5 ...))
; )

; (interleave
;  ((1 1) (1 2) (1 3) (1 4) (1 5) ...)
; (interleave
;  ((2 2) (2 3) (2 4) (2 5) ...)
;  (pairs (3 4 5 ...) (3 4 5 ...))
; )

;; This will in practice not work as interleave will have a first element but will never actually be able to produce
;; a second element to interleave it with. You'll end up with an infinite recursive nest.

