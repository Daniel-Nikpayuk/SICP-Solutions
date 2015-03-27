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

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    ((serializer1 (serializer2 exchange))
     account1
     account2)))

;; First of all, you've serialized exchange with respect to account2. Means whenever serialized2-exchange
;; is called, it checks if any other serialized2 procedures are currently running.

;; Next, we've serialized serialized2-exchange with respect to account1. Means whenever serialized1-exchange
;; is called, it checks if any other serialized1 procedures are currently running.

;; If you try running a serialized1,2-exchange and a serialized1,3-exchange concurrently, since both are
;; serialized by account1, the concurrency will be refused.

;; If you try running a serialized1,2-exchange and a serialized3,2-exchange, the outer layer of both exchanges
;; will start running, but as soon as both try running the inner layer the concurrency will be refused by account2.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Accounts are numbered, and each process tries to access the lower numbered account first.

;; (I'm pretty sure I did this with directed graphs in graph theory many years ago.)

;; If both exchanges try entering the lowest account first, there are 2 cases: the lowest exchange accounts are equal
;; or they not:

;; If they are equal, it means the outer layer exchange is serialized by the same account and so no deadlock is entered.

;; If they are different, then we consider the possibilities of the second accounts. If they are equal, then no deadlock is entered.

;; If they are different, there are a few possibilities. If one of the second accounts is equal to the first account of
;; the other exchange, then it's impossible for the other second account to be the first (contradiction of order) thus preventing
;; the known deadlock. Since that's the case, the serialization will be prevented as the other second is some who-cares account.
;; In the case neither equals the first of the other, then nothing intersects and there's no need to wait (concurrency is allowed).

(define (serialized-exchange account1 account2)
 (let
  (
   (serializer1 (account1 'serializer))
   (serializer2 (account2 'serializer))
  )
  (if (< (account1 'number) (account2 'number))
   ((serializer1 (serializer2 exchange)) account1 account2)
   ((serializer2 (serializer1 exchange)) account2 account1)
  )
 )
)

;; I'm too lazy to redefine (make-account) to include the 'number message as an option. It's pretty straight-forward.

