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

(define (smallest-divisor n)
 (define (divides? a b)
  (= (remainder b a) 0)
 )
 (define (find-min-div n begin)
  (cond
   ((> (square begin) n) n)
   ((divides? begin n) begin)
   (else (find-min-div n (+ begin 1)))
  )
 )
 (find-min-div n 2)
)

(define (prime? n)
  (= n (smallest-divisor n)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (expmod base exp m)
 (cond
  ((= exp 0) 1)
  ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
  (else (remainder (* base (expmod base (- exp 1) m)) m))
 )
)

(define (fermat-test n)
 (define (try-it a)
  (= (expmod a n n) a)
 )
 (try-it (+ 1 (random (- n 1))))
)

(define (fast-prime? n times)
 (cond
  ((= times 0) true)
  ((fermat-test n) (fast-prime? n (- times 1)))
  (else false)
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (timed-prime-test n)
 (define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
 )
 (define (start-prime-test n start-time)
  (if (fast-prime? n 10)
      (report-prime (- (real-time-clock) start-time))
  )
 )
 (display n)
 (start-prime-test n (real-time-clock))
)

(define (search-for-primes b e)
 (define (search-succ b e)
  (timed-prime-test b)
  (newline)
  (if (> b e) (display "done.") (search-succ (+ b 2) e))
 )
 (cond 
  ((= (remainder b 2) 0) (search-succ (+ b 1) e))
  (else (search-succ b e))
 )
)

(search-for-primes 1000 1500)
(newline)
(search-for-primes 10000 10500)
(newline)
(search-for-primes 100000 100500)
(newline)
(search-for-primes 1000000 1000500)

