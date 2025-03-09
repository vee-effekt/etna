module Nat = struct
  include Core;;
  type t = int [@@deriving sexp, quickcheck]
  
  let quickcheck_generator =
    Base_quickcheck.Generator.int_uniform_inclusive Int.min_value Int.max_value
end
