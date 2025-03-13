open Spec
open Type_defn
open Util
open Runner
open Crowbar

let ( << ) f g x = f (g x)

let test_prop_SinglePreserve : expr property =
  {
    name = "test_prop_SinglePreserve";
    b = (fun m seed -> bbuild m (bmake << prop_SinglePreserve) ~seed:(Some seed));
  }

let test_prop_MultiPreserve : expr property =
  {
    name = "test_prop_MultiPreserve";
    b = (fun m seed -> bbuild m (bmake << prop_MultiPreserve) ~seed:(Some seed));
  }
