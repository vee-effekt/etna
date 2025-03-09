open QCheck
open Crowbar
open Util.Runner
open Util.Io
open BST.Impl
open BST.Test
open BST.QcheckType
open BST.QcheckBespoke
open BST.CrowbarType
open BST.CrowbarBespoke
open BST.BaseType
open BST.BaseBespoke
open BST.BaseStagedType
open Sexplib0.Sexp_conv;;
open Sexplib;;
open Stdio
open Fast_gen;;
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
  [ ("type", qcheck_type); ("bespoke", qcheck_bespoke) ]

let cstrategies : (string * tree gen) list =
  [ ("type", crowbar_type); ("bespoke", crowbar_bespoke) ]

let bstrategies : (string * tree basegen) list =
  [ ("type", (module BaseType)); ("bespoke", (module BaseBespoke)); ("stagedType", (module BaseStagedType)) ]

let () = main properties qstrategies cstrategies bstrategies
*)

let () =
  let random_a = Splittable_random.State.of_int 0 in
  let random_b = Splittable_random.State.of_int 0 in
  let size = 10 in
  for _ = 1 to 3 do
    printf "\n";
    printf "\n";
    let quickc_values = Base_quickcheck.Generator.generate BaseType.quickcheck_generator ~size ~random:random_a in
    let staged_values = Base_quickcheck.Generator.generate BaseStagedType.quickcheck_generator ~size ~random:random_b in
    printf "========== quickcheck_generator ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseStagedType.sexp_of_t quickc_values));
    printf "========= Staged generator ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseType.sexp_of_t staged_values))
  done