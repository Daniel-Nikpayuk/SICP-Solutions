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

(define a (make-connector))
(define b (make-connector))
(set-value! a 10 'user)

(for-each-except setter inform-about-value constraints)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Draw an environment diagram showing the environment in which the above expression is evaluated.

;; set-value creates environment A binding 'a to connector, 10 to new-value and 'user to informant, and evaluates
;; operator and operands. Operands are as simple as they can be so it then evaluates operator:
;; (a 'set-value!)

;; Create environment B to evaluate this, resulting in:
;; (set-my-value) ;; this is psuedo code of what actually happens is it would return a lambda expression
;; (lambda (newval setter) ...) which points to the environment created in defining a.

;; As this expression is as simple as possible, it returns from environment B to finish evaluating
;; in environment A by applying, but in application we create a new environment pointing to the one created by defining a,
;; and the which points to A?

