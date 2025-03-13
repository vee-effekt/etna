open Core;;
open Type;;
open Fast_gen;;
open Fast_gen.Bq_generator;;

module BQ = Fast_gen.Bq_generator;;

type t = Type.tree [@@deriving sexp, quickcheck]

let rec gen ~(lo: int) ~(hi: int) ~size =
  if lo >= hi || size <= 0 
    then return E
  else
    weighted_union [
      (1., return E);
      (float_of_int size, (
        let open BQ.Let_syntax in
        let%bind k = int_inclusive ~lo ~hi in
        let%bind v = (Nat.quickcheck_generator_parameterized 100000) in
        let%bind left = gen ~lo:lo ~hi:(k - 1) ~size:(size - 1) in
        let%bind right = gen ~lo:(k + 1) ~hi:hi ~size:(size - 1) in
        return (T (left, k, v, right))  
      ))
    ]

  let quickcheck_generator = gen ~lo:0 ~hi:100000 ~size:10