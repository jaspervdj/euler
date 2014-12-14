let num_ways_to_make num =
  let rec go n x =
    if x <= 0 then 0
    else if x == 1 then 1
    else
      if x > n then go n (x - 1)
      else if x == n then 1 + go n (x - 1)
      else go (n - x) x + go n (x - 1)

  in go num (num - 1);;

for i = 1 to 100 do
  print_int i;
  print_string ": ";
  print_int (num_ways_to_make i);
  print_string "\n"
done;

print_int (num_ways_to_make 100);;
print_string "\n";;
