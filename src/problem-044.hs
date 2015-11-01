import           Control.Monad       (forM)
import           Control.Monad.State (State, evalState, state)
import           Data.List           (sort)
import           Data.Maybe          (catMaybes, listToMaybe, maybeToList)
import qualified Data.Set            as S

data Pentagonals = Pentagonals
    { pKnown :: !(S.Set Int)
    , pN     :: !Int
    } deriving (Show)

instance Monoid Pentagonals where
    mempty = Pentagonals (S.singleton 1) 1
    mappend (Pentagonals k1 n1) (Pentagonals k2 n2) =
        Pentagonals (k1 `S.union` k2) (max n1 n2)

isPentagonal :: Int -> Pentagonals -> (Bool, Pentagonals)
isPentagonal x p
    | pentagonal (pN p) >= x = (x `S.member` pKnown p, p)
    | otherwise              = isPentagonal x p
        { pKnown = S.insert (pentagonal (pN p + 1)) (pKnown p)
        , pN     = pN p + 1
        }

pentagonal :: Int -> Int
pentagonal n = n * (3 * n - 1) `div` 2

go :: Maybe Int -> Int -> State Pentagonals Int
go mbD k = do
    ds <- fmap catMaybes $ forM [1 .. k - 1] $ \j -> do
        let pj = pentagonal j
        subPent <- state (isPentagonal (pk - pj))
        addPent <- state (isPentagonal (pk + pj))
        return $ if subPent && addPent then Just (abs (pk - pj)) else Nothing

    let mbD' = listToMaybe $ sort $ maybeToList mbD ++ ds
    case mbD' of
        Just d  -> return d
        Nothing -> go mbD' (k + 1)
  where
    pk = pentagonal k

main :: IO ()
main = print $ evalState (go Nothing 1) mempty
