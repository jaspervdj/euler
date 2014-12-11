{-# LANGUAGE BangPatterns #-}

import           Control.Monad.State (evalState)
import           Data.List           (sort)
import           Data.Ratio
import           Primes

phi :: Int -> Int
phi n0 = floor $ go (fromIntegral n0) 2 n0
  where
    go :: Ratio Integer -> Int -> Int -> Ratio Integer
    go !acc p n
        | n == 1        = acc
        | p * p > n     = acc * (1 - (1 / fromIntegral n))
        | n `isDivBy` p = go
            (acc * (1 - (1 / fromIntegral p))) (p + 1) (n `divBy` p)
        | otherwise     = go acc (p + 1) n

    divBy x y =
        let x' = x `div` y
        in if x' `isDivBy` y then divBy x' y else x'

isPermutation :: Int -> Int -> Bool
isPermutation x y = sort (show x) == sort (show y)

main :: IO ()
main = print $ snd $ minimum
    [ (fromIntegral n / fromIntegral p :: Double, n)
    | p1 <- somePrimes
    , p2 <- somePrimes
    , let n = p1 * p2
    , n <= 10000000
    , let p = phi n
    , isPermutation p n
    ]
  where
    somePrimes = take 500 $ reverse $
        evalState (primesUpUntil 5000) emptyPrimes
