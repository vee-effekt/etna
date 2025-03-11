open Impl
open Core;;
open Impl;;
open Fast_gen;;
open Fast_gen.Bq_generator;;
open Base_quickcheck.Generator;;

module BQ = Fast_gen.Bq_generator;;

module BaseSingleBespoke : Base_quickcheck.Test.S with type t = tree = struct
  type t = tree [@@deriving sexp, quickcheck]

  let rec quickcheck_generator (lo: int) (hi: int) : tree Base_quickcheck.Generator.t =
    if lo >= hi then return E
    else
      let open Let_syntax in
      let%bind k = int_inclusive lo hi in
      let%bind v = int_inclusive lo hi in
      let%bind left = quickcheck_generator lo (k - 1) in
      let%bind right = quickcheck_generator (k + 1) hi in
      return (T (left, k, v, right))

  let quickcheck_generator = quickcheck_generator 0 1000

  let sexp_of_t = sexp_of_t
end