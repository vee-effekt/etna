open STLC.Test
open Util.Io
open Util.Runner
open STLC.Type;;
open STLC
open Core;;
(* RUNNER COMMAND:
   dune exec STLC -- qcheck prop_SinglePreserve bespoke out
   dune exec STLC -- qcheck prop_SinglePreserve type out
   dune exec STLC -- crowbar prop_SinglePreserve bespoke out
   dune exec STLC -- crowbar prop_SinglePreserve type out
   dune exec STLC -- afl prop_SinglePreserve bespoke out
   dune exec STLC -- afl prop_SinglePreserve type out
   dune exec STLC -- base prop_SinglePreserve bespoke out
   dune exec STLC -- base prop_SinglePreserve type out
*)

let () =
  let random_a = Splittable_random.State.of_int 1 in
  let random_b = Splittable_random.State.of_int 1 in
  let random_c = Splittable_random.State.of_int 1 in
  let random_d = Splittable_random.State.of_int 1 in
  let size = 10 in
  for _ = 1 to 10 do
    printf "\n";
    printf "\n";
    let gen1 = Base_quickcheck.Generator.generate BaseType.quickcheck_generator ~size ~random:random_a in
    let gen2 = Base_quickcheck.Generator.generate BaseType_Staged_SR.quickcheck_generator ~size ~random:random_b in
    let gen3 = Base_quickcheck.Generator.generate BaseType_Staged_C.quickcheck_generator ~size ~random:random_c in
    let gen4 = Base_quickcheck.Generator.generate BaseType_Staged_CSR.quickcheck_generator ~size ~random:random_d in
    printf "========= type generator ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseType.sexp_of_t gen1));
    printf "========= staged generator ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseType_Staged_SR.sexp_of_t gen1));
    printf "========= staged generator c ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseType_Staged_C.sexp_of_t gen1));
    printf "========= staged generator csr ==========\n";
    printf "%s\n" (Sexp.to_string_hum (BaseType_Staged_CSR.sexp_of_t gen1));
  done


(*
let properties : (string * expr property) list =
  [
    ("prop_SinglePreserve", test_prop_SinglePreserve);
    ("prop_MultiPreserve", test_prop_MultiPreserve);
  ]

let bstrategies : (string * expr basegen) list =
  [ ("type", (module BaseType)) ]

let () = main properties [] [] bstrategies
*)