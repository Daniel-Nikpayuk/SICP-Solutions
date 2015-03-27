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

;; hasn't actually been tested.

(define (make-table same-key?)
 (define (singleton? keys) (null? (cdr keys)))
 (define (assoc key table)
  (cond
   ((null? table) #f)
   ((same-key? key (caar table)) (car table))
   (else (assoc key (cdr table)))
  )
 )
 (let ((local-table (list '*table*)))
;; alternate version using map-recurse paradigm.
; (define (lookup . keys)
;  (define (filter-true l)
;   (cond
;    ((null? l) #f)
;    ((car l) (car l))
;    (else (filter-true (cdr l)))
;   )
;  )
;  (define (recurse table keys)
;   (if (null? keys) table
;    (map (lambda (subtable) (if (same-key? (car keys) (car subtable)) (recurse subtable (cdr keys)) #f)) table)
;   )
;  )
;  (filter-true (recurse (cdr local-table) keys))
; )
;;assumes keys is a non-empty pair, type checking delegated elsewhere.
  (define (lookup . keys)
   (define (recurse table keys)
    (let ((subtable (assoc (car keys) table)))
     (cond
      ((not subtable) #f)
      ((singleton? keys) subtable)
      (else (lookup subtable (cdr keys)))
     )
    )
   )
   (recurse (cdr local-table) keys)
  )
  (define (insert! value . keys)
   (define (make-insert keys)
    (cond
     ((null? keys) (cons value '()))
     (else (cons (car keys) (make-insert (cdr keys))))
    )
   )
   (define (recurse table keys)
    (let ((subtable (assoc (car keys) table)))
     (cond
      ((not subtable) 
       (set! table (cons (make-insert keys) table))
      )
      ((singleton? keys)
       (set-cdr! subtable value)
      )
      (else (recurse subtable (cdr keys)))
     )
    )
   )
   (if (assoc (car keys) local-table)
    (recurse (cdr local-table) keys)
    (set-cdr! local-table (cons (make-insert keys) (cdr local-table)))
   )
  )
  (define (dispatch m)
   (cond
    ((eq? m 'lookup-proc) lookup)
    ((eq? m 'insert-proc!) insert!)
    (else (error "Unknown operation -- TABLE" m))
   )
  )
  dispatch
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

