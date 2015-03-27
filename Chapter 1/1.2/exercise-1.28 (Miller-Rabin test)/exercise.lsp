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

(define (square x) (* x x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (nontrivial-expmod base exp m)
 (define (nontrivial-remainder r n)
  (define (nontrivial sr)
   (cond
    ((= sr 1) 0)
    (else sr)
   )
  )
  (cond
   ((or (= r 1) (= r (- n 1))) 1)
   (else (nontrivial (remainder (square r) n)))
  )
 )
 (cond
  ((= exp 0) 1)
  ((even? exp) (nontrivial-remainder (nontrivial-expmod base (/ exp 2) m) m))
  (else (remainder (* base (nontrivial-expmod base (- exp 1) m)) m))
 )
)

(define (nontrivial-fermat-test n b)
 (= (nontrivial-expmod b (- n 1) n) 1)
)

(define (nontrivial-fast-prime? n)
 (define (try-it b)
  (cond
   ((> b (ceiling (/ n 2))) true)
   ((nontrivial-fermat-test n b) (try-it (+ b 1)))
   (else false)
  )
 )
 (newline)
 (display n)
 (display " - ")
 (display (try-it 2))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This test seems to work---it works for these test cases, but it's pretty ugly code.

(nontrivial-fast-prime? 2)
(nontrivial-fast-prime? 2)
(nontrivial-fast-prime? 3)
(nontrivial-fast-prime? 4)
(nontrivial-fast-prime? 5)
(nontrivial-fast-prime? 31)
(nontrivial-fast-prime? 1011)
(nontrivial-fast-prime? 1013)

