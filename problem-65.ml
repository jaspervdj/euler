let rec convergent terms =
  match terms with
  | []      -> Num.num_of_int 1
  | [x]     -> Num.num_of_int x
  | x :: xs -> Num.add_num
    (Num.num_of_int x)
    (Num.div_num (Num.num_of_int 1) (convergent xs));;

let terms_e n =
  let rec go k i =
    if i == 0 then []
    else if i == 1 then [1]
    else if i == 2 then [1; 2 * k]
    else 1 :: 2 * k :: 1 :: go (k + 1) (i - 3) in
  2 :: go 1 (n - 1);;

let numerator n =
  match n with
  | Num.Int     i  -> Big_int.big_int_of_int i
  | Num.Big_int bi -> bi
  | Num.Ratio   r  -> Ratio.numerator_ratio r;;

let denominator n =
  match n with
  | Num.Int     _  -> Big_int.big_int_of_int 1
  | Num.Big_int _  -> Big_int.big_int_of_int 1
  | Num.Ratio   r  -> Ratio.denominator_ratio r;;

let print_num n =
  print_string (Big_int.string_of_big_int (numerator n));
  print_string " / ";
  print_string (Big_int.string_of_big_int (denominator n));;

let sum_digits =
  let ten = Big_int.big_int_of_int 10 in
  let rec go acc x =
    if Big_int.lt_big_int x ten then
      acc + Big_int.int_of_big_int x
    else
      let (y, d) = Big_int.quomod_big_int x ten in
      go (acc + Big_int.int_of_big_int d) y in
  go 0;;

let c = convergent (terms_e 100) in
print_string "Convergent: ";
print_num c;
print_string "\n";
print_string "Sum of numerator digits: ";
print_int (sum_digits (numerator c));
print_string "\n";;
