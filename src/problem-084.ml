type tile =
  | Road
  | Start
  | Jail
  | FreeParking
  | GoToJail
  | Chance
  | Chest
  | Railway
  | Utility;;

let board =
  let b = Array.make 40 Road in
  b.(0)  <- Start;
  b.(2)  <- Chest;
  b.(5)  <- Railway;
  b.(7)  <- Chance;
  b.(10) <- Jail;
  b.(12) <- Utility;
  b.(15) <- Railway;
  b.(17) <- Chest;
  b.(20) <- FreeParking;
  b.(22) <- Chance;
  b.(25) <- Railway;
  b.(28) <- Utility;
  b.(30) <- GoToJail;
  b.(33) <- Chest;
  b.(35) <- Railway;
  b.(36) <- Chance;
  b;;

let go_to_start = 0;;

let go_to_jail = 10;;

let go_to_next t pos =
  let rec go i =
    if i >= Array.length board then go 0
    else if board.(i) == t then i
    else go (i + 1) in
  go (pos + 1);;

let go_forward n pos =
  if pos + n < Array.length board then pos + n
  else pos + n - Array.length board;;

let go_back n pos =
  if pos - n < 0 then Array.length board + pos - n else pos - n;;

let throw_two_dices n =
  let x = Random.int n + 1 in
  let y = Random.int n + 1 in
  (x, y);;

let make_deck =
  let pos = ref 0 in
  let next () = let c = !pos in pos := (c + 1) mod 16; c + 1 in
  next;;

let chance_deck = make_deck;;

let chest_deck = make_deck;;

let rec rules num_doubles x y pos0 =
  if x == y && num_doubles >= 3 then go_to_jail
  else
    let pos1 = go_forward (x + y) pos0 in
    match board.(pos1) with
    | GoToJail -> go_to_jail
    | Chest    -> (match chest_deck () with
      | 1 -> go_to_start
      | 2 -> go_to_jail
      | _ -> pos1)
    | Chance -> (match chance_deck () with
      | 1  -> go_to_start
      | 2  -> go_to_jail
      | 3  -> 11
      | 4  -> 24
      | 5  -> 39
      | 6  -> 5
      | 7  -> go_to_next Railway pos1
      | 8  -> go_to_next Railway pos1
      | 9  -> go_to_next Utility pos1
      | 10 -> rules num_doubles x y (go_back 3 pos1)
      | _  -> pos1)
    | _ -> pos1

let simulate dice steps =
  let freqs = Array.make (Array.length board) 0 in
  let rec go num_doubles i pos =
    if i >= steps then ()
    else
      let (x, y) = throw_two_dices dice in
      let num_doubles' =
        if num_doubles >= 3 then 0
        else if x == y then num_doubles + 1
        else 0 in
      let pos' = rules num_doubles' x y pos in
      let i' = i + 1 in
      freqs.(pos') <- freqs.(pos') + 1;
      go num_doubles' i' pos' in
  go 0 0 0;
  freqs;;

let freqs = simulate 4 10000000 in
let best = Array.init (Array.length freqs) (fun i -> (i, freqs.(i))) in
Array.sort (fun (_, x) (_, y) -> y - x) best;
for i = 0 to 39 do
  let (tile, score) = best.(i) in
  Printf.printf "%02d" tile;
  print_string ": ";
  print_int score;
  print_string "\n"
done;
print_string "Modal string: ";
for i = 0 to 2 do
  Printf.printf "%02d" (fst best.(i))
done;
print_string "\n";;
