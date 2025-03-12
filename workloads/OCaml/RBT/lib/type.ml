open Core;;

type color = R | B [@@deriving sexp, quickcheck]

type rbt = E | T of color * rbt * (Nat.t [@wh.randomness "sr_t"]) * (Nat.t [@wh.randomness "sr_t"]) * rbt
[@@deriving sexp, quickcheck]
