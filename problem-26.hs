--------------------------------------------------------------------------------
{-# LANGUAGE BangPatterns #-}
import           Control.Applicative ((<$>))
import           Control.Monad.State (State, evalState, get, modify)
import           Data.List           (maximumBy)
import           Data.Map            (Map)
import qualified Data.Map            as M
import           Data.Ord            (comparing)


--------------------------------------------------------------------------------
data Trace = Trace
    { tSeen :: Map Int Int
    , tTick :: Int
    }


--------------------------------------------------------------------------------
emptyTrace :: Trace
emptyTrace = Trace M.empty 0


--------------------------------------------------------------------------------
recurring :: Int -> Int -> State Trace Int
recurring 0 _ = return 0
recurring n x = do
    seen  <- tSeen <$> get
    !tick <- tTick <$> get
    case M.lookup n seen of
        Just tick' -> return (tick - tick')
        Nothing
            | n < x     -> recurring (n * 10) x
            | otherwise -> do
                modify $ \t -> t
                    {tTick = tick + 1, tSeen = M.insert n tick seen}
                let (_, m) = n `divMod` x in recurring m x


--------------------------------------------------------------------------------
main :: IO ()
main = print $ maximumBy
    (comparing (\d -> evalState (recurring 1 d) emptyTrace))
    [1 .. 999]
