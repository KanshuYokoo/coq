(************************************************************************)
(*         *   The Coq Proof Assistant / The Coq Development Team       *)
(*  v      *         Copyright INRIA, CNRS and contributors             *)
(* <O___,, * (see version control and CREDITS file for authors & dates) *)
(*   \VV/  **************************************************************)
(*    //   *    This file is distributed under the terms of the         *)
(*         *     GNU Lesser General Public License Version 2.1          *)
(*         *     (see LICENSE file for the text of the license)         *)
(************************************************************************)

module Mc = Micromega

val use_simplex : bool ref
(** [use_simplex] is bound to the Coq option Simplex.
    If set, use the Simplex method, otherwise use Fourier *)

type ('prf, 'model) res = Prf of 'prf | Model of 'model | Unknown
type zres = (Mc.zArithProof, int * Mc.z list) res
type qres = (Mc.q Mc.psatz, int * Mc.q list) res

val dump_file : string option ref
(** [dump_file] is bound to the Coq option Dump Arith.
    If set to some [file], arithmetic goals are dumped in filexxx.v *)

val q_cert_of_pos : Sos_types.positivstellensatz -> Mc.q Mc.psatz
(** [q_cert_of_pos prf] converts a Sos proof into a rational Coq proof *)

val z_cert_of_pos : Sos_types.positivstellensatz -> Mc.z Mc.psatz
(** [z_cert_of_pos prf] converts a Sos proof into an integer Coq proof *)

val lia : bool -> int -> (Mc.z Mc.pExpr * Mc.op1) list -> zres
(** [lia enum depth sys] generates an unsat proof for the linear constraints in [sys].
    If the Simplex option is set, any failure to find a proof should be considered as a bug. *)

val nlia : bool -> int -> (Mc.z Mc.pExpr * Mc.op1) list -> zres
(** [nlia enum depth sys] generates an unsat proof for the non-linear constraints in [sys].
    The solver is incomplete -- the problem is undecidable *)

val linear_prover_with_cert : int -> (Mc.q Mc.pExpr * Mc.op1) list -> qres
(** [linear_prover_with_cert depth sys] generates an unsat proof for the linear constraints in [sys].
    Over the rationals, the solver is complete. *)

val nlinear_prover : int -> (Mc.q Mc.pExpr * Mc.op1) list -> qres
(** [nlinear depth sys] generates an unsat proof for the non-linear constraints in [sys].
    The solver is incompete -- the problem is decidable. *)
