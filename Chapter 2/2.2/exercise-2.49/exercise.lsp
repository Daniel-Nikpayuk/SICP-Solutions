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

(define (make-vect x y) (list x y))
(define (xcor-vect z) (car z))
(define (ycor-vect z) (cadr z))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (vect-op op u v) (make-vect (op (xcor-vect u) (xcor-vect v)) (op (ycor-vect u) (ycor-vect v))))

(define (add-vect u v) (vect-op + u v))
(define (sub-vect u v) (vect-op - u v))
(define (scale-vect s u) (vect-op * (make-vect s s) u))
(define (mid-vect u v) (scale-vect 0.5 (add-vect u v)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-segment u v) (list u v))
(define (start-segment seg) (car seg))
(define (end-segment seg) (cadr seg))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-frame origin edge1 edge2) (list origin edge1 edge2))
(define (origin-frame frame) (car frame))
(define (edge1-frame frame) (cadr frame))
(define (edge2-frame frame) (caddr frame))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (primitive->painter make-segs frame)
 (let
  (
   (p0 (origin-frame frame))
   (p1 (edge1-frame frame))
   (p2 (edge2-frame frame))
   (p3 (add-vect (edge1-frame frame) (edge2-frame frame)))
  )
  (segments->painter (make-segs p0 p1 p2 p3))
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;a) segment that draws outline of designated frame:
(define (frame->painter frame)
 (define (make-segs p0 p1 p2 p3)
  (list
   (make-segment p0 p1)
   (make-segment p1 p3)
   (make-segment p3 p2)
   (make-segment p2 p0)
  )
 )
 (primitive->painter make-segs frame)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;b) segment that draws X of designated frame:
(define (x->painter frame)
 (define (make-segs p0 p1 p2 p3)
  (list
   (make-segment p0 p3)
   (make-segment p1 p2)
  )
 )
 (primitive->painter make-segs frame)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;c) segment that draws a midpoint diamond of designated frame:
(define (diamond->painter frame)
 (define (make-segs p0 p1 p2 p3)
  (list
   (make-segment (mid-segment p0 p1) (mid-segment p1 p3))
   (make-segment (mid-segment p1 p3) (mid-segment p3 p2))
   (make-segment (mid-segment p3 p2) (mid-segment p2 p0))
   (make-segment (mid-segment p2 p0) (mid-segment p0 p1))
  )
 )
 (primitive->painter make-segs frame)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;d) segment that draws the wave of designated frame:
;Yeah, I'm too lazy to do the wave painter, I won't learn anything from figuring out 17 line segments.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

