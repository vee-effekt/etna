open Base;;
open Type;;
open Fast_gen;;
open Nat;;
module G = Fast_gen.Staged_generator.MakeStaged(Fast_gen.C_random)
open G
open Let_syntax
open Codelib;;

type t = Type.tree [@@deriving sexp, quickcheck]

let staged_quickcheck_generator (lo: int code) (hi: int code) (size: int code) : Type.tree code G.t =
  recursive (.< (.~lo, .~hi, .~size ) >.) 
  (fun go lohisz -> 
    let%bind (lo, hi, sz) = split_triple lohisz in
    let%bind should_stop = split_bool .< .~hi <= .~lo || .~sz <= 1 >. in
    if should_stop
      then return .< E >.
    else
      weighted_union [
        (.< 1. >., return .< E >.);
        ((G.C.i2f sz), (
          let%bind k = int_inclusive ~lo ~hi in
          let%bind v = Nat.staged_quickcheck_generator_c_t in
          let%bind left = recurse go .<(.~lo, .~k - 1, .~(G.C.div2 sz)) >. in
          let%bind right = recurse go .<(.~k + 1, .~hi, .~(G.C.div2 sz)) >. in
          return (.< T (.~left, .~k, .~v, .~right) >.)))
      ]
  )

let staged_code =
  staged_quickcheck_generator (G.C.lift 0) (G.C.lift 1000) (G.C.lift 10)

let quickcheck_generator = 
  G.jit ~extra_cmi_paths:["/home/ubuntu/etna2/workloads/OCaml/BST/_build/default/lib/.BST.objs/byte"] staged_code
  