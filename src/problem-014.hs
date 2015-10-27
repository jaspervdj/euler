import           Control.Monad       (forM)
import           Control.Monad.State (State, get, modify, evalState)
import           Data.List           (maximumBy)
import qualified Data.Map            as M
import           Data.Ord            (comparing)

nextCollatz :: Int -> Int
nextCollatz n
    | even n    = n `div` 2
    | otherwise = n * 3 + 1

collatzLength :: Int -> State (M.Map Int Int) Int
collatzLength 1 = return 1
collatzLength n = do
    cache <- get
    case M.lookup n cache of
        Just len -> return len
        Nothing  -> do
            len <- collatzLength (nextCollatz n)
            modify $ M.insert n (len + 1)
            return (len + 1)

main :: IO ()
main =
    print $ fst $ maximumBy (comparing snd) (evalState lengths M.empty)
  where
    lengths = forM [1 .. 1000000] $ \n -> do
        len <- collatzLength n
        return (n, len)
