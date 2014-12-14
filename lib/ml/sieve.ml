type sieve = bool array

let idx i = (i / 2) - 1;;
let rev_idx p = (p + 1) * 2 + 1;;

let make (limit : int) : sieve =
  let sieve = Array.make (idx limit) true in

  let scrap p =
    let rec go x =
      if x >= limit then ()
      else if x mod 2 == 0 then go (x + p)
      else (Array.set sieve (idx x) false; go (x + p)) in
    go (p + p) in

  let rec check p =
    if p >= limit then ()
    else begin
      if Array.get sieve (idx p) then scrap p else ();
      check (p + 2)
    end in

  check 3;
  sieve;;

let is_prime (sieve : sieve) (p : int) : bool =
  if p < 2 then false
  else if p == 2 then true
  else if p mod 2 == 0 then false
  else Array.get sieve (idx p);;

let list_of_sieve (sieve : sieve) : int list =
  let rec go acc i =
    if i < 0 then acc
    else if Array.get sieve i then go (rev_idx i :: acc) (i - 1)
    else go acc (i - 1) in

  2 :: go [] (Array.length sieve - 1);;
