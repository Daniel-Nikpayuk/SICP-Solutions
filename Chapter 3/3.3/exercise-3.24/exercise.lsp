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

(define (make-table same-key?)
 (define (assoc key table)
  (cond
   ((null? table) #f)
   ((same-key? key (caar table)) (car table))
   (else (assoc key (cdr table)))
  )
 )
 (let ((local-table (list '*table*)))
  (define (lookup key-1 key-2)
   (let ((subtable (assoc key-1 (cdr local-table))))
    (if subtable
     (let ((record (assoc key-2 (cdr subtable))))
      (if record
       (cdr record)
       false
      )
     )
     false
    )
   )
  )
  (define (insert! key-1 key-2 value)
   (let ((subtable (assoc key-1 (cdr local-table))))
    (if subtable
     (let ((record (assoc key-2 (cdr subtable))))
      (if record
       (set-cdr! record value)
       (set-cdr! subtable (cons (cons key-2 value) (cdr subtable)))
      )
     )
     (set-cdr! local-table (cons (list key-1 (cons key-2 value)) (cdr local-table)))
    )
   )
  'ok
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

