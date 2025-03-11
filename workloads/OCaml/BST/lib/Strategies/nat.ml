module Nat = struct
  include Core;;
  module G = Fast_gen.Staged_generator.MakeStaged(Fast_gen.C_random)

  let staged_quickcheck_generator_t =
      (G.bind G.int ~f:(fun  i -> G.return (G.C.modulus i 1000)))
      
  let quickcheck_generator_int_new = let open Base_quickcheck.Generator in
    bind int ~f:(fun i -> return (i mod 1000))

  type t = int [@quickcheck.generator quickcheck_generator_int_new] [@@deriving sexp, quickcheck]
end
