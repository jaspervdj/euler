let rec num_ways_to_make num terms =
  match terms with
  | []      -> 0
  | [2]     -> if num mod 2 == 0 then 1 else 0
  | x :: xs ->
    if x > num then num_ways_to_make num xs
    else if x == num then 1 + num_ways_to_make num xs
    else num_ways_to_make (num - x) (x :: xs) + num_ways_to_make num xs;;

let rec find_num_ways_to_make limit =
  let sieve = Sieve.make limit in
  let primes = List.rev (Sieve.list_of_sieve sieve) in

  let rec go i =
    let terms = Utils.drop_while (fun p -> p >= i) primes in
    if num_ways_to_make i terms >= limit then i
    else go (i + 1) in

  go 2;;

print_int (find_num_ways_to_make 5000);
print_string "\n";;
