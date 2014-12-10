--------------------------------------------------------------------------------
import           Control.Monad.State (State, evalState)


--------------------------------------------------------------------------------
import           Primes


--------------------------------------------------------------------------------
search :: Int -> [Int]
search numFactors = evalState (go 1 []) emptyPrimes
  where
    go :: Int -> [Int] -> State Primes [Int]
    go n found
        | length found == numFactors = return found
        | otherwise                  = do
            factors <- distinctPrimeFactors n
            if length factors == numFactors
                then go (n + 1) (found ++ [n])
                else go (n + 1) []


--------------------------------------------------------------------------------
main :: IO ()
main = print $ search 4
