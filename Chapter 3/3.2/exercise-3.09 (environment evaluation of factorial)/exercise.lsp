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

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(define (factorial n)
  (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(factorial 6)

;factorial first is the triple:
;('factorial (if (= n 1) 1 (* n (factorial (- n 1)))) environment)
;(name body environment)
;the bound environment in this case is the global environment, but there are no previous user defined bindings.

;(function a b)
;((lambda (x y) ...) a b)---we look up the binding for "function" and return the lambda expression, and evaluate
;the other subexpressions 'a' and 'b'. THEN WHENEVER we apply operands to an operator that is a lambda expression,
;that is when we create a new environment (I think!).

;recursive:

;So when (factorial 6) is called, we create a new environment with a frame with the binding (n 6), whose enclosing
;environment is that of (factorial n) which in this case is the global environment. We keep repeating this process
;each time we call (factorial) creating cascades of subenvironments to which we evaluate the body of our function.

;iterative:

;So when (factorial 6) is called, we create a subenvironment and bind (n 6), but also bind (fact-iter ...) where
;its environment is the current subenvironment. Then we evaluate (fact-iter 1 1 n), so we create another
;subenvironment binding (product 1) (counter 1) (max-count 6)---here since we evaluate (fact-iter 1 1 n) we evaluate
;its subexpressions first before applying thus the binding (max-count 6) instead of (max-count n).

;So we create our subenvironment for (fact-iter) and evaluate, do we keep creating subenvironments?
;We keep creating subenvironments, but depending on how the evaluator is implemented (I think), if we returned
;the subexpression (factorial 1 2 6) within the existing environment before we tried to evaluate it, then we would
;destroy the environment created for (factorial 1 1 6) first---thus reclaiming memory. Otherwise we would cascade
;several layers of memory at once just like for recursive, but the book pointed out the difference so it's probably
;garbage collects environments before moving on.

(define (factorial n)
  (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

;(factorial 6)
;((lambda (n) ...) 6)

;create new environment 1, bind (n 6):
;bind fact-iter here.
;evaluate here:
;(fact-iter 1 1 n)
;((lambda (product counter max-count) ...) 1 1 6)

;create new environment 2, bind (product 1) (counter 1) (max-count 6)
;evaluate here:
;(if (> counter max-count) product (fact-iter (* counter product) (+ counter 1) max-count))
;As far as I know "if" has a special evaluative form that returns:
;(fact-iter (* counter product) (+ counter 1) max-count)
;((lambda ...) 1 2 6)

;So you do have to cascade environments, but you don't have to cascade evaluations. In returning from the "if"
;that particular evaluation cycle has ended, and although a new evaluation is produced from the original evaluation
;within the same environment, a new evaluation cycle is started thus freeing resources from the previous evaluation
;cycle.

;From the information I have so far this is the interpretation, but it might be that the interpreter is optimized
;to take advantage of iterative processes. I'm not sure is the bottom line, but at least I put in the effort of
;thinking out different possibilities and at least getting use to alternative narratives---familiarization.

;but the enclosing environment when creating a new environment from a lambda is the environment in which the lambda is
;itself bound, so each new call to fact-iter has parent of factorial, so environments don't cascade anyway, they're
;siblings, only evaluative resources seem to cascade for recursion.
