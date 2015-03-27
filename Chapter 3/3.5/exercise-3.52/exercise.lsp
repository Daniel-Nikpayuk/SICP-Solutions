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

(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
(define y (stream-filter even? seq))
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
(stream-ref y 7)
(display-stream z)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Without streaming:

;; define seq=(1 3 6 10 15 ... n(n+1)/2 ... 210)
;; side effects: sum=210

;; y=(6 10 ... 4\ n or n+1 ...)

;; z=(10 15 ... 5\ n or n+1)

;; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
;; (1 2 3 4/ 5 6 7 8/ 9 10 11 12/ 13 14 15 16/ 17 18 19 20/)
;; (3 4 7 8 11 12 15 16 19 20)
;; (15)
;; (stream-ref y 7)=120

;; (1 2 3 4 5/ 6 7 8 9 10/ 11 12 13 14 15/ 16 17 18 19 20/)
;; (4 5 9 10 14 15 19 20)
;; (display-stream z)
;;=(10 15 45 105 120 190 210)

;; With streaming:

;; sum=0
;; define seq: sum=1
;; define y: sum=1
;; define z: sum=1
;; (stream-ref y 7): (stream-ref seq 15): sum=120
;; (display-stream z): (display-stream seq): sum=210

;; If we hadn't used memoize, these answers would differ as we reevaluated and reused "accum" thus adding to sum.

