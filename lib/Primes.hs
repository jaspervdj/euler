--------------------------------------------------------------------------------
module Primes
    ( Primes
    , emptyPrimes
    , isPrime
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
                takeWhile (\x -> x * x < n) . IS.toAscList . pPrimes <$> get
            let prime = all (n `isNotDivBy`) smallerPrimes
            modify $ \p -> p
                { pPrimes        = if prime
                                    then IS.insert n (pPrimes p)
                                    else pPrimes p
                , pLargestTested = n
                }
            return prime
  where
    isNotDivBy x y = x `mod` y /= 0
