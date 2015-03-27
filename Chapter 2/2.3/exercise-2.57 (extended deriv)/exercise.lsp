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

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2) (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (op? op args) (and (pair? args) (eq? (car args) op)))
(define (operand1 args) (cadr args))
(define (operand2 op args) (if (null? (cdddr args)) (caddr args) (cons op (cddr args))))

(define (sum? x) (op? '+ x))
(define (addend s) (operand1 s))
(define (augend s) (operand2 '+ s))

(define (product? x) (op? '* x))
(define (multiplier p) (operand1 p))
(define (multiplicand p) (operand2 '* p))

(define (exponentiation? x) (op? '** x))
(define (base e) (operand1 e))
(define (exponent e) (caddr e))

(define (op-expand op args);; normal order evaluation?
 (if (null? args) '()
  (if (op? op (car args))
   (append (op-expand op (cdar args)) (op-expand op (cdr args)))
   (append (list (car args)) (op-expand op (cdr args)))
  )
 )
)

(define (number-reduce op id args);; puts number at front.
 (define (simplify num other remaining)
  (if (null? remaining) (cons num (reverse other))
   (if (number? (car remaining))
    (simplify (op num (car remaining)) other (cdr remaining))
    (simplify num (cons (car remaining) other) (cdr remaining))
   )
  )
 )
 (simplify id '() args)
)

(define (make-op op id op-symbol op-policy args)
 (define (op-reduce operands)
  (cond
   ((null? operands) id)
   ((null? (cdr operands)) (car operands))
   ((and (number? (car operands)) (= (car operands) id))
    (if (null? (cddr operands)) (cadr operands)
     (cons op-symbol (cdr operands))
    )
   )
   (else (op-policy operands))
  )
 )
 (if (null? args) id (op-reduce (number-reduce op id (op-expand op-symbol args))))
)

(define (make-sum . args)
 (make-op + 0 '+
  (lambda (operands) (cons '+ (if (number? (car operands)) (append (cdr operands) (list (car operands))) operands)))
  args
 )
)

(define (make-product . args)
 (make-op * 1 '*
  (lambda (operands) (if (and (number? (car operands)) (= (car operands) 0)) 0 (cons '* operands)))
  args
 )
)

(define (=number? exp num)
  (and (number? exp) (= exp num)))
(define (make-exponentiation e1 e2);too special to use make-op
 (cond
  ((=number? e2 0) 1)
  ((=number? e2 1) e1)
  ((and (number? e1) (number? e2)) (expt e1 e2))
  (else (list '** e1 e2))
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (deriv exp var)
 (cond
  ((number? exp)
   0
  )
  ((variable? exp)
   (if (same-variable? exp var) 1 0)
  )
  ((sum? exp)
   (make-sum (deriv (addend exp) var) (deriv (augend exp) var))
  )
  ((product? exp)
   (make-sum (make-product (multiplier exp) (deriv (multiplicand exp) var))
   (make-product (deriv (multiplier exp) var) (multiplicand exp)))
  )
  ((exponentiation? exp)
   (make-product (make-product (exponent exp) (make-exponentiation (base exp) (- (exponent exp) 1)))
    (deriv (base exp) var)
   )
  )
  (else (error "unknown expression type -- DERIV" exp)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deriv '(+ x 3) 'x)
(deriv '(** x 3) 'x)
(deriv '(* x y (+ x 3)) 'x)
(deriv '(+ (** x 3) (** x 2) x) 'x)

