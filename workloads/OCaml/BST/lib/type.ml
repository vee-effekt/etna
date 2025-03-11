open Core;;

module G = Fast_gen.Staged_generator.MakeStaged(Fast_gen.C_sr_dropin_random)

let quickcheck_generator_int_new = let open Base_quickcheck.Generator in
  bind int ~f:(fun i -> return (i mod 1000))

type tree =
| E
| T of tree * (int [@quickcheck.generator quickcheck_generator_int_new]) * (int [@quickcheck.generator quickcheck_generator_int_new]) * tree [@@deriving quickcheck, sexp]
