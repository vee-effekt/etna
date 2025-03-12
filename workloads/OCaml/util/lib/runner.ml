(* the test type for Crowbar is just a lazy call to Crowbar.add_test *)
(* same with Base_quickcheck, but with Test.run  *)
type qtest = QCheck.Test.t
type ctest = unit -> unit
type btest = unit -> unit

(* rename of the Core module type *)
type 'a basegen = (module Base_quickcheck.Test.S with type t = 'a)

(* Generalizing pre and post conditions *)
type test = Pre of bool * test | Post of bool

let ( =>> ) pre post = Pre (pre, post)
let ( ->> ) pre post = Pre (pre, Post post)

(* Generalizing parameterization of tests *)

type 'a property = {
  name : string;
  q : 'a QCheck.arbitrary -> string -> qtest;
  c : 'a Crowbar.gen -> string -> ctest;
  b : 'a basegen -> string -> string -> btest;
}

(* Functions for realizing preconditions *)
let rec qmake (t : test) : bool =
  match t with
  | Pre (pre, post) ->
      QCheck.assume pre;
      qmake post
  | Post b -> b

let rec cmake (t : test) : unit =
  match t with
  | Pre (pre, post) ->
      Crowbar.guard pre;
      cmake post
  | Post b -> Crowbar.check b
  
let rec bmake (t : test) : unit Base.Or_error.t =
  match t with
  | Pre (true, post) ->
      (* Printf.printf "Processing Pre-condition: true\n"; *)
      bmake post
  | Pre (false, _) ->
      (* Printf.printf "Skipping test due to false pre-condition\n"; *)
      (* false precondition, we can skip test *)
      Ok ()
  | Post true ->
      (* Printf.printf "Post-condition passed: true\n"; *)
      Ok ()
  | Post false  ->
      (* Printf.printf "Post-condition failed: false\n"; *)
      Error (Base.Error.of_string "fail")

(* Helpers to build `'a property` types. Note that `'b` is the input to the property, INCLUDING the other parameters. *)
let qbuild (g : 'b QCheck.arbitrary) (f : 'b -> bool) : string -> qtest =
 fun name -> QCheck.Test.make ~name ~count:500000000 g f

(* crowbar's type signature means 'c is essentially 'b -> unit *)
let cbuild (g : ('c, unit) Crowbar.gens) (f : 'c) : string -> ctest =
 fun name () -> Crowbar.add_test ~name g f

 let _verbose res =
  match res with
  | Ok () -> print_endline "Tests passed?"
  | Error (_,err) -> print_endline "bug found!";
                     print_endline (Base.Error.to_string_hum err)

let bbuild (g : 'b basegen) (f : 'b -> unit Base.Or_error.t) ?(seed : string option = None) : string -> btest =
  fun _ () ->
    let seed_config =
      match seed with
      | Some s when not (String.equal s "") -> Base_quickcheck.Test.Config.Seed.Deterministic s
      | _ -> Base_quickcheck.Test.Config.Seed.Nondeterministic
    in
    Base_quickcheck.Test.result ~f:(fun x ->
      let res = f x in
      match res with
      | Ok () -> Ok ()
      | Error _ ->  Error (Base.Error.of_string (Sexplib.Sexp.to_string_hum x))
      ) g
      ~config:
        {
          seed = seed_config;
          test_count = Core.Int.max_value;
          shrink_count = 0;
          sizes = Base_quickcheck.Test.default_config.sizes;
        }
    |> _verbose
  
