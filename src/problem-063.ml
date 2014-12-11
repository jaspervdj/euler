let num_digits n =
  let ten = Big_int.big_int_of_int 10 in
  let rec go acc x =
    if Big_int.ge_big_int x ten then go (acc + 1) (Big_int.div_big_int x ten)
    else acc in
  go 1 n;;

let find_num_powerful base =
  let rec go acc exponent =
    let power = Big_int.power_int_positive_int base exponent in
    let digits = num_digits power in
    let acc' = if digits == exponent then acc + 1 else acc in
    if base < 10 && digits >= exponent then go acc' (exponent + 1)
    else acc' in
  go 0 1;;

let sum l =
  List.fold_left (+) 0 l;;

let num_powerful = sum (List.map find_num_powerful (Utils.range 1 9)) in
print_int num_powerful;
print_string "\n";;
