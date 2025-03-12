(*
open Fast_gen;;
open Ppx_staged;;
*)
open Core;;

module G = Fast_gen.Staged_generator.MakeStaged(Fast_gen.C_random)

type typ = TBool | TFun of typ * typ [@@deriving sexp, quickcheck]

type expr =
  | Var of int
  | Bool of bool
  | Abs of typ * expr
  | App of expr * expr
[@@deriving sexp, quickcheck]