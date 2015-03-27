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

(define (make-interval a b) (cons a b))

(define (upper-bound x) (cdr x))
(define (lower-bound x) (car x))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
 (make-interval
  (- (lower-bound x) (upper-bound y))
  (- (upper-bound x) (lower-bound y))
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (mul-interval x y)
 (let
  (
   (lx (lower-bound x))
   (ux (upper-bound x))
   (ly (lower-bound y))
   (uy (upper-bound y))
  )
  (if (> lx 0)
   (if (> ly 0)
    (make-interval (* lx ly) (* ux uy))
    (if (> uy 0)
     (make-interval (* ux ly) (* ux uy))
     (make-interval (* ux ly) (* lx uy))
    )
   )
   (if (> ux 0)
    (if (> ly 0)
     (make-interval (* lx uy) (* ux uy))
     (if (> uy 0)
      (let 
       (
        (lxuy (* lx uy))
        (uxly (* ux ly))
        (lxly (* lx ly))
        (uxuy (* ux uy))
       )
       (make-interval (if (< lxuy uxly) lxuy uxly) (if (> lxly uxuy) lxly uxuy))
      )
      (make-interval (* ux ly) (* lx ly))
     )
    )
    (if (> ly 0)
     (make-interval (* lx uy) (* ux ly))
     (if (> uy 0)
      (make-interval (* lx uy) (* lx ly))
      (make-interval (* ux uy) (* lx ly))
     )
    )
   )
  )
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; p:=w/c ==> w=pc
(define (make-center-percent c p)
 (let
  (
   (w (* c p))
  )
  (make-interval (- c w) (+ c w))
 )
)
(define (percent i)
 (let
  (
   (li (lower-bound i))
   (ui (upper-bound i))
  )
  (/ (- ui li) (+ ui li))
 )
)

; [c_0-p*c_0, c_0+p*c_0]*[c_1-p*c_1, c_1+p*c_1] = [c_0c_1+2pc_0c_1+p^2c_0c_1, c_0c_1+2pc_0c_1+p^2c_0c_1]
; ~ [c_0c_1, ?

