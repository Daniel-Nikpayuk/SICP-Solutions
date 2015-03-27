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

(define (expmod base exp m)
 (cond
  ((= exp 0) 1)
  ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
  (else (remainder (* base (expmod base (- exp 1) m)) m))
 )
)

(define (charmichael? n)
 (define (congruent b e)
  (cond 
   ((= b e) (display "true"))
   ((not (= (expmod b n n) b)) (display "false"))
   (else (congruent (+ b 1) e))
  )
 )
 (newline)
 (congruent 2 n)
)

(charmichael? 10)
(charmichael? 11)
(charmichael? 5501)

(charmichael? 561)
(charmichael? 1105)
(charmichael? 1729)
(charmichael? 2465)
(charmichael? 2821)
(charmichael? 6601)

