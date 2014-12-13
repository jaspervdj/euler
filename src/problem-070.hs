import           Control.Monad.State (evalState)
import           Data.List           (sort)
import           Primes.State
import           Totient             (phi)

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
