open Base
open Fast_gen;;
open Codelib;;
open Fast_gen.Codecps;;

module G = Fast_gen.Bq_generator
open G
open Base
open Let_syntax
open Type_defn


type t = expr [@@deriving quickcheck, sexp]
let rec equal_typ x y =
  match x, y with
  | TBool, TBool -> true
  | TFun (x1, x2), TFun (y1, y2) -> equal_typ x1 y1 && equal_typ x2 y2
  | _ -> false   

let genTyp : Type_defn.typ G.t =
  recursive () @@ fun go _ ->
    bind size ~f:(fun n ->
      if n <= 1 then return TBool
      else weighted_union [
        1.0, return TBool;
        Int.to_float n,
          bind (with_size ~size_c:(n/2) (recurse go ())) ~f:(fun t1 ->
          bind (with_size ~size_c:(n/2) (recurse go ())) ~f:(fun t2 ->
            return (TFun (t1,t2))
          ))
      ])

let genVar g t : Type_defn.expr option G.t =
  let vars = List.filter_mapi ~f:(fun i t' -> if equal_typ t t' then Some (Some (Var i)) else None) g in
  match vars with
  | [] -> return None
  | _ -> of_list vars

let genConst t : Type_defn.expr G.t =
  recursive t @@ fun go t ->
    match t with
    | TBool -> map ~f:(fun b -> Bool b) bool
    | TFun(t1,t2) -> map ~f:(fun e -> Abs(t1,e)) (recurse go t2)

let genExactExpr n g t =
  recursive (n,g,t) @@ fun go (n,g,t) ->
    bind (genVar g t) ~f:(function
      | Some e -> return e
      | None ->
          if n <= 1 then genConst t else
            match t with
            | TFun (t1,t2) -> map ~f:(fun e -> Abs(t1,e)) (recurse go (n - 1,t1 :: g,t2))
            | _ -> bind genTyp ~f:(fun t' ->
                bind (recurse go (n/2,g,TFun(t',t))) ~f:(fun e1 ->
                bind (recurse go (n/2,g,t')) ~f:(fun e2 ->
                  return (App (e1,e2))
                )))
    )

let genExpr =
  bind size ~f:(fun n ->
    bind genTyp ~f:(fun t ->
      genExactExpr n [] t))

let quickcheck_generator_expr = genExpr