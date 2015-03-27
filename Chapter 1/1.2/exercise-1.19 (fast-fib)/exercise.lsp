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


;a <- bq + aq + ap
;b <- bp + aq
;(a,b)
;->(bq+aq+ap,bp+aq)
;->( (bp+aq)q+(bq+aq+ap)q+(bq+aq+ap)p , (bp+aq)p+(bq+aq+ap)q )
;->( bpq+aqq+bqq+aqq+apq+bpq+apq+app , bpp+apq+bqq+aqq+apq )
;->( 2bpq+bqq+2apq+aqq+app+aqq , bpp+bqq+2apq+aqq )
;->( b(2pq+qq)+a(2pq+qq)+a(pp+qq) , b(pp+qq)+a(2pq+qq) )
;=>p'=pp+qq, q'=2pq+qq

(define (fast-fib n)
 (define (fib-iter a b p q count)
  (cond
   ((= count 0) b)
   ((even? count) (fib-iter a b (+ (* p p) (* q q)) (+ (* 2 p q) (* q q)) (/ count 2)))
   (else (fib-iter (+ (* b q) (* a q) (* a p)) (+ (* b p) (* a q)) p q (- count 1)))
  )
 )
 (fib-iter 1 0 0 1 n)
)

