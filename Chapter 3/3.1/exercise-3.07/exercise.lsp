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

(define (make-account sudo-password password balance)
 (define (incorrect-password amount) "Incorrect password")
 (define (withdraw amount)
  (if (>= balance amount)
   (begin (set! balance (- balance amount)) balance)
   "Insufficient funds"
  )
 )
 (define (deposit amount)
  (set! balance (+ balance amount))
  balance
 )
 (define (confirm-password bankers-password)
  (eq? bankers-password sudo-password)
 )
 (define (dispatch test-password m)
  (cond
   ((not (eq? test-password password)) incorrect-password)
   ((eq? m 'balance?) balance)
   ((eq? m 'withdraw) withdraw)
   ((eq? m 'deposit) deposit)
   ((eq? m 'confirm-password) confirm-password)
   (else (error "Unknown request -- MAKE-ACCOUNT" m))
  )
 )
 dispatch
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-joint bankers-password existing-account existing-password new-password)
 (define (dispatch test-password m)
  (if (eq? test-password new-password)
   (existing-account existing-password m)
   (existing-account (cons '0 existing-password) m); I call it this way so I don't have to redefine (incorrect-password)
  )
 )
 (if ((existing-account existing-password 'confirm-password) bankers-password) dispatch "Security Alert!")
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define acc (make-account 'bankers-password 'secret-password 100))
((acc 'secret-password 'withdraw) 40)
;60
((acc 'some-other-password 'deposit) 50)
;"Incorrect password"

(define other-acc (make-joint 'bankers-password acc 'secret-password 'other-password))
((other-acc 'other-password 'deposit) 300)
(acc 'secret-password 'balance?)

