{-# LANGUAGE BangPatterns #-}

digitSum :: Integer -> Int
digitSum = go 0
  where
    go !acc !n
        | n <= 0    = acc
        | otherwise =
            let (!n', !x) = n `divMod` 10
            in go (acc + fromIntegral x) n'

main :: IO ()
main = print $ maximum
    [ digitSum (a ^ b)
    | a <- [1 :: Integer .. 100]
    , b <- [1 :: Int     .. 100]
    ]
