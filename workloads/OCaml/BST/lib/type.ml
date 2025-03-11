open Core;;
open Ppx_staged;;
open Nat;;
(* module G = Fast_gen.Staged_generator.MakeStaged(Fast_gen.C_sr_dropin_random) *)

(* let quickcheck_generator_int_new = let open Base_quickcheck.Generator in *)
  (* bind int ~f:(fun i -> return (i mod 1000)) *)

type tree =
| E
| T of tree * Nat.t * Nat.t * tree [@@deriving quickcheck, sexp]
