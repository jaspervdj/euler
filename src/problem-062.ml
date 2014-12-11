module CubicFamilies = Map.Make(String);;

module CubicFamily = Set.Make(struct
  type t = Big_int.big_int
  let compare x y = Big_int.compare_big_int x y
end);;

let cubic_family_key c =
  let l = Utils.list_of_string (Big_int.string_of_big_int c) in
  Utils.string_of_list (List.sort compare l);;

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
