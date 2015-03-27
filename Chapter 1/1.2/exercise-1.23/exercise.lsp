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

(define (divides? a b)
 (= (remainder b a) 0)
)

(define (smallest-divisor n)
 (define (next k)
  (if (= k 2) 3 (+ k 2))
 )
 (define (find-min-div n begin)
  (cond
   ((> (square begin) n) n)
   ((divides? begin n) begin)
   (else (find-min-div n (next begin)))
  )
 )
 (find-min-div n 2)
)

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
 (define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
 )
 (define (start-prime-test n start-time)
  (if (prime? n)
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

