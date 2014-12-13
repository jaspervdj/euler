--------------------------------------------------------------------------------
import           Data.List (foldl')
import qualified Data.Map  as M
import           Primes    (isCoprime)


--------------------------------------------------------------------------------
-- | Euclid's formula
pythagoreanTriples :: [(Int, Int, Int)]
pythagoreanTriples =
    [ (m * m - n * n, 2 * m * n, m * m + n * n)
    | m <- [2 ..]
    , n <- [1 .. m - 1]
    , odd (m - n)
    , isCoprime m n
    ]


--------------------------------------------------------------------------------
frequencies :: Ord a => [a] -> M.Map a Int
frequencies = foldl' (\m x -> M.insertWith' (+) x 1 m) M.empty


--------------------------------------------------------------------------------
main :: IO ()
main = print $
    M.size $
    M.filter (== 1) $
    frequencies $
    concatMap (\l -> [l, l + l .. limit]) $
    map (\(a, b, c) -> a + b + c) $
    takeWhile (\(a, b, c) -> a <= limit && b <= limit && c <= limit) $
    pythagoreanTriples
  where
    limit = 1500000
