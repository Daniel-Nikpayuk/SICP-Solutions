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

(define (old-mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; [+a,+b][+c,+d]=[+ac,+bd]
; [+a,+b][-c,+d]=[-bc,+bd]
; [+a,+b][-c,-d]=[-bc,-ad]

; [-a,+b][+c,+d]=[-ad,+bd]
; [-a,+b][-c,+d]= ?
; [-a,+b][-c,-d]=[-bc,+ac]

; [-a,-b][+c,+d]=[-ad,-bc]
; [-a,-b][-c,+d]=[-ad,+ac]
; [-a,-b][-c,-d]=[+bd,+ac]

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

(old-mul-interval	(make-interval 1 2) (make-interval 3 5))
(mul-interval		(make-interval 1 2) (make-interval 3 5))
(old-mul-interval	(make-interval 1 2) (make-interval -3 5))
(mul-interval		(make-interval 1 2) (make-interval -3 5))
(old-mul-interval	(make-interval 1 2) (make-interval -5 -3))
(mul-interval		(make-interval 1 2) (make-interval -5 -3))

(old-mul-interval	(make-interval -1 2) (make-interval 3 5))
(mul-interval		(make-interval -1 2) (make-interval 3 5))
(old-mul-interval	(make-interval -1 2) (make-interval -3 5))
(mul-interval		(make-interval -1 2) (make-interval -3 5))
(old-mul-interval	(make-interval -1 2) (make-interval -5 -3))
(mul-interval		(make-interval -1 2) (make-interval -5 -3))

(old-mul-interval	(make-interval -10 -2) (make-interval 3 5))
(mul-interval		(make-interval -10 -2) (make-interval 3 5))
(old-mul-interval	(make-interval -10 -2) (make-interval -3 5))
(mul-interval		(make-interval -10 -2) (make-interval -3 5))
(old-mul-interval	(make-interval -10 -2) (make-interval -5 -3))
(mul-interval		(make-interval -10 -2) (make-interval -5 -3))

