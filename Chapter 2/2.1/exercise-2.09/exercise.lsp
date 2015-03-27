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

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (sub-interval x y)
 (make-interval
  (- (lower-bound x) (upper-bound y))
  (- (upper-bound x) (lower-bound y))
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (width-interval x)
 (/ (- (upper-bound x) (lower-bound x)) 2.0)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;[a,b]+[c,d]:=[a+c,b+d]
;w[a+c,b+d]=(b+d-a-c)/2=(b-a)/2+(d-c)/2=w[a,b]+w[c,d]

;[c,d]-[a,b]:=[c-b,d-a]
;w[c-b,d-a]=(d-a-c+b)/2=(d-c)/2+(b-a)/2=w[c,d]+w[a,b]
;[c,d]-[a,b]=[c,d]+(-[b,a])
;w([c,d]-[a,b])=w[c,d]+w[-a,-b]
;w[-a,-b]=(-a-(-b))/2=(b-a)/2=w[a,b]

;[3,4]*[1,2]~{3,6,4,8}~[3,8]
;w([3,4]*[1,2])=w[3,8]=2.5
;[-3,-2]*[1,2]~{-3,-6,-2,-4}~[-6,-2]
;w([-3,-2]*[1,2])=w[-6,-2]=2

