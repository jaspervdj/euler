{-# LANGUAGE BangPatterns #-}

reverseInteger :: Integer -> Integer
reverseInteger = go 0
  where
    go !acc !n
        | n <= 0    = acc
        | otherwise = let (!n', !x) = n `divMod` 10 in go (acc * 10 + x) n'

isLychrel :: Integer -> Bool
isLychrel n0 =
    let !r = reverseInteger n0
    in go 1 (r + n0)
  where
    go :: Int -> Integer -> Bool
    go !iteration !n
        | iteration >= 50 = True
        | otherwise       =
            let !r = reverseInteger n
            in if r == n then False else go (iteration + 1) (r + n)

main :: IO ()
main = print $ length $ filter isLychrel [1 .. 10000]
