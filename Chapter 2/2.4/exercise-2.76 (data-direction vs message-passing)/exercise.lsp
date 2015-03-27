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

;; generic operations with explicit dispatch,
;; data-directed style, and
;; message-passing-style.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; I'm not sure to be honest:
;; The "friendliness" of a given paradigm here I think is determined by how well it modularizes name conflicts.
;; If for a given type, you want to add a new operation, a message passing structure prioritizes this.
;; If for a given operation, you want to add a new type, a data directed structure prioritizes this.

;; It is "data directed" because the dispatch is directed by the data.
;; It is "message passing" because the dispatch is directed by the message (operator).

;; Here's what I know:

;; Generic privileges neither. But from generic stems two alternative modularizations. Both modularizations
;; here can be abstracted as "dispatch" modularizations. Basically such a thing happens when you have a context
;; with a large diversity of both procedures and types, and you're looking to "pattern recognize". How do you
;; organize when you recognize patterns? You factor out by either procedure, or type. In the case you factor
;; out by procedure, you are creating generic operations, and you modularize this further by data-direction
;; using operator tables, so that not only is it modular, but is also additive. The alternative is to factor
;; out by type, in which case you are creating generic types(?) also called message passing, and you may then
;; modularize further for additivity by creating type tables though the SICP Textbook does not go this far.

;; So I guess for data-direction, because you organize the larger context by means of operators, you privilege
;; the mobility of types (frequently adding new types). To add more operators means to change the underlying
;; organizing structure.
;; A similar argument works as to why message passing is better when privileging the mobility of operators.

;; These realizations lead to the interesting idea of procedure coercion when one procedure can be seen as
;; a natural extension of another.

