open Type

module BaseType : Base_quickcheck.Test.S with type t = Type.tree = struct
  type t = Type.tree [@@deriving sexp, quickcheck]
end
