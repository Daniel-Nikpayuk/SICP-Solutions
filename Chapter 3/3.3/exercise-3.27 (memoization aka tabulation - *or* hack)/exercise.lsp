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

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

;; Notice how memo-fib is not defined itself as a function
;; but is as a label assigned a function returned by memoize.
(define memo-fib
  (memoize (lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))

;; Notice the "hack" used with "or". Does it mean "or" is defined such that the logicand it tests,
;; if it's not false, it returns that exact logicand?
(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Note that memoize does not work directly with recursive functions,
;; but requires a redefinition to include memoize within the recursive definition itself.
;; Otherwise one loses much of the savings that memoize is suppose to support in the first place.

;;(memo-fib 3):

;; First recall the expression (define (f a b c) ...) is syntactic sugar for (define f (lambda (a b c) ...)).

;; With this in mind, when we define "memo-fib", we evaluate (memoize (lambda (n) ...)) to reduce it as much as possible.
;; When doing so we end up creating (through lexical closure) a persistent subenvironment 'A' which holds the table and
;; a bind of 'f'---(lambda (n) ...), and we return (lambda (x) ...) which is the simplest binding for (memo-fib).
;; As (lambda (x) ...) was created in environment A that is where it points.

;; When we call (memo-fib 3), we call (lambda (x) ...) creating a new environment 'B' binding 3 to x. We evaluate,
;; and finding '3' not to be in our persistent table (stored in environment A) we compute (f x) which is in fact
;; ((lambda (n) ...) 3). We create an environment 'C' and bind 3 to n. In this environment we find ourselves
;; needing to evaluate (memo-fib 2) and (memo-fib 1).

;; Next we run the same process over again adding 0,1,2 and eventually 3 into our table. The very first time
;; we calculate each of these values with complexity the same as fib---slightly larger with the memoize overhead,
;; but when we call (memo-fib 3) again for example, we the complexity is only dependent upon the complexity of the
;; lookup table which if implemented as a list is O(n).

;; Finally, if we have calculated (memo-fib 'n') for some 'n', when we calculate (memo-fib 'n+1') for the first time,
;; the complexity will also be O(n). Since it isn't in the table, we end up calling (memo-fib n) and (memo-fib n-1)
;; which are known in the table and so are O(n).

;; If we had instead defined memo-fib as (memoize fib), we would still gain the savings for lookups that already exist,
;; but when calculating for the first time it would always be equivalent to calling fib.

