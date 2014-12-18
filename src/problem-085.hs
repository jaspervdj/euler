--------------------------------------------------------------------------------
import           Data.List (foldl', minimumBy)
import           Data.Ord  (comparing)


--------------------------------------------------------------------------------
data Rect = Rect !Int !Int
    deriving (Show)


--------------------------------------------------------------------------------
area :: Rect -> Int
area (Rect w h) = w * h


--------------------------------------------------------------------------------
numFits :: Rect -> Rect -> Int
numFits (Rect w1 h1) (Rect w2 h2)
    | w1 > w2 || h1 > h2 = 0
    | otherwise          = (w2 - w1 + 1) * (h2 - h1 + 1)


--------------------------------------------------------------------------------
numContained :: Rect -> Int
numContained (Rect w h) = foldl' (+) 0
    [numFits (Rect w' h') (Rect w h) | w' <- [1 .. w], h' <- [1 .. h]]


--------------------------------------------------------------------------------
main :: IO ()
main = do
    putStrLn $ show rect ++ " has " ++ show num ++ " rectangles"
    putStrLn $ "Area: " ++ show (area rect)
  where
    goal = 2000000

    (_, (num, rect)) = minimumBy (comparing fst) $
        [ let c = numContained (Rect w h) in (abs (goal - c), (c, Rect w h))
        | w <- [1 .. 100]
        , h <- [1 .. w]
        ]
