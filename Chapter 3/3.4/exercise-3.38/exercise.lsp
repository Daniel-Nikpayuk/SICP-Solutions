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

;; Peter:
(set! balance (+ balance 10))

;; Paul:
(set! balance (- balance 20))

;; Mary:
(set! balance (- balance (/ balance 2)))
;(set! balance (/ balance 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; R: Pete(R)
;; L: Pau(L)
;; Y: Mar(Y)

;; a)

;; RLY
; (100+10-20)/2=45

;; RYL
; (100+10)/2-20=35

;; LRY
; (100-20+10)/2=45

;; LYR
; (100-20)/2+10=50

;; YRL
; (100)/2+10-20=35

;; YLR
; (100)/2-20+10=40

;; 35,40,45,50

;; b)

;; To keep it simple, we will assume "left-to-right" order of evaluation:

;; R: +10
;; L: -20
;; Y: Mar(Y) --- one (- balance <M>)
;; M: (M)ary --- two (/ balance 2)

;; YMRL
; (- 100 (/ 100 2))+10-20=40
;; YMLR
; (- 100 (/ 100 2))-20+10=40
;; RYML
; 100+10=110 : (- 110 (/ 110 2))-20=35
;; LYMR
; 100-20=80 : (- 80 (/ 80 2))+10=50
;; YRML
; (- 100 <100+10=110> (/ 110 2))-20=35
;; YLMR
; (- 100 <100-20=80> (/ 80 2))+10=70

;; Point is, I know how to do it and overall the idea of what would happen if I did. Good enough, no more please.

;; RLYM
;; RYLM
;; LRYM
;; LYRM
;; YRLM
;; YLRM

;;

;; MRLY
;; MRYL
;; MLRY
;; MLYR
;; MYRL
;; MYLR

;; RMLY
;; RMYL
;; LMRY
;; LMYR
;; YMRL
;; YMLR

;; RLMY
;; RYML
;; LRMY
;; LYMR
;; YRML
;; YLMR

;; RLYM
;; RYLM
;; LRYM
;; LYRM
;; YRLM
;; YLRM

