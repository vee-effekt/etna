open Core;;
open Base_quickcheck;;
open Base_quickcheck.Generator;;
open Impl;;
open Fast_gen;;
open Fast_gen.Bq_generator;;

module BQ = Fast_gen.Bq_generator;;

let rec gen_rbt_with_black_height ~lo ~hi ~black_height ~parent ~root =
  let open Let_syntax in
  if black_height = 0 || lo > hi then  (* If bounds cross, return E *)
    return E
  else
    let%bind is_red = bool in
    let color =
      if is_red && black_height > 1 && not (Poly.(=) parent R) && not root then R
      else B
    in

    (* Ensure consistent black height propagation *)
    let next_black_height = if Poly.(=) color B then (black_height - 1) else black_height in

    let%bind key = int_inclusive lo hi in
    let%bind value = int_inclusive lo hi in

    let left_hi = key - 1 in
    let right_lo = key + 1 in

    let%bind left =
      if lo > left_hi then
        if black_height > 1 then return (T (B, E, left_hi, value, E))
        else return E
      else gen_rbt_with_black_height ~lo ~hi:left_hi ~black_height:next_black_height ~parent:color ~root:false
    in
    let%bind right =
      if right_lo > hi then
        if black_height > 1 then return (T (B, E, right_lo, value, E))
        else return E
      else gen_rbt_with_black_height ~lo:right_lo ~hi ~black_height:next_black_height ~parent:color ~root:false
    in

    return (T (color, left, key, value, right))

module BaseSingleBespoke : Base_quickcheck.Test.S with type t = rbt = struct
  type t = rbt [@@deriving sexp, quickcheck]

  let quickcheck_generator =
    let open Generator.Let_syntax in
    let%bind black_height = int_inclusive 1 2 in
    gen_rbt_with_black_height
      ~lo:0
      ~hi:1000
      ~black_height
      ~parent:B
      ~root:true

    let sexp_of_t = sexp_of_t
end
