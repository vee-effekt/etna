open Core;;
open Type;;
open Fast_gen;;
open Nat;;
module G = Fast_gen.Staged_generator.MakeStaged(Fast_gen.Sr_random)
open G

type t = Type.tree [@@deriving sexp, quickcheck]

let rec staged_quickcheck_generator (lo: int G.c) (hi: int G.c) =
  let open Let_syntax in
  let%bind stop = .< .~lo >= .~hi >. in
  if stop
    then return .< E >.
  else
    let%bind k = Nat.staged_quickcheck_generator_range_sr_t ~lo ~hi in
    let%bind v = Nat.staged_quickcheck_generator_sr_t in
    let%bind left = staged_quickcheck_generator lo (G.C.minus k (G.C.lift 1)) in
    let%bind right = staged_quickcheck_generator (G.C.plus k (G.C.lift 1)) hi in
    return (.< T (.~left, .~k, .~v, .~right) >.)

let staged_code =
  staged_quickcheck_generator (G.C.lift 0) (G.C.lift 1000)

let quickcheck_generator = 
  G.jit ~extra_cmi_paths:["/home/ubuntu/etna2/workloads/OCaml/BST/_build/default/lib/.BST.objs/byte"] staged_code
  