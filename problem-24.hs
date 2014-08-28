--------------------------------------------------------------------------------
import Data.List (foldl')
import Data.List (sort)


--------------------------------------------------------------------------------
-- | How many permutations can we make with N distinct elements?
numPermutations :: [a] -> Int
numPermutations xs = foldl' (*) 1 [1 .. length xs]


--------------------------------------------------------------------------------
-- | Precondition: list should be sorted.
nthPermutation :: Ord a => Int -> [a] -> [a]
nthPermutation _ []       = []
nthPermutation _ [x]      = [x]
nthPermutation n (x : xs)
    | n <= num  = x : nthPermutation n (sort xs)
    | otherwise = case xs of
        []     -> []
        y : ys -> nthPermutation (n - num) (y : ys ++ [x])
  where
    num = numPermutations xs


--------------------------------------------------------------------------------
main :: IO ()
main = putStrLn $ concat $ map show $
    nthPermutation (1000 * 1000) [0 :: Int .. 9]
