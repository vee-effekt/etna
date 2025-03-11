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

module BQ = Fast_gen.Bq_generator
let rec verify_rb_tree ?(min_key = Int.min_value) ?(max_key = Int.max_value) tree =
  let rec black_height = function
    | E -> 0
    | T (color, left, key, _, right) ->
        (* Ensure BST property *)
        if key <= min_key || key >= max_key then
          failwith "BST property violated";

        let left_bh = black_height left in
        let right_bh = black_height right in
        
        if left_bh <> right_bh then
          failwith "Black height mismatch";

        (* Check red-black properties *)
        (match color with
          | R ->
              (* Red nodes cannot have red children *)
              (match left with T (R, _, _, _, _) -> failwith "Red node has red child" | _ -> ());
              (match right with T (R, _, _, _, _) -> failwith "Red node has red child" | _ -> ());
              left_bh
          | B -> 1 + left_bh)
  in
  (* Root must be black *)
  match tree with
  | E -> ()  (* Empty tree is valid *)
  | T (R, _, _, _, _) -> failwith "Root must be black"
  | T (B, _, _, _, _) -> ignore (black_height tree);

  (* Ensure BST property throughout the tree *)
  let rec check_bst min_k max_k = function
    | E -> ()
    | T (_, left, key, _, right) ->
        if key <= min_k || key >= max_k then
          failwith "BST property violated";
        check_bst min_k key left;
        check_bst key max_k right
  in
  check_bst min_key max_key tree
  
  (* Test function to generate and verify red-black trees *)
  let test_red_black_tree_generator () =
    Quickcheck.test
      ~sexp_of:[%sexp_of: BaseSingleBespoke.t]  (* Use the `sexp_of` function derived for `rbt` *)
      ~shrinker:BaseSingleBespoke.quickcheck_shrinker (* No shrinking for now *)
      ~trials:1000  (* Number of tests *)
      BaseSingleBespoke.quickcheck_generator  (* Use our RBT generator *)
      ~f:(fun tree ->
        try
          verify_rb_tree tree; (* Run verification *)
        with exn ->
          printf "❌ Verification failed for tree:\n%s\nError: %s\n\n"
            (Sexp.to_string_hum ([%sexp_of: BaseSingleBespoke.t] tree))
            (Exn.to_string exn);
          raise exn (* Re-raise the exception to fail the test *)
      )
  
  (* Run the test harness *)
  let () = test_red_black_tree_generator ()

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