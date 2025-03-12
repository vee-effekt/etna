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
let genTyp : Type_defn.typ G.t =
 G.recursive () @@ fun go _ ->
   G.bind G.size ~f:(fun n ->
      if n <= 1 then G.return TBool
      else G.weighted_union [
        1.0, G.return TBool;
        Int.to_float n,
         G.bind (G.with_size ~size_c:(n/2) (G.recurse go ())) ~f:(fun t1 ->
         G.bind (G.with_size ~size_c:(n/2) (G.recurse go ())) ~f:(fun t2 ->
            G.return (TFun (t1,t2))
          ))
      ])

let genVar g t : Type_defn.expr option G.t =
  let vars = List.filter_mapi ~f:(fun i t' -> if Type_defn.equal t t' then Some (Some (Var i)) else None) g in
  match vars with
  | [] -> G.return None
  | _ -> of_list vars

let genConst t : Type_defn.expr G.t =
 G.recursive t @@ fun go t ->
    match t with
    | TBool -> map ~f:(fun b -> Bool b) bool
    | TFun(t1,t2) -> map ~f:(fun e -> Abs(t1,e)) (recurse go t2)

let genExactExpr n g t =
 G.recursive (n,g,t) @@ fun go (n,g,t) ->
   G.bind (genVar g t) ~f:(function
      | Some e -> G.return e
      | None ->
          if n <= 1 then genConst t else
            match t with
            | TFun (t1,t2) -> map ~f:(fun e -> Abs(t1,e)) (G.recurse go (n - 1,t1 :: g,t2))
            | _ -> G.bind genTyp ~f:(fun t' ->
               G.bind (G.recurse go (n/2,g,TFun(t',t))) ~f:(fun e1 ->
               G.bind (G.recurse go (n/2,g,t')) ~f:(fun e2 ->
                  G.return (App (e1,e2))
                )))
    )

let genExpr =
 G.bind G.size ~f:(fun n ->
   G.bind genTyp ~f:(fun t ->
      genExactExpr n [] t))

let quickcheck_generator_expr = genExpr