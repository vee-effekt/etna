open Stdio
open Fast_gen;;
open Ppx_staged_expander;;
open Impl;;
open Sexplib0.Sexp_conv;;

module BaseStagedType : Base_quickcheck.Test.S with type t = Impl.tree