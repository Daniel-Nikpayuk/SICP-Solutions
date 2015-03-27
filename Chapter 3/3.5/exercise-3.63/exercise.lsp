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

(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream x))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; I am recognizing that evaluating the efficiency of streams might
;; be more difficult. It might just be that I'm not use to it.

;; (cons-stream 1.0 ((sqrt-improve 1.0 x) ...))
;; (cons-stream 1.0 (sqrt-improve 1.0 x) ((sqrt-improve (cadr (sqrt-stream x)) x) ...))
;; (cons-stream 1.0 (sqrt-improve 1.0 x) (sqrt-improve (cadr (sqrt-stream x)) x) ((sqrt-improve (caddr (sqrt-stream x)) x)...))

;; The above derivation is technically incorrect, but intuitively demonstrates our stream would in the end look like this:

;; (sqrt-stream x) = (1.0 (sqrt-improve (stream-ref (sqrt-stream x) 0)) (sqrt-improve (stream-ref (sqrt-stream x) 1)))
;; so each term would look like (sqrt-improve (stream-ref (sqrt-stream x) k))
;; and to derive each k would mean referencing each previous one each time, so the number of computations would be O(n),
;; aside from the single calculation of sqrt-improve at the end.

;; I suspect it would be O(n^2) on top of recalculating sqrt-improve each time---if we didn't memoize it.
;; I really need to learn and practice computational complexity. Even the SICP Solutions site doesn't have an answer
;; (I'll have to come back to this one when I've done it and give the answer to the SICP Solutions...)

(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))

;; *** Also note this definition is incomplete---at least in regards to the mit implementation as well as it's missing
;; its finally parenthesis. It's incomplete because it needs to specifically return guesses which it doesn't. This
;; much though might be a matter of scheme implementation.

;; When you call sqrt-stream for the first time for a given x you create a closure environment with a local variable guesses,
;; you return guesses as a stream. In practice, this guesses will be bound to some variable, and when one needs a certain
;; level of accuracy, they stream-ref that position of accuracy in the guesses stream they have bound.

;; When stream-cdring guesses, they reference the closure environment and stream-map the first position of guesses,
;; returning a stream with the second element of guesses and the promise to stream-map the second element of guesses 
;; as the third. As the promise is carried out, it stream-maps the second to get the third. This process is repeated,
;; so that every next is dependent only on the previous and sqrt-improve.

;; With the first---and claimed less efficient one---no persistent local environment is created and the stream is bound
;; in the main environment to which sqrt-improve was called. When it is stream-refed for example, a call to (sqrt-stream x)
;; starts anew, and each stream-cdr call has to re-evaluate all over again as stated above?

;; in our delay, we petrify the expression (stream-cdr (sqrt-stream x))

; (sqrt-stream x)
; (1.0 (stream-map (lambda (guess) (sqrt-improve guess x)) (sqrt-stream x)))
; (1.0 (stream-map (lambda (guess) (sqrt-improve guess x)) (1.0 (...))))
; (1.0 (sqrt-improve 1.0 x) (delay (stream-map lambda (stream-map lambda (sqrt-stream x)))) )
; (1.0 (sqrt-improve 1.0 x) (stream-map lambda (stream-map lambda (sqrt-stream x))) )
; (1.0 (sqrt-improve 1.0 x) (sqrt-improve (stream-map lambda (sqrt-stream x)) x) )
; (1.0 (sqrt-improve 1.0 x) (sqrt-improve (sqrt-improve (sqrt-stream x) x) x) )

;; So yeah, each time you're recalling it from scratch.

;; It might be useful looking at this from the signal diagram lens and compare to see if you can more easily see the
;; redundancy in those diagrams than here. Basically in the long run we need a better semiotic space to interact with
;; flow of computations.

