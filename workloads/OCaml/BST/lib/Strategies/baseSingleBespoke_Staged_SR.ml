open Base;;
open Type;;
open Fast_gen;;
open Nat;;
module G = Fast_gen.Staged_generator.MakeStaged(Fast_gen.Sr_random)
open G
open Let_syntax
open Codelib;;

type t = Type.tree [@@deriving sexp, quickcheck]

let staged_quickcheck_generator (lo: int code) (hi: int code) (size: int code) : Type.tree code G.t =
  recursive (.< (.~lo, .~hi, .~size ) >.) 
  (fun go lohisz -> 
    let%bind (lo, hi, sz) = split_triple lohisz in
    let%bind should_stop = split_bool .< .~hi <= .~lo >. in
    let%bind should_stop_also = split_bool .< .~sz <= 0 >. in
    if should_stop || should_stop_also
      then return .< E >.
    else
      weighted_union [
        (.< 1. >., return .< E >.);
        ((G.C.i2f sz), (
          let%bind k = int_inclusive ~lo ~hi in
          let%bind v = (Nat.staged_quickcheck_generator_sr_t (G.C.lift 100000)) in
          let%bind left = recurse go .<(.~lo, .~k - 1, .~(G.C.pred sz)) >. in
          let%bind right = recurse go .<(.~k + 1, .~hi, .~(G.C.pred sz)) >. in
          return (.< T (.~left, .~k, .~v, .~right) >.)))
      ]
  )

let staged_code =
  staged_quickcheck_generator (G.C.lift 0) (G.C.lift 100000) (G.C.lift 10)

let quickcheck_generator = 
  G.jit ~extra_cmi_paths:["/home/ubuntu/etna2/workloads/OCaml/BST/_build/default/lib/.BST.objs/byte"] staged_code
  