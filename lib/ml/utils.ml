let prime_factors n =
  let rec go i x =
      if i * i > x then [x]
      else if x mod i == 0 then i :: go i (x / i)
      else go (i + 1) x in
  go 2 n;;

let distinct_prime_factors n =
  let rec go ls =
    match ls with
    | []           -> []
    | [x]          -> [x]
    | x :: y :: zs -> if x == y then go (y :: zs) else x :: go (y :: zs) in
  go (prime_factors n);;

let proper_divisors n =
  let rec go i =
    if i * i > n then []
    else if i * i == n then [i]
    else if n mod i == 0 then i :: n / i :: go (i + 1)
    else go (i + 1) in
  go 2;;

let print_list print_element ls =
  let rec go l = match l with
    | []      -> ()
    | x :: [] -> print_element x
    | x :: xs -> (print_element x; print_string "; "; go xs) in
  print_string "[";
  go ls;
  print_string "]";;
