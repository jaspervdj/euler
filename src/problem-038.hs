import           Data.Maybe  (listToMaybe, maybeToList)
import           Data.Vector (Vector)
import qualified Data.Vector as V

nextPermutation :: Ord a => Vector a -> Maybe (Vector a)
nextPermutation v = do
    k <- findK (len - 2)
    let l = findL k (len - 1)
    return $ V.generate len $ \i ->
        if i < k
            then v V.! i
            else if i == k
                then v V.! l
                else let i' = len + k - i
                     in if i' == l
                        then v V.! k
                        else v V.! i'
  where
    len = V.length v

    findK i
        | i < 0                   = Nothing
        | v V.! i < v V.! (i + 1) = Just i
        | otherwise               = findK (i - 1)

    findL k i
        | v V.! k < v V.! i = i
        | otherwise         = findL k (i - 1)

nonEmptyInits :: [a] -> [([a], [a])]
nonEmptyInits []       = []
nonEmptyInits (x : xs) = ([x], xs) : [(x : y, ys) | (y, ys) <- nonEmptyInits xs]

dropPrefix :: String -> String -> Maybe String
dropPrefix []       xs = Just xs
dropPrefix (_ : _)  [] = Nothing
dropPrefix (y : ys) (x : xs)
    | y == x           = dropPrefix ys xs
    | otherwise        = Nothing

parseProduct :: String -> Maybe [(Int, Int)]
parseProduct str = listToMaybe $
    [ (1, n) : parse
    | (i, t) <- nonEmptyInits str
    , not (null t)
    , let n = read i
    , parse <- maybeToList $ go n 2 t
    ]
  where
    go _ _ "" = Just []
    go n i t  = do
        let prefix = n * i
        t' <- dropPrefix (show prefix) t
        ((i, n) :) <$> go n (i + 1) t'

newtype RevChar = RevChar {unRevChar :: Char}
    deriving (Eq)

instance Ord RevChar where
    RevChar x <= RevChar y = y <= x

showProduct :: [(Int, Int)] -> String
showProduct prod = unlines
    [show x ++ " x " ++ show y ++ " = " ++ show (x * y) | (x, y) <- prod]

main :: IO ()
main = case go (V.fromList $ map RevChar $ reverse ['1' .. '9']) of
    Nothing          -> putStrLn "No solution found"
    Just (str, prod) -> do
        putStrLn $ str ++ ":"
        putStr $ showProduct prod
  where
    go permutation =
        let str = map unRevChar $ V.toList permutation
        in case parseProduct str of
            Just prod -> Just (str, prod)
            Nothing   -> case nextPermutation permutation of
                Just permutation' -> go permutation'
                Nothing           -> Nothing
