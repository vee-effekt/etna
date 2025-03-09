
module Nat = struct
  include Core;;

  let quickcheck_generator_int_new = Base_quickcheck.Generator.int_uniform_inclusive 0 100

  type t = int [@quickcheck.generator quickcheck_generator_int_new][@@deriving sexp, quickcheck]
  let quickcheck_generator =
    Base_quickcheck.Generator.int_uniform_inclusive 0 100
end
