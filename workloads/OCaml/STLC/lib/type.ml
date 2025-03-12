(*
open Fast_gen;;
open Ppx_staged;;
*)
open Core;;

type typ = TBool | TFun of typ * typ [@@deriving sexp, quickcheck]

type expr =
  | Var of int
  | Bool of bool
  | Abs of typ * expr
  | App of expr * expr
[@@deriving sexp, quickcheck]