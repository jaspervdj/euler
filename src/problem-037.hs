--------------------------------------------------------------------------------
import           Control.Monad       (filterM)
import           Control.Monad.State (State, evalState)


--------------------------------------------------------------------------------
import           Primes.State


--------------------------------------------------------------------------------
truncateLeft :: Int -> Maybe Int
truncateLeft xs = case show xs of
    []       -> Nothing
    [_]      -> Nothing
    (_ : cs) -> Just (read cs)


--------------------------------------------------------------------------------
truncateRight :: Int -> Maybe Int
truncateRight x
    | x < 10    = Nothing
    | otherwise = Just (x `div` 10)


--------------------------------------------------------------------------------
truncations :: Int -> [Int]
truncations n = untilNothing truncateLeft n ++ untilNothing truncateRight n
  where
    untilNothing f x = case f x of
        Nothing -> []
        Just y  -> y : untilNothing f y


--------------------------------------------------------------------------------
isTruncatablePrime :: Int -> State Primes Bool
isTruncatablePrime n = do
    prime <- isPrime n
    if prime
        then and <$> mapM isPrime (truncations n)
        else return False


--------------------------------------------------------------------------------
main :: IO ()
main = print $
    evalState (sum . take 11 <$> filterM isTruncatablePrime [10 ..]) emptyPrimes
