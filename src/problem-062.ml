module CubicFamilies = Map.Make(String);;

module CubicFamily = Set.Make(struct
  type t = Big_int.big_int
  let compare x y = Big_int.compare_big_int x y
end);;

let list_of_string str =
  let rec go acc i =
    if i < 0 then acc
    else go (String.get str i :: acc) (i - 1) in
  go [] (String.length str - 1);;

let string_of_list l =
  let bytes = Bytes.create (List.length l) in
  let go i c = Bytes.set bytes i c; i + 1 in
  let _ = List.fold_left go 0 l in
  Bytes.to_string bytes;;

let cubic_family_key c =
  let l = list_of_string (Big_int.string_of_big_int c) in
  string_of_list (List.sort compare l);;

let insert_cubic c families =
  let key = cubic_family_key c in
  if CubicFamilies.mem key families then
    let family = CubicFamily.add c (CubicFamilies.find key families) in
    (CubicFamily.cardinal family, CubicFamilies.add key family families)
  else
    let family = CubicFamily.singleton c in
    (1, CubicFamilies.add key family families);;

let find_family_of_size n =
  let rec go families i =
    let c = Big_int.power_int_positive_int i 3 in
    let (size, families') = insert_cubic c families in
    if size >= n then
      let key = cubic_family_key c in
      let family = CubicFamilies.find key families' in
      CubicFamily.min_elt family
    else
      go families' (i + 1) in

  go CubicFamilies.empty 1;;

print_string (Big_int.string_of_big_int (find_family_of_size 5));
print_string "\n";;
