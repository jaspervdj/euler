--------------------------------------------------------------------------------
module Primes
    ( isCoprime
    , primeFactors
    , distinctPrimeFactors
    ) where


--------------------------------------------------------------------------------
isCoprime :: Int -> Int -> Bool
isCoprime x y =
    all (\f -> y `mod` f /= 0) (distinctPrimeFactors x)


--------------------------------------------------------------------------------
primeFactors :: Int -> [Int]
primeFactors = go 2
  where
    go i x
        | i * i > x      = [x]
        | x `mod` i == 0 = i : go i (x `div` i)
        | otherwise      = go (i + 1) x


--------------------------------------------------------------------------------
distinctPrimeFactors :: Int -> [Int]
distinctPrimeFactors = distinct . primeFactors
  where
    distinct (x : y : zs)
        | x == y    = distinct (y : zs)
        | otherwise = x : distinct (y : zs)
    distinct zs     = zs
