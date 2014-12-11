let rec pick n ls =
  match ls with
  | []      -> if n == 0 then [[]] else []
  | x :: xs ->
    if n > 0 then List.map (fun l -> x :: l) (pick (n - 1) xs) @ pick n xs
    else [[]];;

let odd x =
  x mod 2 == 1;;

let cardinality_of_set_union cardinality sets =
  let len = List.length sets in
  let rec go acc n =
    if n > len then
      acc
    else
      let sum = List.fold_left (fun a u -> a + cardinality u) 0 (pick n sets) in
      let acc' = if odd n then acc + sum else acc - sum in
      go acc' (n + 1) in
  go 0 1;;

let find_phi found_phi limit =
  let divisible = Array.make (limit + 1) 0 in
  let divisible_by_all factors =
    Array.get divisible (List.fold_left (fun x y -> x * y) 1 factors) in

  let rec go n =
    if n > limit then
      ()
    else begin
      let factors = Utils.distinct_prime_factors n in
      let divisors = Utils.proper_divisors n in
      let phi = (n - 1) - cardinality_of_set_union divisible_by_all factors in
      List.iter (fun d -> divisible.(d) <- divisible.(d) + 1) divisors;
      divisible.(n) <- divisible.(n) + 1;
      found_phi n phi;
      go (n + 1)
    end in

  go 2;;

let max_n_phi_ref = ref (2, Num.num_of_int 2) in
let found_phi n phi =
  let (max_n, max_n_phi) = !max_n_phi_ref in
  let n_phi = Num.div_num (Num.num_of_int n) (Num.num_of_int phi) in
  if Num.ge_num n_phi max_n_phi then max_n_phi_ref := (n, n_phi)
  else () in
find_phi found_phi 1000000;
let (max_n, _) = !max_n_phi_ref in
print_int max_n;
print_string "\n";;
