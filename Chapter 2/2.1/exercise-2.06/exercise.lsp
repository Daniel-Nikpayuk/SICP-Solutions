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

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 0 := lfx.x
; n+1 := lfx.fnfx

; 1 = 0+1 = lfx.f(lgy.y)fx = lfx.f(x) = lfx.fx

(define one (lambda (f) (lambda (x) (f x))))

; 2 = 1+1 = lfx.f(lgy.gy)fx = lfx.f(fx) = lfx.2fx

(define two (lambda (f) (lambda (x) (f f x))))

; n := lfx.ff...f{...n times}x =  lfx.nfx

; n+2 = (n+1)+1 = lfx.f(n+1)fx = lfx.f(lgy.gngy)fx = lfx.f(fnfx) = lfx.2fnfx
; n+3 = (n+2)+1 = lfx.f(n+2)fx = lfx.f(lgy.2gngy)fx = lfx.f(2fnfx) = lfx.3fnfx
; n+m := lfx.mfnfx

