open Core;;
open Base_quickcheck;;
open Base_quickcheck.Generator;;
open Impl;;
open Fast_gen;;
open Fast_gen.Bq_generator;;

module BQ = Fast_gen.Bq_generator;;

let rec gen_rbt_with_black_height ~lo ~hi ~black_height =
  let open Let_syntax in
  if black_height = 0 || lo > hi then  (* If bounds cross, return E *)
    return E
  else
    let%bind is_red = bool in
    let color = if is_red && black_height > 1 then B else R in
    let child_black_height = match color with | B -> black_height - 1 | R -> black_height in
    
    let%bind key = int_inclusive lo hi in
    let%bind value = int_inclusive lo hi in

    let left_hi = key - 1 in
    let right_lo = key + 1 in

    if left_hi < right_lo 
      then return E
    else
      let%bind left = gen_rbt_with_black_height ~lo ~hi:left_hi ~black_height:child_black_height
      in
      let%bind right = gen_rbt_with_black_height ~lo:right_lo ~hi ~black_height:child_black_height
    in
    return (T (color, left, key, value, right))

module BaseSingleBespoke : Base_quickcheck.Test.S with type t = rbt = struct
  type t = rbt [@@deriving sexp, quickcheck]

  let quickcheck_generator =
    let open Generator.Let_syntax in
    let%bind black_height = int_inclusive 1 10 in
    let%bind tree =
      gen_rbt_with_black_height
        ~lo:0
        ~hi:1000
        ~black_height
    in
    match tree with
    | E -> return E
    | T (_, l, k, v, r) -> return (T (B, l, k, v, r))

    let sexp_of_t = sexp_of_t
end
