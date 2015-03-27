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

(list 'a 'b 'c)
;(a b c)

(list (list 'george))
;((george)), but "george" is a variable for the second list call so it's entirely dependent on the environment?

(cdr '((x1 x2) (y1 y2)))
;((y1 y2))

(cadr '((x1 x2) (y1 y2)))
;(y1 y2)

(pair? (car '(a short list)))
;false

(memq 'red '((red shoes) (blue socks)))
;false

(memq 'red '(red shoes blue socks))
;true

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

