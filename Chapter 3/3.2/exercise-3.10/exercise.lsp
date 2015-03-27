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

(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))

; (lambda (balance) (lambda (amount) (if (>= balance amount)
;  (begin (set! balance (- balance amount)) balance) "Insufficient funds")) initial-amount)

; (lambda (amount) (if (>= 100 amount) (begin (set! balance (- 100 amount)) balance) "Insufficient funds"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define W1 (make-withdraw 100))
;Okay, so we make an environment E1 binding (initial-amount 100).
;Within E1 we make environment E2 binding (balance 100).
;Within E2 we evaluate and return the expression:
; (lambda (amount) (if (>= 100 amount) (begin (set! balance (- 100 amount)) balance) "Insufficient funds"))
;Notice it is incomplete as given the special procedure "set!".
;Otherwise we bind (W1 body) in global, where body points to E1.

(W1 50)
;We create a new E2 (the old one has been garbage collected) and bind (amount 50), then evaluate---looking up E1.

(define W2 (make-withdraw 100))
;We create a new E2 (more permenant this time) and do the same as with W1.

