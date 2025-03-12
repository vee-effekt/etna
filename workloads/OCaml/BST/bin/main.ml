open QCheck
open Crowbar
open Util.Runner
open Util.Io
open BST.Type
open BST.Test
open BST.Nat
open Sexplib0.Sexp_conv;;
open Sexplib;;
open Stdio
open Ppx_staged;;
open Nat;;
open BST;;

(* type nat = Nat.t * Nat.t [@@deriving wh, sexp]

let () =
  let generator = G.jit ~extra_cmi_paths:["/home/ubuntu/waffle-house/ppx_staged/_build/default/bin/.main.eobjs/byte"] staged_quickcheck_generator_nat in
  let () = G.print staged_quickcheck_generator_nat in  
  let random_a = Splittable_random.State.of_int 1 in
  let random_b = Splittable_random.State.of_int 1 in
  let size = 10 in
  for _ = 1 to 10 do
    printf "\n";
    printf "\n";
    let staged_values = Base_quickcheck.Generator.generate generator ~size ~random:random_b in
    printf "========= Staged generator ==========\n";
    printf "%s\n" (Sexp.to_string_hum (sexp_of_nat staged_values))
  done *)

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
*)

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
  [
    ("bespoke", (module BaseBespoke));
    ("bespokeStaged", (module BaseBespoke_Staged_SR));
    ("bespokeStagedC", (module BaseBespoke_Staged_C));
    ("bespokeStagedCSR", (module BaseBespoke_Staged_CSR));
    ("type", (module BaseType));
    ("staged", (module BaseType_Staged_SR));
    ("stagedC", (module BaseType_Staged_C));
    ("stagedCSR", (module BaseType_Staged_CSR))
  ]

let () = main properties qstrategies cstrategies bstrategies