fact :: Integer -> Integer
fact 0 = 1
fact n = product [1 .. n]

comb :: Integer -> Integer -> Integer
comb n r = fact n `div` (fact (n - r) * fact r)

main :: IO ()
main = print $ length
    [ (n, r)
    | n <- [1 .. 100]
    , r <- [1 .. n]
    , comb n r > 1000000
    ]
