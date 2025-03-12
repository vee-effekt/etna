open Codelib;;
open Fast_gen
open Base
open Type_defn;;

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
  G.recursive .<()>. @@ fun go u ->
    G.bind G.size ~f:(fun n ->
      G.bind (G.split_bool .< .~n <= 1 >.) ~f:(fun b ->
        if b then G.return .<TBool>.
        else
          G.weighted_union [
            .<1.0>., G.return .<TBool>.;
            .<Int.to_float .~n>.,
              G.bind (G.with_size ~size_c:.<.~n / 2>. (G.recurse go u)) ~f:(fun t1 ->
              G.bind (G.with_size ~size_c:.<.~n / 2>. (G.recurse go u)) ~f:(fun t2 ->
                G.return .<TFun(.~t1,.~t2)>.
              ))
          ]))

let genConst t : expr code G.t =
  G.recursive t @@ fun go t ->
    G.bind (split_typ t) ~f:(function
      | `TBool -> map ~f:(fun b -> .<Bool .~b>.) bool
      | `TFun(t1,t2) -> map ~f:(fun e -> .<Abs(.~t1,.~e)>.) (G.recurse go t2))

let genVar g t : Type_defn.expr option code G.t =
  G.bind (G.return .<List.filter_mapi ~f:(fun i t' -> if Type_defn.equal .~t t' then Some (Some (Var i)) else None) .~g>.) ~f:(fun vars ->
    G.bind (G.split_list vars) ~f:(function
      | `Nil -> G.return .<None>.
      | `Cons _ -> G.of_list_dyn vars))

let genExactExpr n g t =
  G.recursive .<(.~n,.~g,.~t)>. @@ fun go ngt ->
    G.bind (G.split_triple ngt) ~f:(fun (n,g,t) ->
      G.bind (G.bind (genVar g t) G.split_option) ~f:(function
        | `Some e -> G.return e
        | `None ->
            G.bind (G.split_bool .<.~n <= 1>.) ~f:(fun b ->
              if b then genConst t else
                G.bind (split_typ t) ~f:(function
                  | `TFun (t1,t2) -> map ~f:(fun e -> .<Abs(.~t1,.~e)>.) (G.recurse go .<(.~n - 1,.~t1 :: .~g,.~t2)>.)
                  | _ ->
                      G.bind genTyp ~f:(fun t' ->
                        G.bind (G.recurse go .<(.~n/2,.~g,TFun(.~t',.~t))>.) ~f:(fun e1 ->
                          G.bind (G.recurse go .<(.~n/2,.~g,.~t')>.) ~f:(fun e2 ->
                            G.return .<App(.~e1,.~e2)>.
                          )))))))

let genExpr =
  G.bind G.size ~f:(fun n ->
    G.bind genTyp ~f:(fun t ->
      genExactExpr n .<[]>. t))

let quickcheck_generator = G.jit ~extra_cmi_paths:["/home/ubuntu/etna2/workloads/OCaml/STLC/_build/default/lib/.STLC.objs/byte"] genExpr

let sexp_of_t = sexp_of_t
