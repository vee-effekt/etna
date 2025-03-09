open Stdio
open Fast_gen;;
open Impl;;
open Sexplib;;
open Sexplib0.Sexp_conv;;
open Base;;

module G_SR = Fast_gen.Staged_generator.MakeStaged(Fast_gen.Sr_random)

module BaseTypes : Base_quickcheck.Test.S with type t = tree = struct
  type t = Impl.tree [@@deriving quickcheck, sexp]

  let staged_quickcheck_generator =
    G_SR.recursive (G_SR.C.lift ())
      (fun go ->
        fun _ ->
          let _pair__004_ =
            ((.< 1.  >.), (G_SR.return (.< E  >.)))
          and _pair__005_ =
            ((.< 2.  >.),
              (G_SR.bind G_SR.size
                  ~f:(fun _size__001_ ->
                        G_SR.with_size
                          ~size_c:(G_SR.C.pred _size__001_)
                          (G_SR.bind
                            (G_SR.recurse go (G_SR.C.lift ()))
                            ~f:(fun _x__006_ ->
                                  G_SR.bind
                                    (G_SR.int_uniform_inclusive
                                        ~lo:(G_SR.C.lift
                                              Int.min_value)
                                        ~hi:(G_SR.C.lift
                                              Int.max_value))
                                    ~f:(fun _x__007_ ->
                                          G_SR.bind
                                            (G_SR.int_uniform_inclusive
                                                ~lo:(G_SR.C.lift
                                                      Int.min_value)
                                                ~hi:(G_SR.C.lift
                                                      Int.max_value))
                                            ~f:(fun _x__008_ ->
                                                  G_SR.bind
                                                    (G_SR.recurse
                                                        go
                                                        (G_SR.C.lift
                                                          ()))
                                                    ~f:(fun
                                                          _x__009_
                                                          ->
                                                          G_SR.return
                                                          (.<
                                                          T
                                                          ((.~_x__009_),
                                                          (.~_x__008_),
                                                          (.~_x__007_),
                                                          (.~_x__006_)) 
                                                          >.))))))))) in
          let _gen__002_ = G_SR.weighted_union [_pair__004_]
          and _gen__003_ =
            G_SR.weighted_union [_pair__004_; _pair__005_] in
          G_SR.bind G_SR.size
            ~f:(fun x -> G_SR.if_z x _gen__002_ _gen__003_))
              
  let quickcheck_generator = G_SR.jit ~extra_cmi_paths:["/home/ubuntu/etna/workloads/OCaml/BST/_build/default/lib/.BST.objs/byte"] staged_quickcheck_generator
end