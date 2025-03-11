open Impl;;

module G_SR = Fast_gen.Staged_generator.MakeStaged(Fast_gen.Sr_random)

module BaseTypGsr : Base_quickcheck.Test.S with type t = tree = struct
  type t = tree [@@deriving sexp, quickcheck]
  let quickcheck_generator =
    Base_quickcheck.Generator.create
      (fun ~size:size_28 ->
         fun ~random:random_29 ->
           let t_30 = Obj.magic 0 in
           let t_54 =
             let rec go_31 x_32 ~size:size_33  ~random:random_34  =
               if size_33 = 0
               then
                 let t_48 = 0. +. 1. in
                 let t_49 = Base.Float.one_ulp `Up 0. in
                 let t_50 = Base.Float.one_ulp `Down t_48 in
                 let t_51 = Splittable_random.float random_34 ~lo:t_49 ~hi:t_50 in
                 let t_52 = (Stdlib.Float.compare t_51 1.) <= 0 in
                 (if t_52
                  then E
                  else
                    (let t_53 = t_51 -. 1. in
                     Stdlib.failwith "Fell of the end of pick list"))
               else
                 (let t_35 = 0. +. 1. in
                  let t_36 = t_35 +. 1. in
                  let t_37 = Base.Float.one_ulp `Up 0. in
                  let t_38 = Base.Float.one_ulp `Down t_36 in
                  let t_39 = Splittable_random.float random_34 ~lo:t_37 ~hi:t_38 in
                  let t_40 = (Stdlib.Float.compare t_39 1.) <= 0 in
                  if t_40
                  then E
                  else
                    (let t_41 = t_39 -. 1. in
                     let t_42 = (Stdlib.Float.compare t_41 1.) <= 0 in
                     if t_42
                     then
                       let t_44 =
                         go_31 (Obj.magic 0) ~size:(size_33 - 1)
                           ~random:random_34 in
                       let t_45 =
                         Splittable_random.int random_34 ~lo:(Obj.magic 0)
                           ~hi:(Obj.magic 1000) in
                       let t_46 =
                         Splittable_random.int random_34 ~lo:(Obj.magic 0)
                           ~hi:(Obj.magic 1000) in
                       let t_47 =
                         go_31 (Obj.magic 0) ~size:(size_33 - 1)
                           ~random:random_34 in
                       T (t_47, t_46, t_45, t_44)
                     else
                       (let t_43 = t_41 -. 1. in
                        Stdlib.failwith "Fell of the end of pick list"))) in
             go_31 t_30 ~size:size_28 ~random:random_29 in
           t_54)
end