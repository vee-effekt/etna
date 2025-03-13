open Type
open Spec
open Util
open Runner
open QCheck
open Crowbar
open Nat

let ( << ) f g x = f (g x)
let qi = small_int
let ci = int8

let test_prop_InsertValid : tree property =
  {
    name = "test_prop_InsertValid";
    b = (fun m seed ->
      bbuild
        (Core_plus.triple m (module Nat) (module Nat))
        (bmake << prop_InsertValid)                 
        ~seed:(Some seed));
    (*
      (fun m ->
        bbuild
          (Core_plus.triple m (module Nat) (module Nat))
          (bmake << prop_InsertValid));
    *)
  }

(*! QCheck test_prop_InsertValid. *)

let test_prop_DeleteValid : tree property =
  {
    name = "test_prop_DeleteValid";
    b =
      (fun m seed ->
        bbuild (Core_plus.double m (module Nat)) (bmake << prop_DeleteValid) ~seed:(Some seed));
  }

(*! QCheck test_prop_DeleteValid. *)

let test_prop_UnionValid : tree property =
  {
    name = "test_prop_UnionValid";
    b = (fun m seed -> bbuild (Core_plus.double m m) (bmake << prop_UnionValid) ~seed:(Some seed));
  }

(*! QCheck test_prop_UnionValid. *)

let test_prop_InsertPost : tree property =
  {
    name = "test_prop_InsertPost";
    b =
      (fun m seed ->
        bbuild
          (Core_plus.quad m
             (module Nat)
             (module Nat)
             (module Nat))
          (bmake << prop_InsertPost) ~seed:(Some seed));
  }

(*! QCheck test_prop_InsertPost. *)

let test_prop_DeletePost : tree property =
  {
    name = "test_prop_DeletePost";
    b =
      (fun m seed ->
        bbuild
          (Core_plus.triple m (module Nat) (module Nat))
          (bmake << prop_DeletePost)
          ~seed:(Some seed));
  }

(*! QCheck test_prop_DeletePost. *)

let test_prop_UnionPost : tree property =
  {
    name = "test_prop_UnionPost";
    b =
      (fun m seed ->
        bbuild (Core_plus.triple m m (module Nat)) (bmake << prop_UnionPost) ~seed:(Some seed));
  }

(*! QCheck test_prop_UnionPost. *)

let test_prop_InsertModel : tree property =
  {
    name = "test_prop_InsertModel";
    b =
      (fun m seed ->
        bbuild
          (Core_plus.triple m (module Nat) (module Nat))
          (bmake << prop_InsertModel) ~seed:(Some seed));
  }

(*! QCheck test_prop_InsertModel. *)

let test_prop_DeleteModel : tree property =
  {
    name = "test_prop_DeleteModel";
    b =
      (fun m seed ->
        bbuild (Core_plus.double m (module Nat)) (bmake << prop_DeleteModel) ~seed:(Some seed));
  }

(*! QCheck test_prop_DeleteModel. *)

let test_prop_UnionModel : tree property =
  {
    name = "test_prop_UnionModel";
    b = (fun m seed -> bbuild (Core_plus.double m m) (bmake << prop_UnionModel) ~seed:(Some seed));
  }

(*! QCheck test_prop_UnionModel. *)

let test_prop_InsertInsert : tree property =
  {
    name = "test_prop_InsertInsert";
    b =
      (fun m seed ->
        bbuild
          (Core_plus.quinta m
             (module Nat)
             (module Nat)
             (module Nat)
             (module Nat))
          (bmake << prop_InsertInsert) ~seed:(Some seed));
  }

(*! QCheck test_prop_InsertInsert. *)

let test_prop_InsertDelete : tree property =
  {
    name = "test_prop_InsertDelete";
    b =
      (fun m seed ->
        bbuild
          (Core_plus.quad m
             (module Nat)
             (module Nat)
             (module Nat))
          (bmake << prop_InsertDelete) ~seed:(Some seed));
  }

(*! QCheck test_prop_InsertDelete. *)

let test_prop_InsertUnion : tree property =
  {
    name = "test_prop_InsertUnion";
    b =
      (fun m seed ->
        bbuild
          (Core_plus.quad m m (module Nat) (module Nat))
          (bmake << prop_InsertUnion) ~seed:(Some seed));
  }

(*! QCheck test_prop_InsertUnion. *)

let test_prop_DeleteInsert : tree property =
  {
    name = "test_prop_DeleteInsert";
    b =
      (fun m seed ->
        bbuild
          (Core_plus.quad m
             (module Nat)
             (module Nat)
             (module Nat))
          (bmake << prop_DeleteInsert) ~seed:(Some seed));
  }

(*! QCheck test_prop_DeleteInsert. *)

let test_prop_DeleteDelete : tree property =
  {
    name = "test_prop_DeleteDelete";
    b =
      (fun m seed ->
        bbuild
          (Core_plus.triple m (module Nat) (module Nat))
          (bmake << prop_DeleteDelete) ~seed:(Some seed));
  }

(*! QCheck test_prop_DeleteDelete. *)

let test_prop_DeleteUnion : tree property =
  {
    name = "test_prop_DeleteUnion";
    b =
      (fun m seed ->
        bbuild
          (Core_plus.triple m m (module Nat))
          (bmake << prop_DeleteUnion) ~seed:(Some seed));
  }

(*! QCheck test_prop_DeleteUnion. *)

let test_prop_UnionDeleteInsert : tree property =
  {
    name = "test_prop_UnionDeleteInsert";
    b =
      (fun m seed ->
        bbuild
          (Core_plus.quad m m (module Nat) (module Nat))
          (bmake << prop_UnionDeleteInsert) ~seed:(Some seed));
  }

(*! QCheck test_prop_UnionDeleteInsert. *)

let test_prop_UnionUnionIdem : tree property =
  {
    name = "test_prop_UnionUnionIdem";
    b = (fun m seed -> bbuild m (bmake << prop_UnionUnionIdem) ~seed:(Some seed));
  }
(*! QCheck test_prop_UnionUnionIdem. *)

let test_prop_UnionUnionAssoc : tree property =
  {
    name = "test_prop_UnionUnionAssoc";
    b =
      (fun m seed -> bbuild (Core_plus.triple m m m) (bmake << prop_UnionUnionAssoc) ~seed:(Some seed));
  }

(*! QCheck test_prop_UnionUnionAssoc. *)
