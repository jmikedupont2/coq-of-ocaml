(** Generated by coq-of-ocaml *)
Require Import OCaml.OCaml.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Open Scope type_scope.
Import ListNotations.

Unset Positivity Checking.
Unset Guard Checking.

Require Import Tezos.Environment.
Require Tezos.Contract_repr.
Require Tezos.Delegate_storage_mli. Module Delegate_storage := Delegate_storage_mli.
Require Tezos.Gas_limit_repr.
Require Tezos.Manager_repr.
Require Tezos.Michelson_v1_primitives.
Require Tezos.Raw_context.
Require Tezos.Roll_storage.
Require Tezos.Script_expr_hash.
Require Tezos.Script_repr.
Require Tezos.Storage_mli. Module Storage := Storage_mli.
Require Tezos.Storage_sigs.
Require Tezos.Tez_repr.

(* ❌ Structure item `typext` not handled. *)
(* type_extension *)

(* ❌ Top-level evaluations are ignored *)
(* top_level_evaluation *)

Definition failwith {A : Set} (msg : string) : Lwt.t (Error_monad.tzresult A) :=
  Error_monad.fail extensible_type_value.

Module big_map_diff_item.
  Module Update.
    Record record {big_map diff_key diff_key_hash diff_value : Set} := {
      big_map : big_map;
      diff_key : diff_key;
      diff_key_hash : diff_key_hash;
      diff_value : diff_value }.
    Arguments record : clear implicits.
  End Update.
  Definition Update_skeleton := Update.record.
  
  Module Alloc.
    Record record {big_map key_type value_type : Set} := {
      big_map : big_map;
      key_type : key_type;
      value_type : value_type }.
    Arguments record : clear implicits.
  End Alloc.
  Definition Alloc_skeleton := Alloc.record.
End big_map_diff_item.

Reserved Notation "'big_map_diff_item.Update".
Reserved Notation "'big_map_diff_item.Alloc".

Inductive big_map_diff_item : Set :=
| Update : 'big_map_diff_item.Update -> big_map_diff_item
| Clear : Z.t -> big_map_diff_item
| Copy : Z.t -> Z.t -> big_map_diff_item
| Alloc : 'big_map_diff_item.Alloc -> big_map_diff_item

where "'big_map_diff_item.Update" :=
  (big_map_diff_item.Update_skeleton Z.t Script_repr.expr Script_expr_hash.t
    (option Script_repr.expr))
and "'big_map_diff_item.Alloc" :=
  (big_map_diff_item.Alloc_skeleton Z.t Script_repr.expr Script_repr.expr).

Module ConstructorRecordNotations_big_map_diff_item.
  Module big_map_diff_item.
    Definition Update := 'big_map_diff_item.Update.
    Definition Alloc := 'big_map_diff_item.Alloc.
  End big_map_diff_item.
End ConstructorRecordNotations_big_map_diff_item.
Import ConstructorRecordNotations_big_map_diff_item.

Definition big_map_diff := list big_map_diff_item.

Definition big_map_diff_item_encoding
  : Data_encoding.encoding big_map_diff_item :=
  Data_encoding.union None
    [
      Data_encoding.__case_value "update" None (Data_encoding.Tag 0)
        (Data_encoding.obj5
          (Data_encoding.req None None "action"
            (Data_encoding.constant "update"))
          (Data_encoding.req None None "big_map" Data_encoding.z)
          (Data_encoding.req None None "key_hash" Script_expr_hash.encoding)
          (Data_encoding.req None None "key" Script_repr.expr_encoding)
          (Data_encoding.opt None None "value" Script_repr.expr_encoding))
        (fun function_parameter =>
          match function_parameter with
          |
            Update {|
              big_map_diff_item.Update.big_map := big_map;
                big_map_diff_item.Update.diff_key := diff_key;
                big_map_diff_item.Update.diff_key_hash :=
                  diff_key_hash;
                big_map_diff_item.Update.diff_value := diff_value
                |} =>
            Some (tt, big_map, diff_key_hash, diff_key, diff_value)
          | _ => None
          end)
        (fun function_parameter =>
          let '(_, big_map, diff_key_hash, diff_key, diff_value) :=
            function_parameter in
          Update
            {| big_map_diff_item.Update.big_map := big_map;
              big_map_diff_item.Update.diff_key := diff_key;
              big_map_diff_item.Update.diff_key_hash := diff_key_hash;
              big_map_diff_item.Update.diff_value := diff_value |});
      Data_encoding.__case_value "remove" None (Data_encoding.Tag 1)
        (Data_encoding.obj2
          (Data_encoding.req None None "action"
            (Data_encoding.constant "remove"))
          (Data_encoding.req None None "big_map" Data_encoding.z))
        (fun function_parameter =>
          match function_parameter with
          | Clear big_map => Some (tt, big_map)
          | _ => None
          end)
        (fun function_parameter =>
          let '(_, big_map) := function_parameter in
          Clear big_map);
      Data_encoding.__case_value "copy" None (Data_encoding.Tag 2)
        (Data_encoding.obj3
          (Data_encoding.req None None "action"
            (Data_encoding.constant "copy"))
          (Data_encoding.req None None "source_big_map" Data_encoding.z)
          (Data_encoding.req None None "destination_big_map" Data_encoding.z))
        (fun function_parameter =>
          match function_parameter with
          | Copy src dst => Some (tt, src, dst)
          | _ => None
          end)
        (fun function_parameter =>
          let '(_, src, dst) := function_parameter in
          Copy src dst);
      Data_encoding.__case_value "alloc" None (Data_encoding.Tag 3)
        (Data_encoding.obj4
          (Data_encoding.req None None "action"
            (Data_encoding.constant "alloc"))
          (Data_encoding.req None None "big_map" Data_encoding.z)
          (Data_encoding.req None None "key_type" Script_repr.expr_encoding)
          (Data_encoding.req None None "value_type"
            Script_repr.expr_encoding))
        (fun function_parameter =>
          match function_parameter with
          |
            Alloc {|
              big_map_diff_item.Alloc.big_map := big_map;
                big_map_diff_item.Alloc.key_type := key_type;
                big_map_diff_item.Alloc.value_type := value_type
                |} => Some (tt, big_map, key_type, value_type)
          | _ => None
          end)
        (fun function_parameter =>
          let '(_, big_map, key_type, value_type) := function_parameter in
          Alloc
            {| big_map_diff_item.Alloc.big_map := big_map;
              big_map_diff_item.Alloc.key_type := key_type;
              big_map_diff_item.Alloc.value_type := value_type |})
    ].

Definition big_map_diff_encoding
  : Data_encoding.encoding (list big_map_diff_item) :=
  Pervasives.op_atat
    (let arg := Data_encoding.def "contract.big_map_diff" in
    fun eta => arg None None eta)
    (Data_encoding.__list_value None big_map_diff_item_encoding).

Definition big_map_key_cost : Z := 65.

Definition big_map_cost : Z := 33.

Definition update_script_big_map
  (c :
    (|Storage.Big_map.Total_bytes|).(Storage_sigs.Indexed_data_storage.context))
  (function_parameter : option (list big_map_diff_item))
  : Lwt.t
    (Error_monad.tzresult
      ((|Storage.Big_map.Total_bytes|).(Storage_sigs.Indexed_data_storage.context)
        * Z.t)) :=
  match function_parameter with
  | None => Error_monad.__return (c, Z.zero)
  | Some diff =>
    Error_monad.fold_left_s
      (fun function_parameter =>
        let '(c, total) := function_parameter in
        fun function_parameter =>
          match function_parameter with
          | Clear id =>
            Error_monad.op_gtgteqquestion
              ((|Storage.Big_map.Total_bytes|).(Storage_sigs.Indexed_data_storage.get)
                c id)
              (fun size =>
                Error_monad.op_gtgteq (Storage.Big_map.remove_rec c id)
                  (fun c =>
                    if (|Compare.Z|).(Compare.S.op_lt) id Z.zero then
                      Error_monad.__return (c, total)
                    else
                      Error_monad.__return
                        (c, (Z.sub (Z.sub total size) (Z.of_int big_map_cost)))))
          | Copy from to_ =>
            Error_monad.op_gtgteqquestion (Storage.Big_map.copy c from to_)
              (fun c =>
                if (|Compare.Z|).(Compare.S.op_lt) to_ Z.zero then
                  Error_monad.__return (c, total)
                else
                  Error_monad.op_gtgteqquestion
                    ((|Storage.Big_map.Total_bytes|).(Storage_sigs.Indexed_data_storage.get)
                      c from)
                    (fun size =>
                      Error_monad.__return
                        (c, (Z.add (Z.add total size) (Z.of_int big_map_cost)))))
          |
            Alloc {|
              big_map_diff_item.Alloc.big_map := big_map;
                big_map_diff_item.Alloc.key_type := key_type;
                big_map_diff_item.Alloc.value_type := value_type
                |} =>
            Error_monad.op_gtgteqquestion
              ((|Storage.Big_map.Total_bytes|).(Storage_sigs.Indexed_data_storage.init)
                c big_map Z.zero)
              (fun c =>
                let key_type :=
                  Micheline.strip_locations
                    (Script_repr.strip_annotations (Micheline.root key_type)) in
                let value_type :=
                  Micheline.strip_locations
                    (Script_repr.strip_annotations (Micheline.root value_type))
                  in
                Error_monad.op_gtgteqquestion
                  ((|Storage.Big_map.Key_type|).(Storage_sigs.Indexed_data_storage.init)
                    c big_map key_type)
                  (fun c =>
                    Error_monad.op_gtgteqquestion
                      ((|Storage.Big_map.Value_type|).(Storage_sigs.Indexed_data_storage.init)
                        c big_map value_type)
                      (fun c =>
                        if (|Compare.Z|).(Compare.S.op_lt) big_map Z.zero then
                          Error_monad.__return (c, total)
                        else
                          Error_monad.__return
                            (c, (Z.add total (Z.of_int big_map_cost))))))
          |
            Update {|
              big_map_diff_item.Update.big_map := big_map;
                big_map_diff_item.Update.diff_key_hash := diff_key_hash;
                big_map_diff_item.Update.diff_value := None
                |} =>
            Error_monad.op_gtgteqquestion
              ((|Storage.Big_map.Contents|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.remove)
                (c, big_map) diff_key_hash)
              (fun function_parameter =>
                let '(c, freed, existed) := function_parameter in
                let freed :=
                  if existed then
                    Pervasives.op_plus freed big_map_key_cost
                  else
                    freed in
                Error_monad.op_gtgteqquestion
                  ((|Storage.Big_map.Total_bytes|).(Storage_sigs.Indexed_data_storage.get)
                    c big_map)
                  (fun size =>
                    Error_monad.op_gtgteqquestion
                      ((|Storage.Big_map.Total_bytes|).(Storage_sigs.Indexed_data_storage.set)
                        c big_map (Z.sub size (Z.of_int freed)))
                      (fun c =>
                        if (|Compare.Z|).(Compare.S.op_lt) big_map Z.zero then
                          Error_monad.__return (c, total)
                        else
                          Error_monad.__return
                            (c, (Z.sub total (Z.of_int freed))))))
          |
            Update {|
              big_map_diff_item.Update.big_map := big_map;
                big_map_diff_item.Update.diff_key_hash := diff_key_hash;
                big_map_diff_item.Update.diff_value := Some v
                |} =>
            Error_monad.op_gtgteqquestion
              ((|Storage.Big_map.Contents|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.init_set)
                (c, big_map) diff_key_hash v)
              (fun function_parameter =>
                let '(c, size_diff, existed) := function_parameter in
                let size_diff :=
                  if existed then
                    size_diff
                  else
                    Pervasives.op_plus size_diff big_map_key_cost in
                Error_monad.op_gtgteqquestion
                  ((|Storage.Big_map.Total_bytes|).(Storage_sigs.Indexed_data_storage.get)
                    c big_map)
                  (fun size =>
                    Error_monad.op_gtgteqquestion
                      ((|Storage.Big_map.Total_bytes|).(Storage_sigs.Indexed_data_storage.set)
                        c big_map (Z.add size (Z.of_int size_diff)))
                      (fun c =>
                        if (|Compare.Z|).(Compare.S.op_lt) big_map Z.zero then
                          Error_monad.__return (c, total)
                        else
                          Error_monad.__return
                            (c, (Z.add total (Z.of_int size_diff))))))
          end) (c, Z.zero) diff
  end.

Definition create_base (c : Raw_context.t) (op_staroptstar : option bool)
  : Contract_repr.contract ->
  (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.value) ->
  option (|Signature.Public_key_hash|).(S.SPublic_key_hash.t) ->
  option (|Signature.Public_key_hash|).(S.SPublic_key_hash.t) ->
  option (Script_repr.t * option (list big_map_diff_item)) -> unit ->
  Lwt.t (Error_monad.tzresult Raw_context.t) :=
  let prepaid_bootstrap_storage :=
    match op_staroptstar with
    | Some op_starsthstar => op_starsthstar
    | None => false
    end in
  fun contract =>
    fun balance =>
      fun manager =>
        fun delegate =>
          fun script =>
            fun function_parameter =>
              let '_ := function_parameter in
              Error_monad.op_gtgteqquestion
                match Contract_repr.is_implicit contract with
                | None => Error_monad.__return c
                | Some _ =>
                  Error_monad.op_gtgteqquestion
                    (Storage.Contract.Global_counter.get c)
                    (fun counter =>
                      (|Storage.Contract.Counter|).(Storage_sigs.Indexed_data_storage.init)
                        c contract counter)
                end
                (fun c =>
                  Error_monad.op_gtgteqquestion
                    ((|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.init)
                      c contract balance)
                    (fun c =>
                      Error_monad.op_gtgteqquestion
                        match manager with
                        | Some manager =>
                          (|Storage.Contract.Manager|).(Storage_sigs.Indexed_data_storage.init)
                            c contract (Manager_repr.Hash manager)
                        | None => Error_monad.__return c
                        end
                        (fun c =>
                          Error_monad.op_gtgteqquestion
                            match delegate with
                            | None => Error_monad.__return c
                            | Some delegate =>
                              Delegate_storage.init c contract delegate
                            end
                            (fun c =>
                              match script with
                              |
                                Some
                                  ({|
                                    Script_repr.t.code := code;
                                      Script_repr.t.storage := storage
                                      |}, big_map_diff) =>
                                Error_monad.op_gtgteqquestion
                                  ((|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.init)
                                    c contract code)
                                  (fun function_parameter =>
                                    let '(c, code_size) := function_parameter in
                                    Error_monad.op_gtgteqquestion
                                      ((|Storage.Contract.Storage|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.init)
                                        c contract storage)
                                      (fun function_parameter =>
                                        let '(c, storage_size) :=
                                          function_parameter in
                                        Error_monad.op_gtgteqquestion
                                          (update_script_big_map c big_map_diff)
                                          (fun function_parameter =>
                                            let '(c, big_map_size) :=
                                              function_parameter in
                                            let total_size :=
                                              Z.add
                                                (Z.add (Z.of_int code_size)
                                                  (Z.of_int storage_size))
                                                big_map_size in
                                            (* ❌ Sequences of instructions are ignored (operator ";") *)
                                            (* ❌ instruction_sequence ";" *)
                                            let prepaid_bootstrap_storage :=
                                              if prepaid_bootstrap_storage then
                                                total_size
                                              else
                                                Z.zero in
                                            Error_monad.op_gtgteqquestion
                                              ((|Storage.Contract.Paid_storage_space|).(Storage_sigs.Indexed_data_storage.init)
                                                c contract
                                                prepaid_bootstrap_storage)
                                              (fun c =>
                                                (|Storage.Contract.Used_storage_space|).(Storage_sigs.Indexed_data_storage.init)
                                                  c contract total_size))))
                              | None => Error_monad.__return c
                              end)))).

Definition originate
  (c : Raw_context.t) (prepaid_bootstrap_storage : option bool)
  (contract : Contract_repr.contract)
  (balance :
    (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.value))
  (script : Script_repr.t * option (list big_map_diff_item))
  (delegate : option (|Signature.Public_key_hash|).(S.SPublic_key_hash.t))
  : Lwt.t (Error_monad.tzresult Raw_context.t) :=
  create_base c prepaid_bootstrap_storage contract balance None delegate
    (Some script) tt.

Definition create_implicit
  (c : Raw_context.t)
  (manager : (|Signature.Public_key_hash|).(S.SPublic_key_hash.t))
  (balance :
    (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.value))
  : Lwt.t (Error_monad.tzresult Raw_context.t) :=
  create_base c None (Contract_repr.implicit_contract manager) balance
    (Some manager) None None tt.

Definition delete (c : Raw_context.t) (contract : Contract_repr.contract)
  : Lwt.t (Error_monad.tzresult Raw_context.t) :=
  match Contract_repr.is_implicit contract with
  | None => failwith "Non implicit contracts cannot be removed"
  | Some _ =>
    Error_monad.op_gtgteqquestion (Delegate_storage.remove c contract)
      (fun c =>
        Error_monad.op_gtgteqquestion
          ((|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.delete)
            c contract)
          (fun c =>
            Error_monad.op_gtgteqquestion
              ((|Storage.Contract.Manager|).(Storage_sigs.Indexed_data_storage.delete)
                c contract)
              (fun c =>
                Error_monad.op_gtgteqquestion
                  ((|Storage.Contract.Counter|).(Storage_sigs.Indexed_data_storage.delete)
                    c contract)
                  (fun c =>
                    Error_monad.op_gtgteqquestion
                      ((|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.remove)
                        c contract)
                      (fun function_parameter =>
                        let '(c, _, _) := function_parameter in
                        Error_monad.op_gtgteqquestion
                          ((|Storage.Contract.Storage|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.remove)
                            c contract)
                          (fun function_parameter =>
                            let '(c, _, _) := function_parameter in
                            Error_monad.op_gtgteq
                              ((|Storage.Contract.Paid_storage_space|).(Storage_sigs.Indexed_data_storage.remove)
                                c contract)
                              (fun c =>
                                Error_monad.op_gtgteq
                                  ((|Storage.Contract.Used_storage_space|).(Storage_sigs.Indexed_data_storage.remove)
                                    c contract)
                                  (fun c => Error_monad.__return c))))))))
  end.

Definition allocated
  (c : (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.context))
  (contract :
    (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.key))
  : Lwt.t (Error_monad.tzresult bool) :=
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.get_option)
      c contract)
    (fun function_parameter =>
      match function_parameter with
      | None => Error_monad.return_false
      | Some _ => Error_monad.return_true
      end).

Definition __exists
  (c : (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.context))
  (contract : Contract_repr.contract) : Lwt.t (Error_monad.tzresult bool) :=
  match Contract_repr.is_implicit contract with
  | Some _ => Error_monad.return_true
  | None => allocated c contract
  end.

Definition must_exist
  (c : (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.context))
  (contract : Contract_repr.contract) : Lwt.t (Error_monad.tzresult unit) :=
  Error_monad.op_gtgteqquestion (__exists c contract)
    (fun function_parameter =>
      match function_parameter with
      | true => Error_monad.return_unit
      | false => Error_monad.fail extensible_type_value
      end).

Definition must_be_allocated
  (c : (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.context))
  (contract :
    (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.key))
  : Lwt.t (Error_monad.tzresult unit) :=
  Error_monad.op_gtgteqquestion (allocated c contract)
    (fun function_parameter =>
      match function_parameter with
      | true => Error_monad.return_unit
      | false =>
        match Contract_repr.is_implicit contract with
        | Some pkh => Error_monad.fail extensible_type_value
        | None => Error_monad.fail extensible_type_value
        end
      end).

Definition __list_value (c : Raw_context.t) : Lwt.t (list Contract_repr.t) :=
  Storage.Contract.__list_value c.

Definition fresh_contract_from_current_nonce (c : Raw_context.t)
  : Lwt.t (Error_monad.tzresult (Raw_context.t * Contract_repr.contract)) :=
  Error_monad.op_gtgteqquestion
    (Lwt.__return (Raw_context.increment_origination_nonce c))
    (fun function_parameter =>
      let '(c, __nonce_value) := function_parameter in
      Error_monad.__return
        (c, (Contract_repr.originated_contract __nonce_value))).

Definition originated_from_current_nonce
  (ctxt_since : Raw_context.t) (ctxt_until : Raw_context.t)
  : Lwt.t (Error_monad.tzresult (list Contract_repr.contract)) :=
  Error_monad.op_gtgteqquestion
    (Lwt.__return (Raw_context.origination_nonce ctxt_since))
    (fun since =>
      Error_monad.op_gtgteqquestion
        (Lwt.__return (Raw_context.origination_nonce ctxt_until))
        (fun until =>
          Error_monad.filter_map_s
            (fun contract =>
              Error_monad.op_gtgteqquestion (__exists ctxt_until contract)
                (fun function_parameter =>
                  match function_parameter with
                  | true => Error_monad.return_some contract
                  | false => Error_monad.return_none
                  end)) (Contract_repr.originated_contracts since until))).

Definition check_counter_increment
  (c : (|Storage.Contract.Counter|).(Storage_sigs.Indexed_data_storage.context))
  (manager : (|Signature.Public_key_hash|).(S.SPublic_key_hash.t))
  (counter : (|Compare.Z|).(Compare.S.t)) : Lwt.t (Error_monad.tzresult unit) :=
  let contract := Contract_repr.implicit_contract manager in
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Counter|).(Storage_sigs.Indexed_data_storage.get) c
      contract)
    (fun contract_counter =>
      let expected := Z.succ contract_counter in
      if (|Compare.Z|).(Compare.S.op_eq) expected counter then
        Error_monad.return_unit
      else
        if (|Compare.Z|).(Compare.S.op_gt) expected counter then
          Error_monad.fail extensible_type_value
        else
          Error_monad.fail extensible_type_value).

Definition increment_counter
  (c : Raw_context.t)
  (manager : (|Signature.Public_key_hash|).(S.SPublic_key_hash.t))
  : Lwt.t (Error_monad.tzresult Raw_context.t) :=
  let contract := Contract_repr.implicit_contract manager in
  Error_monad.op_gtgteqquestion (Storage.Contract.Global_counter.get c)
    (fun global_counter =>
      Error_monad.op_gtgteqquestion
        (Storage.Contract.Global_counter.set c (Z.succ global_counter))
        (fun c =>
          Error_monad.op_gtgteqquestion
            ((|Storage.Contract.Counter|).(Storage_sigs.Indexed_data_storage.get)
              c contract)
            (fun contract_counter =>
              (|Storage.Contract.Counter|).(Storage_sigs.Indexed_data_storage.set)
                c contract (Z.succ contract_counter)))).

Definition get_script_code
  (c :
    (|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.context))
  (contract :
    (|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.key))
  : Lwt.t
    (Error_monad.tzresult
      (Raw_context.t *
        option
          (|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.value))) :=
  (|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.get_option)
    c contract.

Definition get_script
  (c :
    (|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.context))
  (contract :
    (|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.key))
  : Lwt.t (Error_monad.tzresult (Raw_context.t * option Script_repr.t)) :=
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.get_option)
      c contract)
    (fun function_parameter =>
      let '(c, code) := function_parameter in
      Error_monad.op_gtgteqquestion
        ((|Storage.Contract.Storage|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.get_option)
          c contract)
        (fun function_parameter =>
          let '(c, storage) := function_parameter in
          match (code, storage) with
          | (None, None) => Error_monad.__return (c, None)
          | (Some code, Some storage) =>
            Error_monad.__return
              (c,
                (Some
                  {| Script_repr.t.code := code;
                    Script_repr.t.storage := storage |}))
          | (None, Some _) | (Some _, None) => failwith "get_script"
          end)).

Definition get_storage
  (ctxt :
    (|Storage.Contract.Storage|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.context))
  (contract :
    (|Storage.Contract.Storage|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.key))
  : Lwt.t (Error_monad.tzresult (Raw_context.t * option Script_repr.expr)) :=
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Storage|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.get_option)
      ctxt contract)
    (fun function_parameter =>
      match function_parameter with
      | (ctxt, None) => Error_monad.__return (ctxt, None)
      | (ctxt, Some storage) =>
        Error_monad.op_gtgteqquestion
          (Lwt.__return (Script_repr.force_decode storage))
          (fun function_parameter =>
            let '(storage, cost) := function_parameter in
            Error_monad.op_gtgteqquestion
              (Lwt.__return (Raw_context.consume_gas ctxt cost))
              (fun ctxt => Error_monad.__return (ctxt, (Some storage))))
      end).

Definition get_counter
  (c : (|Storage.Contract.Counter|).(Storage_sigs.Indexed_data_storage.context))
  (manager : (|Signature.Public_key_hash|).(S.SPublic_key_hash.t))
  : Lwt.t (Error_monad.tzresult Z.t) :=
  let contract := Contract_repr.implicit_contract manager in
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Counter|).(Storage_sigs.Indexed_data_storage.get_option)
      c contract)
    (fun function_parameter =>
      match function_parameter with
      | None =>
        match Contract_repr.is_implicit contract with
        | Some _ => Storage.Contract.Global_counter.get c
        | None => failwith "get_counter"
        end
      | Some v => Error_monad.__return v
      end).

Definition get_manager_key
  (c : (|Storage.Contract.Manager|).(Storage_sigs.Indexed_data_storage.context))
  (manager : (|Signature.Public_key_hash|).(S.SPublic_key_hash.t))
  : Lwt.t (Error_monad.tzresult (|Signature.Public_key|).(S.SPublic_key.t)) :=
  let contract := Contract_repr.implicit_contract manager in
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Manager|).(Storage_sigs.Indexed_data_storage.get_option)
      c contract)
    (fun function_parameter =>
      match function_parameter with
      | None => failwith "get_manager_key"
      | Some (Manager_repr.Hash _) => Error_monad.fail extensible_type_value
      | Some (Manager_repr.Public_key v) => Error_monad.__return v
      end).

Definition is_manager_key_revealed
  (c : (|Storage.Contract.Manager|).(Storage_sigs.Indexed_data_storage.context))
  (manager : (|Signature.Public_key_hash|).(S.SPublic_key_hash.t))
  : Lwt.t (Error_monad.tzresult bool) :=
  let contract := Contract_repr.implicit_contract manager in
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Manager|).(Storage_sigs.Indexed_data_storage.get_option)
      c contract)
    (fun function_parameter =>
      match function_parameter with
      | None => Error_monad.return_false
      | Some (Manager_repr.Hash _) => Error_monad.return_false
      | Some (Manager_repr.Public_key _) => Error_monad.return_true
      end).

Definition reveal_manager_key
  (c : (|Storage.Contract.Manager|).(Storage_sigs.Indexed_data_storage.context))
  (manager : (|Signature.Public_key_hash|).(S.SPublic_key_hash.t))
  (public_key : (|Signature.Public_key|).(S.SPublic_key.t))
  : Lwt.t (Error_monad.tzresult Raw_context.t) :=
  let contract := Contract_repr.implicit_contract manager in
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Manager|).(Storage_sigs.Indexed_data_storage.get) c
      contract)
    (fun function_parameter =>
      match function_parameter with
      | Manager_repr.Public_key _ => Error_monad.fail extensible_type_value
      | Manager_repr.Hash v =>
        let actual_hash :=
          (|Signature.Public_key|).(S.SPublic_key.__hash_value) public_key in
        if
          (|Signature.Public_key_hash|).(S.SPublic_key_hash.equal) actual_hash v
          then
          let v := Manager_repr.Public_key public_key in
          Error_monad.op_gtgteqquestion
            ((|Storage.Contract.Manager|).(Storage_sigs.Indexed_data_storage.set)
              c contract v) (fun c => Error_monad.__return c)
        else
          Error_monad.fail extensible_type_value
      end).

Definition get_balance
  (c : (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.context))
  (contract :
    (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.key))
  : Lwt.t (Error_monad.tzresult Tez_repr.t) :=
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.get_option)
      c contract)
    (fun function_parameter =>
      match function_parameter with
      | None =>
        match Contract_repr.is_implicit contract with
        | Some _ => Error_monad.__return Tez_repr.zero
        | None => failwith "get_balance"
        end
      | Some v => Error_monad.__return v
      end).

Definition update_script_storage
  (c :
    (|Storage.Big_map.Total_bytes|).(Storage_sigs.Indexed_data_storage.context))
  (contract :
    (|Storage.Contract.Storage|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.key))
  (storage : Script_repr.expr) (big_map_diff : option (list big_map_diff_item))
  : Lwt.t (Error_monad.tzresult Raw_context.t) :=
  let storage := Script_repr.__lazy_expr_value storage in
  Error_monad.op_gtgteqquestion (update_script_big_map c big_map_diff)
    (fun function_parameter =>
      let '(c, big_map_size_diff) := function_parameter in
      Error_monad.op_gtgteqquestion
        ((|Storage.Contract.Storage|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.set)
          c contract storage)
        (fun function_parameter =>
          let '(c, size_diff) := function_parameter in
          Error_monad.op_gtgteqquestion
            ((|Storage.Contract.Used_storage_space|).(Storage_sigs.Indexed_data_storage.get)
              c contract)
            (fun previous_size =>
              let new_size :=
                Z.add previous_size
                  (Z.add big_map_size_diff (Z.of_int size_diff)) in
              (|Storage.Contract.Used_storage_space|).(Storage_sigs.Indexed_data_storage.set)
                c contract new_size))).

Definition spend
  (c : (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.context))
  (contract :
    (|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.key))
  (amount : Tez_repr.t) : Lwt.t (Error_monad.tzresult Raw_context.t) :=
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.get) c
      contract)
    (fun balance =>
      match Tez_repr.op_minusquestion balance amount with
      | Pervasives.Error _ => Error_monad.fail extensible_type_value
      | Pervasives.Ok new_balance =>
        Error_monad.op_gtgteqquestion
          ((|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.set)
            c contract new_balance)
          (fun c =>
            Error_monad.op_gtgteqquestion
              (Roll_storage.Contract.remove_amount c contract amount)
              (fun c =>
                if Tez_repr.op_gt new_balance Tez_repr.zero then
                  Error_monad.__return c
                else
                  match Contract_repr.is_implicit contract with
                  | None => Error_monad.__return c
                  | Some pkh =>
                    Error_monad.op_gtgteqquestion
                      (Delegate_storage.get c contract)
                      (fun function_parameter =>
                        match function_parameter with
                        | Some pkh' =>
                          (* ❌ Sequences of instructions are ignored (operator ";") *)
                          (* ❌ instruction_sequence ";" *)
                          Error_monad.__return c
                        | None => delete c contract
                        end)
                  end))
      end).

Definition credit
  (c :
    (|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.context))
  (contract :
    (|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.key))
  (amount : Tez_repr.t) : Lwt.t (Error_monad.tzresult Raw_context.t) :=
  Error_monad.op_gtgteqquestion
    (if Tez_repr.op_ltgt amount Tez_repr.zero then
      Error_monad.__return c
    else
      Error_monad.op_gtgteqquestion
        ((|Storage.Contract.Code|).(Storage_sigs.Non_iterable_indexed_carbonated_data_storage.mem)
          c contract)
        (fun function_parameter =>
          let '(c, target_has_code) := function_parameter in
          Error_monad.op_gtgteqquestion
            (Error_monad.fail_unless target_has_code extensible_type_value)
            (fun function_parameter =>
              let '_ := function_parameter in
              Error_monad.__return c)))
    (fun c =>
      Error_monad.op_gtgteqquestion
        ((|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.get_option)
          c contract)
        (fun function_parameter =>
          match function_parameter with
          | None =>
            match Contract_repr.is_implicit contract with
            | None => Error_monad.fail extensible_type_value
            | Some manager => create_implicit c manager amount
            end
          | Some balance =>
            Error_monad.op_gtgteqquestion
              (Lwt.__return (Tez_repr.op_plusquestion amount balance))
              (fun balance =>
                Error_monad.op_gtgteqquestion
                  ((|Storage.Contract.Balance|).(Storage_sigs.Indexed_data_storage.set)
                    c contract balance)
                  (fun c => Roll_storage.Contract.add_amount c contract amount))
          end)).

Definition init (c : Raw_context.t)
  : Lwt.t (Error_monad.tzresult Raw_context.t) :=
  Storage.Contract.Global_counter.init c Z.zero.

Definition used_storage_space
  (c :
    (|Storage.Contract.Used_storage_space|).(Storage_sigs.Indexed_data_storage.context))
  (contract :
    (|Storage.Contract.Used_storage_space|).(Storage_sigs.Indexed_data_storage.key))
  : Lwt.t (Error_monad.tzresult Z.t) :=
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Used_storage_space|).(Storage_sigs.Indexed_data_storage.get_option)
      c contract)
    (fun function_parameter =>
      match function_parameter with
      | None => Error_monad.__return Z.zero
      | Some fees => Error_monad.__return fees
      end).

Definition paid_storage_space
  (c :
    (|Storage.Contract.Paid_storage_space|).(Storage_sigs.Indexed_data_storage.context))
  (contract :
    (|Storage.Contract.Paid_storage_space|).(Storage_sigs.Indexed_data_storage.key))
  : Lwt.t (Error_monad.tzresult Z.t) :=
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Paid_storage_space|).(Storage_sigs.Indexed_data_storage.get_option)
      c contract)
    (fun function_parameter =>
      match function_parameter with
      | None => Error_monad.__return Z.zero
      | Some paid_space => Error_monad.__return paid_space
      end).

Definition set_paid_storage_space_and_return_fees_to_pay
  (c :
    (|Storage.Contract.Paid_storage_space|).(Storage_sigs.Indexed_data_storage.context))
  (contract :
    (|Storage.Contract.Paid_storage_space|).(Storage_sigs.Indexed_data_storage.key))
  (new_storage_space : (|Compare.Z|).(Compare.S.t))
  : Lwt.t
    (Error_monad.tzresult
      (Z.t *
        (|Storage.Contract.Paid_storage_space|).(Storage_sigs.Indexed_data_storage.context))) :=
  Error_monad.op_gtgteqquestion
    ((|Storage.Contract.Paid_storage_space|).(Storage_sigs.Indexed_data_storage.get)
      c contract)
    (fun already_paid_space =>
      if (|Compare.Z|).(Compare.S.op_gteq) already_paid_space new_storage_space
        then
        Error_monad.__return (Z.zero, c)
      else
        let to_pay := Z.sub new_storage_space already_paid_space in
        Error_monad.op_gtgteqquestion
          ((|Storage.Contract.Paid_storage_space|).(Storage_sigs.Indexed_data_storage.set)
            c contract new_storage_space)
          (fun c => Error_monad.__return (to_pay, c))).
