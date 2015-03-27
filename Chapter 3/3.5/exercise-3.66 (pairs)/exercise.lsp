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

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

(pairs integers integers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Let I(n):=(n n+1 n+2 n+2 ...)
;; Let P(n):=(pairs I(n) I(n))
;; P(n)=( (n,n) (interleave ( (n,n+1) (n,n+2) (n,n+3) ...) P(n+1)) )
;; Let P(n,k) be the kth position of P(n), then:

;; P(n,1)    = (n,n)
;; P(n,2k)   = (n,n+k) for k >= 1
;; P(n,2k+1) = P(n+1,k) for k >= 1

;; from above;

;; P(n,k)=P(n-1,2k+1) for k >= 1
;;       =P(n-s,2^s(k+1)-1) 1 <= s <= n-1
;;       =P(1,2^(n-1)(k+1)-1)

;; then:

;; (n,n)=P(1,2^n-1) for n >= 1
;; (m,n)=P(1,2^(m-1)(2(n-m)+1)-1) for 1 <= m < n

;; Notice that P(1,k) is the kth position of P(1) which itself is (pairs integers integers).

;; Thus then, for example, (1,100) is the 2^(1-1)(2(100-1)+1)-1=198th position---197 pairs come before,
;; while (99,100) is the 2^(99-1)(2(100-99)+1)-1=3*2^98-1th position, so 3*2^98-2 pairs come before.
;; As well, (100,100) is the 2^100-1th position, and so 2^100-2 pairs come before.

