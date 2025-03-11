open QCheck
open Crowbar
open Util.Runner
open Util.Io
open RBT.Test
open RBT.BaseType
open RBT.BaseBespoke
open RBT.BaseTypCsr
open Ppx_staged;;
open Core;;
open Sexplib0.Sexp_conv;;
open Sexplib;;
open Ppx_staged;;
open RBT.Impl;;
open RBT.BaseSingleBespoke;;
open Core
open Base_quickcheck
open Fast_gen
open Fast_gen.Bq_generator
open RBT.Spec
module BQ = Fast_gen.Bq_generator

let test_isBST () =
  Quickcheck.test
    ~sexp_of:BaseSingleBespoke.sexp_of_t
    ~shrinker:BaseSingleBespoke.quickcheck_shrinker
    BaseSingleBespoke.quickcheck_generator
    ~f:(fun tree ->
      (* Print the generated tree *)
      Printf.printf "Generated tree:\n%s\n\n" (Sexp.to_string_hum (BaseSingleBespoke.sexp_of_t tree));
      
      (* Check if it satisfies the RBT property *)
      if not (isRBT tree) then
        failwith (Printf.sprintf "❌ RBT property violated!\n%s" (Sexp.to_string_hum (BaseSingleBespoke.sexp_of_t tree))))
  
(* Run the test harness *)
let () =
  print_endline "Running RBT property test...";
  test_isBST ();
  print_endline "✅ All generated trees satisfy the RBT property!"

(* RUNNER COMMAND:
   dune exec RBT -- qcheck prop_DeleteValid bespoke out.txt
   dune exec RBT -- qcheck prop_DeleteValid type out.txt
   dune exec RBT -- crowbar prop_DeleteValid bespoke out.txt
   dune exec RBT -- crowbar prop_DeleteValid type out.txt
   dune exec RBT -- afl prop_DeleteValid bespoke out.txt
   dune exec RBT -- afl prop_DeleteValid type out.txt
   dune exec RBT -- base prop_DeleteValid type out
*)
(*
let properties : (string * rbt property) list =
  [
    ("prop_InsertValid", test_prop_InsertValid);
    ("prop_DeleteValid", test_prop_DeleteValid);
    ("prop_InsertPost", test_prop_InsertPost);
    ("prop_DeletePost", test_prop_DeletePost);
    ("prop_InsertModel", test_prop_InsertModel);
    ("prop_DeleteModel", test_prop_DeleteModel);
    ("prop_InsertInsert", test_prop_InsertInsert);
    ("prop_InsertDelete", test_prop_InsertDelete);
    ("prop_DeleteInsert", test_prop_DeleteInsert);
    ("prop_DeleteDelete", test_prop_DeleteDelete);
  ]

let qstrategies : (string * rbt arbitrary) list =
  []

let cstrategies : (string * rbt gen) list =
  []

let bstrategies : (string * rbt basegen) list =
  [ ("type", (module BaseType)); ("bespoke", (module BaseBespoke)); ("typCsr", (module BaseTypCsr)) ]

let () = main properties qstrategies cstrategies bstrategies
*)