let pentagonal i =
  let k = if i mod 2 == 0 then -i / 2 else i / 2 + 1 in
  k * (3 * k - 1) / 2;;

let zero = Big_int.big_int_of_int 0;;

let make_cache n = Array.make n zero;;

let rec partition cache n =
  if n <= 1 then Big_int.big_int_of_int 1
  else if not (Big_int.eq_big_int cache.(n) zero) then cache.(n)
  else
    let rec go acc i =
      let m = n - pentagonal i in
      if m >= 0 then
        let p = partition cache m in
        let neg = if ((i + 1) / 2) mod 2 == 0 then true else false in
        let sp = if neg then Big_int.minus_big_int p else p in
        go (Big_int.add_big_int acc sp) (i + 1)
      else
        acc in
    let p = go zero 1 in
    cache.(n) <- p;
    p;;

let rec find_partition_zero_mod cache m i =
  if i >= Array.length cache then
    let cache' = Array.append cache (make_cache (Array.length cache)) in
    find_partition_zero_mod cache' m i
  else
    let p = partition cache i in
    if Big_int.eq_big_int (Big_int.mod_big_int p m) zero then i
    else find_partition_zero_mod cache m (i + 1);;

let cache = make_cache 32 in
let m = Big_int.big_int_of_int 1000000 in
print_int (find_partition_zero_mod cache m 0);
print_string "\n";
