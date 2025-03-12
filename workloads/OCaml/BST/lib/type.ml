open Core;;
open Ppx_staged;;
open Nat;;
module G = Fast_gen.Staged_generator.MakeStaged(Fast_gen.C_sr_dropin_random)

type tree =
| E
| T of tree * (Nat.t [@wh.randomness "sr_t"]) * (Nat.t [@wh.randomness "sr_t"]) * tree [@@deriving quickcheck, sexp]
