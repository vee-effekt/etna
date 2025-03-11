open QCheck
open Crowbar
open Util.Runner
open Util.Io
open BST.Impl
open BST.Test
open BST.BaseType
open BST.BaseBespoke
open BST.BaseTypGsr
open BST.BaseTypCsr
open Sexplib0.Sexp_conv;;
open Sexplib;;
open Stdio
open Ppx_staged;;

(*
  dune exec BST -- qcheck prop_InsertInsert bespoke out
  dune exec BST -- qcheck prop_InsertInsert type out
  dune exec BST -- crowbar prop_InsertInsert bespoke out
  dune exec BST -- crowbar prop_InsertInsert type out
  dune exec BST -- afl prop_InsertInsert bespoke out
  dune exec BST -- afl prop_InsertInsert type out
  dune exec BST -- base prop_InsertInsert bespoke out
  dune exec BST -- base prop_InsertInsert type out
  *)
  open QCheck
  open Crowbar
  open Util.Runner
  open Util.Io
  open Ppx_staged;;
  open Core;;
  open Sexplib0.Sexp_conv;;
  open Sexplib;;
  open Ppx_staged;;
  open Core
  open Base_quickcheck
  open Fast_gen
  open Fast_gen.Bq_generator
  
  open Core
  open Fast_gen
  open Fast_gen.Bq_generator
  open Base_quickcheck
  open BST.Spec
  open BST.BaseSingleBespoke
  module BQ = Fast_gen.Bq_generator
  open Sexplib0.Sexp_conv;;
  open Sexplib;;
  
  let test_isBST () =
    Quickcheck.test
      ~sexp_of:BaseSingleBespoke.sexp_of_t
      ~shrinker:BaseSingleBespoke.quickcheck_shrinker
      BaseSingleBespoke.quickcheck_generator
      ~f:(fun tree ->
        if not (isBST tree) then
          failwith (Printf.sprintf "BST property violated! %s" (Sexp.to_string_hum (BaseSingleBespoke.sexp_of_t tree))))
    
  (* Run the test harness *)
  let () =
    print_endline "Running BST property test...";
    test_isBST ();
    print_endline "All generated trees satisfy the BST property! ✅"

(*
let properties : (string * tree property) list =
  [
    ("prop_InsertValid", test_prop_InsertValid);
    ("prop_DeleteValid", test_prop_DeleteValid);
    ("prop_UnionValid", test_prop_UnionValid);
    ("prop_InsertPost", test_prop_InsertPost);
    ("prop_DeletePost", test_prop_DeletePost);
    ("prop_UnionPost", test_prop_UnionPost);
    ("prop_InsertModel", test_prop_InsertModel);
    ("prop_DeleteModel", test_prop_DeleteModel);
    ("prop_UnionModel", test_prop_UnionModel);
    ("prop_InsertInsert", test_prop_InsertInsert);
    ("prop_InsertDelete", test_prop_InsertDelete);
    ("prop_InsertUnion", test_prop_InsertUnion);
    ("prop_DeleteInsert", test_prop_DeleteInsert);
    ("prop_DeleteDelete", test_prop_DeleteDelete);
    ("prop_DeleteUnion", test_prop_DeleteUnion);
    ("prop_UnionDeleteInsert", test_prop_UnionDeleteInsert);
    ("prop_UnionUnionIdem", test_prop_UnionUnionIdem);
    ("prop_UnionUnionAssoc", test_prop_UnionUnionAssoc);
  ]

let qstrategies : (string * tree arbitrary) list =
  []

let cstrategies : (string * tree gen) list =
  []

let bstrategies : (string * tree basegen) list =
  [ ("type", (module BaseType)); ("bespoke", (module BaseBespoke)); ("typGsr", (module BaseTypGsr)); ("typCsr", (module BaseTypCsr))]

let () = main properties qstrategies cstrategies bstrategies

(*
let () =
  let random_a = Splittable_random.State.of_int 0 in
  let random_b = Splittable_random.State.of_int 0 in
  let size = 10 in
  for _ = 1 to 3 do
    printf "\n";
    printf "\n";
    let quickc_values = Base_quickcheck.Generator.generate BaseType.quickcheck_generator ~size ~random:random_a in
    let staged_values = Base_quickcheck.Generator.generate BaseTypCsr.quickcheck_generator ~size ~random:random_b in
    printf "========== quickcheck_generator ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseStagedType.sexp_of_t quickc_values));
    printf "========= Staged generator ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseType.sexp_of_t staged_values))
  done
*)
*)