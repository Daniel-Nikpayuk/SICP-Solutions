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

;; Okay, so one needs an auditory approach as well as visual to self-similar data-structures.

;; I(n)={(a,b)|a,b in N with n <= a <= b}

;; First find the increment, I(n+1) then partition I(n) into its increment and the remainder.

;; Recursive thinking shows up everywhere. Combinatorial thinking intersects. {n choose k}={n-1 choose k} + {n-1 choose k-1}.
;; self-similar. a_n=b_n+c_n*a_(n-1). This already describes a self-similar structure, but the trick is in manipulating it
;; to find a self-similar structure within (decoupling it into separate self-similar structures).

(define (pairs s t)
 (cons-stream
  (list (stream-car s) (stream-car t))
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
   (pairs (stream-cdr s) (stream-cdr t))
  )
 )
)

;; Let's visualize triples (continuous geometry). Look forward with the x-axis extending right, the y-axis extending up,
;; the z-axis extending forward. 

;; Let's construct the boundary of our self-similar data-structure:

;; On the zy-plane we have x being fixed (constant_x y z), and so it really becomes about pairs which we know form a fannded triangle
;; with base as the z-axis and hypotenuse fanning 45 degrees upward. This is the first part of our boundary.

;; The second part of our boundary is another fanned triangle with base as the hypotenuse of our first fanned triangle. It's
;; such that we may project it onto the zx-plane: it comes from what you could otherwise think of as rotating it
;; 45 degrees upward from the zx-plane so that it connects with the hypotenuse of the zy-plane triangle.
;; The hypontenuse of this second fanned triangle connecting to the z-axis creates our third boundary plane.
;; An xy-slice of the z-axis should look like the triangle that is the upper-left half of a square divided by the diagonal.

;; Our structure (triples s t u) is partitioned as follows:

;; 1) ((stream-car s) (stream-car t) (stream-car u))
;; 2) { ((stream-car s) (stream-car t) c) | c in (stream-cdr u) } : triples where 1st & 2nd coordinates are fixed.
;; 3) { ((stream-car s) b c) | b in (stream-cdr t) , c in (stream-cdr u) } : triples where 1st coordinate is fixed.
;; 4) (triples (stream-cdr s) (stream-cdr t) (stream-cdr u))

;; 1) ((stream-car s) (stream-car t) (stream-car u))
;; 2) (stream-map (lambda (z) (list (stream-car s) (stream-car t) z)) (stream-cdr u))
;; 3) (stream-map (lambda (y z) (list (stream-car s) y z)) (pairs (stream-cdr t) (stream-cdr u)))
;; 4) (triples (stream-cdr s) (stream-cdr t) (stream-cdr u))

(define (triples s t u)
 (cons-stream
  (list (stream-car s) (stream-car t) (stream-car u))
  (extended-interleave ;; extend interleave to take arbitrary number of operands.
   (stream-map (lambda (z) (list (stream-car s) (stream-car t) z)) (stream-cdr u))
   (stream-map (lambda (y z) (list (stream-car s) y z)) (pairs (stream-cdr t) (stream-cdr u)))
   (triples (stream-cdr s) (stream-cdr t) (stream-cdr u))
  )
 )
)

(triples integers integers integers)

;; Our definition is T(n) := { (n,n,n) } U { (n n z) | n < z } U { (n y z) | n < y <= z }
;; (triples integers integers integers) = U T(k) , k in N

;; ***Notice if our definition had been T(n) := { (n,n,n) } U { (n n z) | n < z } U { (n y y) | n < y } U { (n y z) | n < y < z }
;; our proof of bijection would be slightly easier---keep in mind for future strategies of desgn, but it's easy enough to translate
;; anyway.

;; Let (a b c) in N^3 with a <= b <= c. We need show a bijection:

;; First, (n,n,n) not in (n n z) or (n y z) by definition. As well, (n n z) and (n y z) are clearly disjoint.
;; Second, T(m) and T(n) are disjoint for m != n given all triples in T(m) are at least of the form (m y z) 
;; while all triples in T(n) are at least of the form (n y z).

;; This is sufficient to say each triple in U T(k) is represented no more than once by our definition.

;; consider cases: == , =< , <= , << .

;; a = b = c: (a a a) in T(a).
;; a = b < c: (a a c) in T(a).
;; a < b = c: (a b b) in T(a).
;; a < b < c: (a b c) in T(a).

;; So each monotonic triple in N^3 maps to some triple in U T(k)---our mapping is injective: let t1 != t2, then there are
;; two cases: they belong to the same class or don't. If they don't, then they map to different disjoint sets in the
;; union and so map differently (each triple is represented no more than once). If they are in the same class, then
;; they either have the same 'a' or not. If not then they map again to disjoint sets. If they are in the same 'a', (by the way
;; (a a a) is an impossibility as it would contradict t1 != t2), they still map differently. A surjection is also easy
;; to demonstrate.

;; notice how with our definition of T (terms?) we could define our self-similar structure as
;; I(n)= T(n) U I(n+1) (informal definition, proper U T(n) )
;; I(n)= (n,n,n) U (n n z) U (n y y) U (n y z) U I(n+1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(stream-filter
 (lambda (triple)
   (= (+ (car triple) (cadr triple)) (square (caddr triple))
  )
 )
 (triples integers integers integers)
)

