open Core;;
open Base_quickcheck;;
open Base_quickcheck.Generator;;
open Impl;;
open Fast_gen;;
open Fast_gen.Bq_generator;;

module BQ = Fast_gen.Bq_generator;;

let rec quickcheck_generator_bst (lo: int) (hi: int) : rbt Base_quickcheck.Generator.t =
  if lo >= hi then return E
  else
    let open Let_syntax in
    let%bind k = int_inclusive lo hi in
    let%bind v = int_inclusive lo hi in
    let%bind left = quickcheck_generator_bst lo (k - 1) in
    let%bind right = quickcheck_generator_bst (k + 1) hi in
    return (T (R, left, k, v, right))

module BaseSingleBespoke : Base_quickcheck.Test.S with type t = rbt = struct
  type t = rbt [@@deriving sexp, quickcheck]

  let rec quickcheck_generator ~black_height ~bst = 
    bst
  let quickcheck_generator =
    let open Generator.Let_syntax in
    let%bind black_height = int_inclusive 1 3 in
    let%bind bst = quickcheck_generator_bst 0 1000 in
    quickcheck_generator ~black_height ~bst

    let sexp_of_t = sexp_of_t
end
