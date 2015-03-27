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

(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (successive-merge node-set)
 (if (null? (cdr node-set)) (car node-set)
  (successive-merge
   (adjoin-set (make-code-tree (car node-set) (cadr node-set)) (cddr node-set))
  )
 )
)

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (element-of-set? x set)
 (if (null? set) #f
  (if (equal? x (car set)) #t
   (element-of-set? x (cdr set))
  )
 )
)

(define (symbol-of-left? symbol tree) (element-of-set? symbol (symbols (left-branch tree))))
(define (symbol-of-right? symbol tree) (element-of-set? symbol (symbols (right-branch tree))))

(define (encode-symbol symbol tree)
 (define (encode-1 bits current-branch)
  (cond
   ((leaf? current-branch) (reverse bits))
   ((symbol-of-left? symbol current-branch) (encode-1 (cons '0 bits) (left-branch current-branch)))
   ((symbol-of-right? symbol current-branch) (encode-1 (cons '1 bits) (right-branch current-branch)))
   (else error "bad symbol")
  )
 )
 (encode-1 '() tree)
)

(define (encode message tree)
 (if (null? message) '()
  (append (encode-symbol (car message) tree) (encode (cdr message) tree))
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define codec
 (generate-huffman-tree
 '(
   (A 2)
   (NA 16)
   (BOOM 1)
   (SHA 3)
   (GET 2)
   (YIP 9)
   (JOB 2)
   (WAH 1)
  )
 )
)

(define lyrics
'(Get a job
  Sha na na na na na na na na
  Get a job
  Sha na na na na na na na na
  Wah yip yip yip yip yip yip yip yip yip
  Sha boom
 )
)
(length lyrics)
; 36

(define encoded-lyrics (encode lyrics codec))
encoded-lyrics
(length encoded-lyrics)
; 84

; eight-symbol alphabet implies 2^8 bits = 256.
(* 100 (- 1 (/ 84.0 256)))
;(1-84/256)=67.1875%

