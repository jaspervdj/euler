triangle :: [Int]
triangle = [n * (n + 1) `div` 2 | n <- [1 ..]]

pentagonal :: [Int]
pentagonal = [n * (3 * n - 1) `div` 2 | n <- [1 ..]]

hexagonal :: [Int]
hexagonal = [n * (2 * n - 1) | n <- [1 ..]]

intersection :: Ord a => [[a]] -> [a]
intersection []             = []
intersection ([]       : _) = []
intersection ((x : xs) : lists)
    | all equalHead lists   = x : intersection (xs : map (drop 1) lists)
    | otherwise             = intersection (deleteMin x xs lists)
  where
    equalHead []      = False
    equalHead (y : _) = y == x

    deleteMin _ ys  []             = [ys]
    deleteMin y ys ([]       : ls) = [] : deleteMin y ys ls
    deleteMin y ys ((z : zs) : ls)
        | y < z                  = (z : zs) : deleteMin y ys ls
        | otherwise              = (y : ys) : deleteMin z zs ls

main :: IO ()
main = print $ take 3 $ intersection [triangle, pentagonal, hexagonal]
