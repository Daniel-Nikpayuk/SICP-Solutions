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

(define (square-tree tree)
 (cond
  ((null? tree) '())
  ((not (pair? tree)) (* tree tree))
  (else
   (cons
    (square-tree (car tree))
    (square-tree (cdr tree))
   )
  )
 )
)

(define (square-tree tree)
 (map
  (lambda (subtree)
   (if (pair? subtree)
    (square-tree subtree)
    (* subtree subtree)
   )
  )
  tree
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
;(1 (4 (9 16) 25) (36 49))

