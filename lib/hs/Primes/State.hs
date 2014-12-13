--------------------------------------------------------------------------------
module Primes.State
    ( Primes
    , emptyPrimes
    , isPrime
    , primesUpUntil
    , primeFactors
    , distinctPrimeFactors
    , isDivBy
    , isNotDivBy
    ) where


--------------------------------------------------------------------------------
import           Control.Applicative ((<$>))
import           Control.Monad.State (State, get, modify)
import           Data.IntSet         (IntSet)
import qualified Data.IntSet         as IS


--------------------------------------------------------------------------------
data Primes = Primes
    { pPrimes        :: !IntSet
    , pLargestTested :: !Int
    } deriving (Show)


--------------------------------------------------------------------------------
emptyPrimes :: Primes
emptyPrimes = Primes (IS.fromList [2]) 2


--------------------------------------------------------------------------------
isPrime :: Int -> State Primes Bool
isPrime n = do
    primes <- get
    if n <= pLargestTested primes
        then return $ n `IS.member` pPrimes primes
        else do
            mapM_ isPrime [pLargestTested primes + 1 .. n - 1]
            smallerPrimes <-
                takeWhile (\x -> x * x <= n) . IS.toAscList . pPrimes <$> get
            let prime = all (n `isNotDivBy`) smallerPrimes
            modify $ \p -> p
                { pPrimes        = if prime
                                    then IS.insert n (pPrimes p)
                                    else pPrimes p
                , pLargestTested = n
                }
            return prime


--------------------------------------------------------------------------------
primesUpUntil :: Int -> State Primes [Int]
primesUpUntil n = do
    _ <- isPrime n
    takeWhile (<= n) . IS.toAscList . pPrimes <$> get


--------------------------------------------------------------------------------
primeFactors :: Int -> State Primes [Int]
primeFactors n = do
    primes <- primesUpUntil (floor $ sqrt $ (fromIntegral n :: Double))
    return $ factors n primes
  where
    factors x []        = [x]
    factors x (p : ps)
        | x == p        = [p]
        | x `isDivBy` p = p : factors (x `div` p) (p : ps)
        | otherwise     = factors x ps


--------------------------------------------------------------------------------
distinctPrimeFactors :: Int -> State Primes [Int]
distinctPrimeFactors = fmap distinct . primeFactors
  where
    distinct (x : y : zs)
        | x == y    = distinct (y : zs)
        | otherwise = x : distinct (y : zs)
    distinct zs     = zs


--------------------------------------------------------------------------------
isDivBy :: Int -> Int -> Bool
isDivBy x y = x `mod` y == 0


--------------------------------------------------------------------------------
isNotDivBy :: Int -> Int -> Bool
isNotDivBy x y = not (isDivBy x y)
