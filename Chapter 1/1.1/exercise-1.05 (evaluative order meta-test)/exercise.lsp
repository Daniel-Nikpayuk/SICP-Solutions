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
(define (p) (p))

(define (test x y)
 (if (= x 0) 0 y)
)

;evaluation can be both expansion and reduction, but application is reduction when primitive or distribution when compound.

;normal order:
;(f 5)
;( (f (x) (sum-of-squares (+ x 1) (* x 2))) 5)
;(sum-of-squares (+ 5 1) (* 5 2))
;( (sum-of-squares (a b) (+ (square a) (square b))) (+ 5 1) (* 5 2))
;(+    (square (+ 5 1))      (square (* 5 2))  )
;(+    (* (+ 5 1) (+ 5 1))   (* (* 5 2) (* 5 2)))
;(+         (* 6 6)             (* 10 10))
;(+           36                   100)
;                    136

; If the body of a procedure is entered before an argument has been evaluated we say that the procedure is non-strict in that argument.
; If the argument is evaluated before the body of the procedure is entered we say that the procedure is strict in that argument.

;To "apply" operands:
;Think "distributive law".

;Assumption of the normal-order evaluation of an expression:

;To evaluate an expression:
;Is the operator primitive?
; a) Yes: evaluate its operands, and apply.
; b) No: expand; apply its operands; and reevaluate.

; If this is the case, then (test 0 (p)) --> (if (= 0 0) 0 (p)) --> (if #t 0 (p)) --> 0

;Assumption of the applicative-order algorithm:

;To evaluate an expression:
;Is the operator primitive?
; a) No: expand; evaluate its operands, and apply;.
; b) Yes: evaluate its operands and apply.

; If this is the case, then (test 0 (p)) --> ([(if (= x 0) x y)] 0 (p)) --> ... (forever)

