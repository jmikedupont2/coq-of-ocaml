(** Generated by coq-of-ocaml *)
Require Import OCaml.OCaml.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Open Scope type_scope.
Import ListNotations.

Unset Positivity Checking.
Unset Guard Checking.

Module COMPARABLE.
  Record signature {t : Set} : Set := {
    t := t;
    compare : t -> t -> Z;
  }.
  Arguments signature : clear implicits.
End COMPARABLE.

Module S.
  Record signature {t : Set} : Set := {
    t := t;
    op_eq : t -> t -> bool;
    op_ltgt : t -> t -> bool;
    op_lt : t -> t -> bool;
    op_lteq : t -> t -> bool;
    op_gteq : t -> t -> bool;
    op_gt : t -> t -> bool;
    compare : t -> t -> Z;
    equal : t -> t -> bool;
    max : t -> t -> t;
    min : t -> t -> t;
  }.
  Arguments signature : clear implicits.
End S.

Parameter Make :
  forall (P : {t : Set & COMPARABLE.signature t}),
    {_ : unit & S.signature (|P|).(COMPARABLE.t)}.

Parameter Char : {_ : unit & S.signature ascii}.

Parameter Abstract : {t : Set & S.signature t}.
