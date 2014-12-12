import           Data.Ratio (Ratio, denominator, numerator, (%))

main :: IO ()
main = print $ length
    [ f
    | d <- [1 .. limit]
    , n <- [d `div` 3 .. (d + 1) `div` 2]
    , let f = n % d :: Ratio Int
    , f > 1 % 3
    , f < 1 % 2
    , denominator f == d
    , numerator f   == n
    ]
  where
    limit = 12000
