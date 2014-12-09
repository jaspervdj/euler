let concat x y =
  let rec go ten =
    if ten > y then x * ten + y
    else go (ten * 10) in
  go 10;;

let is_prime x =
  let rec go i =
    if i * i > x then true
    else if x mod i == 0 then false
    else go (i + 1) in
  go 2;;

let primes_below x =
  let rec go acc i =
    if i >= x then acc
    else if is_prime i then go (i :: acc) (i + 1)
    else go acc (i + 1) in
  go [] 2;;

let child_of_family l x =
  List.for_all (fun y -> x < y) l &&
  List.for_all (fun y -> is_prime (concat x y) && is_prime (concat y x)) l;;

let extend_families ls primes =
  let extend_family acc0 l =
    List.fold_left
      (fun acc p -> if child_of_family l p then ((p :: l) :: acc) else acc)
      acc0 primes in
  List.fold_left extend_family [] ls;;

let print_int_list ls =
  let rec go l = match l with
    | []      -> ()
    | x :: [] -> print_int x
    | x :: xs -> (print_int x; print_string "; "; go xs) in
  print_string "[";
  go ls;
  print_string "]";;

let primes = primes_below 10000 in
let extended1 = List.map (fun x -> [x]) primes in
let extended2 = extend_families extended1 primes in
let extended3 = extend_families extended2 primes in
let extended4 = extend_families extended3 primes in
let extended5 = extend_families extended4 primes in
List.iter (fun l -> print_int_list l; print_string "\n") extended5;
match extended5 with
  | []       -> ()
  | (x :: _) -> begin
    print_string "Sum: ";
    print_int (List.fold_left (+) 0 x);
    print_string "\n"
  end
