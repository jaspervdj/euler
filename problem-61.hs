import Select

triangle :: [Int]
triangle = [n * (n + 1) `div` 2 | n <- [1 ..]]

square :: [Int]
square = [n * n | n <- [1 ..]]

pentagonal :: [Int]
pentagonal = [n * (3 * n - 1) `div` 2 | n <- [1 ..]]

hexagonal :: [Int]
hexagonal = [n * (2 * n - 1) | n <- [1 ..]]

heptagonal :: [Int]
heptagonal = [n * (5 * n - 3) `div` 2 | n <- [1 ..]]

octagonal :: [Int]
octagonal = [n * (3 * n - 2) | n <- [1 ..]]

with4digits :: [Int] -> [Int]
with4digits = takeWhile (< 10000) . dropWhile (< 1000)

match4digits :: Int -> Int -> Bool
match4digits x y = x `mod` 100 == y `div` 100

findCycles :: (a -> a -> Bool) -> [[a]] -> [[a]]
findCycles connects pools0 = case pools0 of
    []              -> []
    (pool : pools)  -> [cyc | x <- pool, cyc <- go x x pools]
  where
    go x0 x []
        | connects x x0 = [[x]]
        | otherwise     = []
    go x0 x pools       =
        [ x : cyc
        | (pool, pools') <- select pools
        , x'             <- pool
        , connects x x'
        , cyc            <- go x0 x' pools'
        ]

main :: IO ()
main = case cycles of
    []      -> putStrLn "No solution found"
    (c : _) -> print $ sum c
  where
    cycles = findCycles match4digits
        [ with4digits triangle
        , with4digits square
        , with4digits pentagonal
        , with4digits hexagonal
        , with4digits heptagonal
        , with4digits octagonal
        ]
