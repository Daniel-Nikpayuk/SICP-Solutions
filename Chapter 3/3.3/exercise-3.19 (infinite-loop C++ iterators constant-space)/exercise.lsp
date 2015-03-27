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

;; taking my strategy from many years of C++ iterator programming.
;; not full version (only tests cdrs), but I don't know if I can do constant space on full version:
;; assumes begin is a pair---saves computations.

(define (has-cycle? x)
 (define (mem? x first-cdr last-cdr)
  (cond
   ((eq? first-cdr last-cdr) (eq? x first-cdr))
   ((eq? x first-cdr) #t)
   (else (mem? x (cdr first-cdr) last-cdr))
  )
 )
 (define (has? last-cdr)
  (cond
   ((not (pair? last-cdr)) #f)
   ((mem? (cdr last-cdr) x last-cdr) #t)
   (else (has? (cdr last-cdr)))
  )
 )
 (has? x)
)

(define (make-cycle x) (set-cdr! (last-pair x) x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define x0 (list 0))
(has-cycle? x0)

(make-cycle x0)
(has-cycle? x0)

(define x1 '(0 1 2 3))
(has-cycle? x1)

(make-cycle x1)
(has-cycle? x1)

