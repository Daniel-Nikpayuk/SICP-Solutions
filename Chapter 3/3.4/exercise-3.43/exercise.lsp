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

;a1=10
;a2=20
;a3=30

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Claim: If exchanges are run in sequence, then after any number of exchanges, the accounts will have 10, 20, 30 in some order.

;; Proof: Mathematical induction.

;; n=0: no exchanges have occurred, and by the initial assumption is true.
;; n=>n+1: there are {3 choose 2}=3 possible exchanges: {a1,a2}, {a1,a3}, {a2,a3}.

;; {a1,a2}: 20,10
;; {a1,a3}: 30,10
;; {a2,a3}: 30,20

;; So regardless of which exchange was made, one more iteration of exchanges will preserve the amounts in some order.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; diff=a1-a2=10-20=-10
;; swap{a1,a3}=30,10
;; a1=a1-diff=30+10=40
;; a2=a2+diff=20-10=10
;; 40,10,10

;; Claim: The sum of account balances is preserved for arbitrary number of exchanges.

;; a1:=a3-(a1-a2)
;; a2:=a2+(a1-a2)
;; a3:=a1

;; a1+a2+a3=a3-a1+a2+a2+a1-a2+a1
;; =a3+a2+a1

;; I'm lazy, but you just have to go through the possible exchanges (with the possibility of overlap) and show
;; a similar manipulation.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Going down to the level of non-serialized individual transaction seems tedious. So I won't. Thanks though.

;; Is the point of this exercise to show that we can stratify the complexity of where and when and how bugs are introduced?

