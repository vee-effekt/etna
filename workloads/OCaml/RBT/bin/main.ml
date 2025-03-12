open Util.Runner
open Util.Io
open RBT.Type
open RBT.Test
open Core
open RBT.Spec
open RBT

let () =
  let random_a = Splittable_random.State.of_int 1 in
  let random_b = Splittable_random.State.of_int 1 in
  let random_c = Splittable_random.State.of_int 1 in
  let random_d = Splittable_random.State.of_int 1 in
  let size = 10 in
  for _ = 1 to 10 do
    printf "\n";
    printf "\n";
    let values = Base_quickcheck.Generator.generate BaseType.quickcheck_generator ~size ~random:random_a in
    let staged_values_sr = Base_quickcheck.Generator.generate BaseType_Staged_SR.quickcheck_generator ~size ~random:random_b in
    let staged_values_c = Base_quickcheck.Generator.generate BaseType_Staged_C.quickcheck_generator ~size ~random:random_c in
    let staged_values_csr = Base_quickcheck.Generator.generate BaseType_Staged_CSR.quickcheck_generator ~size ~random:random_d in
    printf "========= type generator ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseType.sexp_of_t values));
    printf "========= staged generator ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseType_Staged_SR.sexp_of_t staged_values_sr));
    printf "========= staged generator c ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseType_Staged_C.sexp_of_t staged_values_sr));
    printf "========= staged generator csr ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseType_Staged_CSR.sexp_of_t staged_values_sr))
  done
  
(*
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

RUNNER COMMAND:
   dune exec RBT -- qcheck prop_DeleteValid bespoke out.txt
   dune exec RBT -- qcheck prop_DeleteValid type out.txt
   dune exec RBT -- crowbar prop_DeleteValid bespoke out.txt
   dune exec RBT -- crowbar prop_DeleteValid type out.txt
   dune exec RBT -- afl prop_DeleteValid bespoke out.txt
   dune exec RBT -- afl prop_DeleteValid type out.txt
   dune exec RBT -- base prop_DeleteValid type out

*)
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

let bstrategies : (string * rbt basegen) list =
  [ ("type", (module BaseType)); ("bespoke", (module BaseBespoke)) ]

let () = main properties [] [] bstrategies
