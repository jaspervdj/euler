{-# LANGUAGE BangPatterns #-}

import           Data.Ratio (Ratio, denominator, numerator)

numDigits :: Integer -> Int
numDigits = go 1
  where
    go !acc n
        | n >= 10   = go (acc + 1) (n `div` 10)
        | otherwise = acc

approximateSqrt2 :: Int -> Ratio Integer
approximateSqrt2 n = 1 + 1 / go (n - 1)
  where
    go :: Int -> Ratio Integer
    go i
        | i <= 0    = 2
        | otherwise = 2 + 1 / go (i - 1)

main :: IO ()
main = print $
    length $
    filter (\s -> numDigits (numerator s) > numDigits (denominator s)) $
    map approximateSqrt2 [1 .. 1000]
