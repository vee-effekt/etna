open Codelib;;
open Fast_gen
open Base
open Type_defn;;

let rec equal_typ x y =
  match x, y with
  | TBool, TBool -> true
  | TFun (x1, x2), TFun (y1, y2) -> equal_typ x1 y1 && equal_typ x2 y2
  | _ -> false   

module M : Fast_gen.Splittable.S = struct
  type nonrec t = expr
  type nonrec f = VarF of int code | BoolF of bool code | AbsF of (typ code) * (expr code) | AppF of (expr code) * (expr code)
  
  let split (e : t code) : f Codecps.t = {
    code_gen = fun k -> .<
      match .~e with
      | Var x -> .~(k (VarF .<x>.))
      | Bool b -> .~(k (BoolF .<b>.))
      | Abs (t,e') -> .~(k (AbsF (.<t>.,.<e'>.)))
      | App (e,e') -> .~(k (AppF (.<e>.,.<e'>.)))
    >.
  }
end

module MT : Fast_gen.Splittable.S with type t = typ and type f = [`TBool | `TFun of (typ code) * (typ code)] = struct
  type nonrec t = typ
  type nonrec f = [`TBool | `TFun of (typ code) * (typ code)]
  
  let split (e : t code) : f Codecps.t = {
    code_gen = fun k -> .<
      match .~e with
      | TBool -> .~(k `TBool)
      | TFun (t,t') -> .~(k (`TFun (.<t>.,.<t'>.)))
    >.
  }
end

module G = Fast_gen.Staged_generator.MakeStaged(Fast_gen.Sr_random)
open G
open Let_syntax
module GS = G.MakeSplit(M)
module GTS = G.MakeSplit(MT)

type t = Type_defn.expr [@@deriving quickcheck, sexp]

let split_expr = GS.split
let split_typ = GTS.split

let genTyp : typ code G.t =
  recursive .<()>. @@ fun go u ->
    G.bind size ~f:(fun n ->
      G.bind (split_bool .< .~n <= 1 >.) ~f:(fun b ->
        if b then return .<TBool>.
        else
          weighted_union [
            .<1.0>., return .<TBool>.;
            .<Int.to_float .~n>.,
              G.bind (with_size ~size_c:.<.~n / 2>. (recurse go u)) ~f:(fun t1 ->
              G.bind (with_size ~size_c:.<.~n / 2>. (recurse go u)) ~f:(fun t2 ->
                return .<TFun(.~t1,.~t2)>.
              ))
          ]))

let genConst t : expr code G.t =
  recursive t @@ fun go t ->
    G.bind (split_typ t) ~f:(function
      | `TBool -> map ~f:(fun b -> .<Bool .~b>.) bool
      | `TFun(t1,t2) -> map ~f:(fun e -> .<Abs(.~t1,.~e)>.) (recurse go t2))

let genVar g t : expr option code G.t =
  let eq = equal_typ .~t 
  G.bind (return .<List.filter_mapi ~f:(fun i t' -> if equal_typ .~t t' then Some (Some (Var i)) else None) .~g>.) ~f:(fun vars ->
    G.bind (split_list vars) ~f:(function
      | `Nil -> return .<None>.
      | `Cons _ -> of_list_dyn vars))   

let genExactExpr n g t =
  recursive .<(.~n,.~g,.~t)>. @@ fun go ngt ->
    G.bind (split_triple ngt) ~f:(fun (n,g,t) ->
      G.bind (genVar g t >>= split_option) ~f:(function
        | `Some e -> return e
        | `None ->
            G.bind (split_bool .<.~n <= 1>.) ~f:(fun b ->
              if b then genConst t else
                G.bind (split_typ t) ~f:(function
                  | `TFun (t1,t2) -> map ~f:(fun e -> .<Abs(.~t1,.~e)>.) (recurse go .<(.~n - 1,.~t1 :: .~g,.~t2)>.)
                  | _ ->
                      G.bind genTyp ~f:(fun t' ->
                        G.bind (recurse go .<(.~n/2,.~g,TFun(.~t',.~t))>.) ~f:(fun e1 ->
                          G.bind (recurse go .<(.~n/2,.~g,.~t')>.) ~f:(fun e2 ->
                            return .<App(.~e1,.~e2)>.
                          )))))))

let genExpr =
  G.bind size ~f:(fun n ->
    G.bind genTyp ~f:(fun t ->
      genExactExpr n .<[]>. t))

let quickcheck_generator = G.jit ~extra_cmi_paths:["/home/ubuntu/etna2/workloads/OCaml/STLC/_build/default/lib/.STLC.objs/byte"] genExpr

let sexp_of_t = sexp_of_t
