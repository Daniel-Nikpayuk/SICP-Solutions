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

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right) (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set) 
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; a) proof by induction:

;; case: tree == '()
;; (tree->list-1 '()) == '()
;; (tree->list-2 '()) == '()

;; case: subtree ==> tree
;; tree == (entry left right)
;; (tree->list-1 tree) == (append (tree->list1 left) (cons entry (tree->list-1 right)))
;; == (append (tree->list1 left) (entry) (tree->list-1 right))
;; == (append (tree->list2 left) (entry) (tree->list-2 right))

;; == (copy-to-list left (entry (tree->list-2 right)))
;; == (copy-to-list left (cons entry (copy-to-list right '())))
;; (copy-to-list tree '()) == (tree->list-2 tree)

;; Does (copy-to-list tree other) == (append (copy-to-list tree '()) other)
;; tree == '() ==> (copy-to-list '() other) == other == (append '() other) == (append (copy-to-list '() '()) other)
;; Assume subtree ==> tree.
;; (copy-to-list tree other) == (copy-to-list left (cons entry (copy-to-list right other)))
;; == (copy-to-list left (cons entry (append (copy-to-list right '()) other)))
;; == (copy-to-list left (append (entry) (copy-to-list right '()) other))
;; == (append (copy-to-list left '()) (append (entry) (copy-to-list right '()) other))
;; == (append (copy-to-list left '()) (entry) (copy-to-list right '()) other)
;; == (append (copy-to-list left '()) (entry) (copy-to-list right '()) other)

;; now I have to show (copy-to-list left '()) (entry) (copy-to-list right '()) == (copy-to-list tree '()) ? Too much work!
;; I don't care that much. The point is I know how if I have to.

(define tree1 (make-tree 7 (make-tree 3 (make-tree 1 '() '()) (make-tree 5 '() '())) (make-tree 9 '() (make-tree 11 '() '()))))
(define tree2 (make-tree 3 (make-tree 1 '() '()) (make-tree 7 (make-tree 5 '() '()) (make-tree 9 '() (make-tree 11 '() '())))))
(define tree3 (make-tree 5 (make-tree 3 (make-tree 1 '() '()) '()) (make-tree 9 (make-tree 7 '() '()) (make-tree 11 '() '()))))

(tree->list-1 tree1)
(tree->list-2 tree1)

(tree->list-1 tree2)
(tree->list-2 tree2)

(tree->list-1 tree3)
(tree->list-2 tree3)

;; all produce (1 3 5 7 9 11)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; b)

;; No. The one tha that doesn't use "append" grows more slowly as there are many extra hidden steps within.
;; the iterative process grows more slowly.

