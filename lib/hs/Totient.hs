--------------------------------------------------------------------------------
{-# LANGUAGE BangPatterns #-}
module Totient
    ( phi
    ) where


--------------------------------------------------------------------------------
import           Data.Ratio (Ratio)
import           Primes     (isDivBy)


--------------------------------------------------------------------------------
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
