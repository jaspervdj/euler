import           Data.List (find, foldl')
import qualified Data.Map  as M

type Order a = M.Map a [a]

insertSample :: Ord a => [a] -> Order a -> Order a
insertSample []       order = order
insertSample (x : xs) order = insertSample xs $
    foldl'
        (\o y -> M.insertWith' (++) x [y] o)
        (M.insertWith' (++) x [] order)
        xs

delete :: Ord a => a -> Order a -> Order a
delete x = fmap (filter (/= x)) . M.delete x

findLast :: Ord a => Order a -> Maybe a
findLast order = find (maybe True null . flip M.lookup order) (M.keys order)

toList :: Ord a => Order a -> [a]
toList = go []
  where
    go acc order = case findLast order of
        Nothing -> acc
        Just l  -> go (l : acc) (delete l order)

main :: IO ()
main = do
    samples <- lines <$> readFile "in/p079_keylog.txt"
    putStrLn $ toList $ foldl' (\o s -> insertSample s o) M.empty samples
