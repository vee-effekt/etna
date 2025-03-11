open Type

module BaseTypeG : Base_quickcheck.Test.S with type t = Type.tree = struct
  type t = Type.tree [@@deriving sexp, quickcheck]
end
