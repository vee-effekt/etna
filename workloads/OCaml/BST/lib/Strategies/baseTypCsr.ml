open Impl;;
open Fast_gen;;
open Core;;

module C_SR = Fast_gen.Staged_generator.MakeStaged(Fast_gen.C_sr_dropin_random)

module BaseTypCsr : Base_quickcheck.Test.S with type t = tree = struct
  type t = tree [@@deriving sexp, quickcheck]

  let staged_quickcheck_generator = 
      C_SR.recursive (C_SR.C.lift ())
        (fun go ->
            fun _ ->
              let _pair__004_ =
                ((.< 1.  >.), (C_SR.return (.< E  >.)))
              and _pair__005_ =
                ((.< 1.  >.),
                  (C_SR.bind C_SR.size
                    ~f:(fun _size__001_ ->
                          C_SR.with_size
                            ~size_c:(C_SR.C.pred _size__001_)
                            (C_SR.bind
                                (C_SR.recurse go (C_SR.C.lift ()))
                                ~f:(fun _x__008_ ->
                                      C_SR.bind
                                        (C_SR.bind C_SR.int
                                          ~f:(fun _i__007_ ->
                                                C_SR.return
                                                  (C_SR.C.modulus
                                                      _i__007_ 1000)))
                                        ~f:(fun _x__009_ ->
                                              C_SR.bind
                                                (C_SR.bind C_SR.int
                                                  ~f:(fun _i__006_ ->
                                                        C_SR.return
                                                          (C_SR.C.modulus
                                                            _i__006_
                                                            1000)))
                                                ~f:(fun _x__010_ ->
                                                      C_SR.bind
                                                        (C_SR.recurse
                                                          go
                                                          (C_SR.C.lift
                                                            ()))
                                                        ~f:(fun
                                                            _x__011_
                                                            ->
                                                            C_SR.return
                                                            (.<
                                                            T
                                                            ((.~_x__011_),
                                                            (.~_x__010_),
                                                            (.~_x__009_),
                                                            (.~_x__008_)) 
                                                            >.))))))))) in
              let _gen__002_ = C_SR.weighted_union [_pair__004_]
              and _gen__003_ =
                C_SR.weighted_union [_pair__004_; _pair__005_] in
              C_SR.bind C_SR.size
                ~f:(fun x -> C_SR.if_z x _gen__002_ _gen__003_))
end