open Stdio
open Fast_gen;;
open Ppx_staged_expander;;
open Impl;;
open Sexplib0.Sexp_conv;;

module G_SR : sig
    include module type of Fast_gen.Staged_generator.MakeStaged(Fast_gen.Sr_random)
  end
  
val staged_quickcheck_generator : Impl.tree G_SR.c G_SR.t
