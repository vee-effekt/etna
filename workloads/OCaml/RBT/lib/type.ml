open Core;;

let quickcheck_generator_int_new = let open Base_quickcheck.Generator in
  bind int ~f:(fun i -> return (i mod 1000))

type color = R | B [@@deriving sexp, quickcheck]

type rbt = E | T of color * rbt * (int [@quickcheck.generator quickcheck_generator_int_new]) * (int [@quickcheck.generator quickcheck_generator_int_new]) * rbt
[@@deriving sexp, quickcheck]
