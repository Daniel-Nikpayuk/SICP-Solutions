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

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

;recursive process:
;(+ 4 5)
;(if (= 4 0) 5 (inc (+ (dec 4) 5)))
;(inc (+ (dec 4) 5))
;(inc (+ 3 5))
;(inc (if (= 3 0) 5 (inc (+ (dec 3) 5))))
;(inc (inc (+ (dec 3) 5)))
;(inc (inc (+ 2 5)))
;(inc (inc (if (= 2 0) 5 (inc (+ (dec 2) 5)))))
;(inc (inc (inc (+ (dec 2) 5))))
;(inc (inc (inc (+ 1 5))))
;(inc (inc (inc (if (= 1 0) 5 (inc (+ (dec 1) 5))))))
;(inc (inc (inc (inc (+ (dec 1) 5)))))
;(inc (inc (inc (inc (+ 0 5)))))
;(inc (inc (inc (inc (if (= 0 0) 5 (inc (+ (dec 0) 5)))))))
;(inc (inc (inc (inc 5))))
;(inc (inc (inc 6)))
;(inc (inc 7))
;(inc 8)
;9

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

;iterative process:
;(+ 4 5)
;(if (= 4 0) 5 (+ (dec 4) (inc 5)))
;(+ (dec 4) (inc 5))
;(+ 3 6)
;(if (= 3 0) 6 (+ (dec 3) (inc 6)))
;(+ (dec 3) (inc 6))
;(+ 2 7)
;(if (= 2 0) 7 (+ (dec 2) (inc 7)))
;(+ (dec 2) (inc 7))
;(+ 1 8)
;(if (= 1 0) 8 (+ (dec 1) (inc 8)))
;(+ (dec 1) (inc 8))
;(+ 0 9)
;(if (= 0 0) 9 (+ (dec 0) (inc 9)))
;9

