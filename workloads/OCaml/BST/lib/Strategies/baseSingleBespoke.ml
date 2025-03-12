open Core;;
open Type;;
open Fast_gen;;
open Fast_gen.Bq_generator;;

module BQ = Fast_gen.Bq_generator;;

  type t = Type.tree [@@deriving sexp, quickcheck]

  let rec staged_quickcheck_generator (lo: int) (hi: int) =
    if 
      lo >= hi then return E
    else
      let open Let_syntax in
      let range = hi - lo in
      let%bind k = Nat.quickcheck_generator in
      let k = (lo + (k mod range)) in
      let%bind v = Nat.quickcheck_generator in
      let%bind left = staged_quickcheck_generator lo (k - 1) in
      let%bind right = staged_quickcheck_generator (k + 1) hi in
      return (T (left, k, v, right))
  
  let quickcheck_generator = staged_quickcheck_generator 0 1000