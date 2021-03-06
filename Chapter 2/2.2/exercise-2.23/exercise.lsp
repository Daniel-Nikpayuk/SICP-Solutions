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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (for-each rule linked)
 (define (iter l)
  (cond
   ((null? l)
    (newline)
    (display #t)
   )
   (else
    (rule (car l))
    (iter (cdr l))
   )
  )
 )
 (iter linked)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

