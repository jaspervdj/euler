import           Control.Monad       (filterM, replicateM)
import           Control.Monad.State (State, evalState)
import           Data.Char           (intToDigit)
import           Data.List           (foldl', intercalate)
import           Primes

newtype Pattern = Pattern {unPattern :: [Element]}

data Element
    = Digit Int
    | Hole
    deriving (Eq)

instance Show Pattern where
    show = map (\el -> case el of
        Hole    -> '*'
        Digit d -> intToDigit d) . unPattern

eval :: Int -> Pattern -> Int
eval d =
    foldl' (\a e -> 10 * a + (case e of Hole -> d; Digit x -> x)) 0 . unPattern

patterns :: [Pattern]
patterns = filter hasHoles $ go 2
  where
    hasHoles = any (== Hole) . unPattern

    go n =
        map Pattern (replicateM n (Hole : map Digit [0 .. 9])) ++
        go (n + 1)

family :: Pattern -> State Primes [Int]
family pattern = filterM isPrime
    [eval d pattern | d <- [0 .. 9], d > 0 || not startsWithHole]
  where
    startsWithHole = case pattern of
        Pattern (Hole : _) -> True
        _                  -> False

findM :: Monad m => (a -> m Bool) -> [a] -> m (Maybe a)
findM p = go
  where
    go []       = return Nothing
    go (x : xs) = p x >>= \c -> if c then return (Just x) else go xs

main :: IO ()
main = case evalState findFamily emptyPrimes of
    Nothing         -> putStrLn "No solution found"
    Just (pat, fam) -> do
        putStrLn $ "Pattern: " ++ show pat
        putStrLn $ "Primes: " ++ intercalate ", " (map show fam)
        putStrLn $ "Solution: " ++ show (minimum fam)
  where
    findFamily = do
        mbPattern <- findM (fmap ((>= 8) . length) . family) patterns
        case mbPattern of
            Nothing      -> return Nothing
            Just pattern -> do
                fam <- family pattern
                return $ Just (pattern, fam)
