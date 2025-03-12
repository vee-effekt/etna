open Type
open Fast_gen;;
module G = Fast_gen.Staged_generator.MakeStaged(Fast_gen.Sr_random)
open G
open Let_syntax

let blacken_correct (t : rbt) : rbt =
  match t with E -> E | T (_, a, k, v, b) -> T (B, a, k, v, b)

let balance_correct (col : color) (tl : rbt) (k : 'a) (v : 'b)
    (tr : rbt) : rbt =
  match (col, tl, k, v, tr) with
  | B, T (R, T (R, a, x, vx, b), y, vy, c), z, vz, d ->
      T (R, T (B, a, x, vx, b), y, vy, T (B, c, z, vz, d))
  | B, T (R, a, x, vx, T (R, b, y, vy, c)), z, vz, d ->
      T (R, T (B, a, x, vx, b), y, vy, T (B, c, z, vz, d))
  | B, a, x, vx, T (R, T (R, b, y, vy, c), z, vz, d) ->
      T (R, T (B, a, x, vx, b), y, vy, T (B, c, z, vz, d))
  | B, a, x, vx, T (R, b, y, vy, T (R, c, z, vz, d)) ->
      T (R, T (B, a, x, vx, b), y, vy, T (B, c, z, vz, d))
  | rb, a, x, vx, b -> T (rb, a, x, vx, b)

let insert_correct s (k, vk) : rbt =
  let rec ins x vx t =
    match t with
    | E -> T (R, E, x, vx, E)
    | T (rb, a, y, vy, b) ->
        if x < y then balance_correct rb (ins x vx a) y vy b
        else if x > y then balance_correct rb a y vy (ins x vx b)
        else T (rb, a, y, vx, b)
  in
  blacken_correct (ins k vk s)

let repeat_insert (lst : (int * 'a) list) : rbt =
  List.fold_left insert_correct E lst

type t = rbt [@@deriving sexp, quickcheck]
  
let staged_code =
  bind 
    (list (map2 Nat.staged_quickcheck_generator_sr_t Nat.staged_quickcheck_generator_sr_t 
              ~f:(fun x y -> G.C.pair x y)))
    ~f:(fun l -> return .< repeat_insert .~l >.)
    
let quickcheck_generator = G.jit ~extra_cmi_paths:["/home/ubuntu/etna2/workloads/OCaml/RBT/_build/default/lib/.RBT.objs/byte"] staged_code
