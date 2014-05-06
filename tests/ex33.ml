(** Module type *)

module type M = sig
  val n : int

  type 'a t1 =
    | C1 of int
    | C2 of 'a * bool

  type t2 = {
    f1 : int;
    f2 : bool }

  type 'a t3 = int * 'a

  exception E of string
end

(*module type M = sig
  type t
  val m : int
  module N : sig
    val n : t
    type t
  end
  open N
  val b : t
end

module M : M = struct
  let null = (0, false)
  type t = int
  let m = 12
  let b = false
  module N = struct
    type t = bool
    let n = 14
  end
end*)