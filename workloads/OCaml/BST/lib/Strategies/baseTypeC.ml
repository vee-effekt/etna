open Type;;
open Fast_gen;;
open Core;;
open Core_unix;;

module G = Fast_gen.Staged_generator.MakeStaged(Fast_gen.C_random)

module BaseTypeC : Base_quickcheck.Test.S with type t = Type.tree = struct
  type t = Type.tree [@@deriving sexp, quickcheck]

  let staged_quickcheck_generator =
    G.recursive (G.C.lift ())
      (fun go ->
         fun _ ->
           let _pair__004_ = ((.< 1.  >.), (G.return (.< E  >.)))
           and _pair__005_ =
             ((.< 1.  >.),
               (G.bind G.size
                  ~f:(fun _size__001_ ->
                        G.with_size ~size_c:(G.C.pred _size__001_)
                          (G.bind (G.recurse go (G.C.lift ()))
                             ~f:(fun _x__008_ ->
                                   G.bind
                                     (G.bind G.int
                                        ~f:(fun _i__007_ ->
                                              G.return
                                                (G.C.modulus
                                                   _i__007_ 1000)))
                                     ~f:(fun _x__009_ ->
                                           G.bind
                                             (G.bind G.int
                                                ~f:(fun _i__006_ ->
                                                      G.return
                                                        (G.C.modulus
                                                          _i__006_
                                                          1000)))
                                             ~f:(fun _x__010_ ->
                                                   G.bind
                                                     (G.recurse go
                                                        (G.C.lift
                                                          ()))
                                                     ~f:(fun
                                                          _x__011_
                                                          ->
                                                          G.return
                                                          (.<
                                                          T
                                                          ((.~_x__011_),
                                                          (.~_x__010_),
                                                          (.~_x__009_),
                                                          (.~_x__008_)) 
                                                          >.))))))))) in
           let _gen__002_ = G.weighted_union [_pair__004_]
           and _gen__003_ =
             G.weighted_union [_pair__004_; _pair__005_] in
           G.bind G.size
             ~f:(fun x -> G.if_z x _gen__002_ _gen__003_))

  let quickcheck_generator = 
    let pid = Core_unix.getpid () in
    print_endline @@ "Jitting Base type c from " ^ (Int.to_string (Pid.to_int pid));
    let g = G.jit ~extra_cmi_paths:["/home/ubuntu/etna2/workloads/OCaml/BST/_build/default/lib/.BST.objs/byte"] staged_quickcheck_generator in
    print_endline "Successful";
    g

  let sexp_of_t = sexp_of_t
end