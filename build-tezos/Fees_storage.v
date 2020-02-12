(** Generated by coq-of-ocaml *)
Require Import OCaml.OCaml.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Open Scope type_scope.
Import ListNotations.

Unset Positivity Checking.
Unset Guard Checking.

Require Import Tezos.Environment.
Require Tezos.Constants_repr.
Require Tezos.Constants_storage.
Require Tezos.Contract_repr.
Require Tezos.Contract_storage.
Require Tezos.Raw_context.
Require Tezos.Tez_repr.

(* ❌ Structure item `typext` not handled. *)
(* type_extension *)

(* ❌ Structure item `typext` not handled. *)
(* type_extension *)

(* ❌ Structure item `typext` not handled. *)
(* type_extension *)

(* ❌ Top-level evaluations are ignored *)
(* top_level_evaluation *)

Definition origination_burn (c : Raw_context.context)
  : Lwt.t (Error_monad.tzresult (Raw_context.t * Tez_repr.t)) :=
  let origination_size := Constants_storage.origination_size c in
  let cost_per_byte := Constants_storage.cost_per_byte c in
  Error_monad.op_gtgteqquestion
    (Lwt.__return
      (Tez_repr.op_starquestion cost_per_byte (Int64.of_int origination_size)))
    (fun to_be_paid =>
      Error_monad.__return
        ((Raw_context.update_allocated_contracts_count c), to_be_paid)).

Definition record_paid_storage_space
  (c : Raw_context.t) (contract : Contract_repr.t)
  : Lwt.t (Error_monad.tzresult (Raw_context.t * Z.t * Z.t * Tez_repr.t)) :=
  Error_monad.op_gtgteqquestion (Contract_storage.used_storage_space c contract)
    (fun size =>
      Error_monad.op_gtgteqquestion
        (Contract_storage.set_paid_storage_space_and_return_fees_to_pay c
          contract size)
        (fun function_parameter =>
          let '(to_be_paid, c) := function_parameter in
          let c := Raw_context.update_storage_space_to_pay c to_be_paid in
          let cost_per_byte := Constants_storage.cost_per_byte c in
          Error_monad.op_gtgteqquestion
            (Lwt.__return
              (Tez_repr.op_starquestion cost_per_byte (Z.to_int64 to_be_paid)))
            (fun to_burn => Error_monad.__return (c, size, to_be_paid, to_burn)))).

Definition burn_storage_fees
  (c : Raw_context.context) (storage_limit : Z.t) (payer : Contract_repr.t)
  : Lwt.t (Error_monad.tzresult Raw_context.t) :=
  let origination_size := Constants_storage.origination_size c in
  let '(c, storage_space_to_pay, allocated_contracts) :=
    Raw_context.clear_storage_space_to_pay c in
  let storage_space_for_allocated_contracts :=
    Z.mul (Z.of_int allocated_contracts) (Z.of_int origination_size) in
  let consumed :=
    Z.add storage_space_to_pay storage_space_for_allocated_contracts in
  let remaining := Z.sub storage_limit consumed in
  if (|Compare.Z|).(Compare.S.op_lt) remaining Z.zero then
    Error_monad.fail extensible_type_value
  else
    let cost_per_byte := Constants_storage.cost_per_byte c in
    Error_monad.op_gtgteqquestion
      (Lwt.__return
        (Tez_repr.op_starquestion cost_per_byte (Z.to_int64 consumed)))
      (fun to_burn =>
        if Tez_repr.op_eq to_burn Tez_repr.zero then
          Error_monad.__return c
        else
          Error_monad.op_gtgteqquestion
            (Error_monad.trace extensible_type_value
              (Error_monad.op_gtgteqquestion
                (Contract_storage.must_exist c payer)
                (fun function_parameter =>
                  let '_ := function_parameter in
                  Contract_storage.spend c payer to_burn)))
            (fun c => Error_monad.__return c)).

Definition check_storage_limit
  (c : Raw_context.context) (storage_limit : (|Compare.Z|).(Compare.S.t))
  : Error_monad.tzresult unit :=
  if
    Pervasives.op_pipepipe
      ((|Compare.Z|).(Compare.S.op_gt) storage_limit
        (Raw_context.constants c).(Constants_repr.parametric.hard_storage_limit_per_operation))
      ((|Compare.Z|).(Compare.S.op_lt) storage_limit Z.zero) then
    Error_monad.__error_value extensible_type_value
  else
    Error_monad.ok tt.

Definition start_counting_storage_fees (c : Raw_context.t) : Raw_context.t :=
  Raw_context.init_storage_space_to_pay c.
