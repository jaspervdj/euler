--------------------------------------------------------------------------------
import           Control.Monad.State (State, evalState)


--------------------------------------------------------------------------------
import           Primes


--------------------------------------------------------------------------------
numConsecutive :: Int -> Int -> State Primes Int
numConsecutive a b = go 0
  where
    go n = do
        prime <- isPrime (n * n + a * n + b)
        if prime then go (n + 1) else return (max 0 (n - 1))


--------------------------------------------------------------------------------
maxConsecutive :: [(Int, Int)] -> State Primes (Maybe (Int, Int, Int))
maxConsecutive = go Nothing
  where
    go m []            = return m
    go m ((a, b) : xs) = do
        c <- numConsecutive a b
        case m of
            Nothing         -> go (Just (a, b, c)) xs
            Just (_, _, mc)
                | mc > c    -> go m                xs
                | otherwise -> go (Just (a, b, c)) xs


--------------------------------------------------------------------------------
main :: IO ()
main =
    let mbAbc = evalState
                    (maxConsecutive
                        [(a, b) | a <- [-1000 .. 1000], b <- [-1000 .. 1000]])
                    emptyPrimes
    in case mbAbc of
        Nothing        -> putStrLn "No solution found"
        Just (a, b, _) -> print $ a * b
