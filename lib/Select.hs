--------------------------------------------------------------------------------
module Select
    ( select
    , selectN
    , selectRemainder
    , eliminate
    ) where


--------------------------------------------------------------------------------
select :: [a] -> [(a, [a])]
select []       = []
select (x : xs) = (x, xs) : [(y, x : ys) | (y, ys) <- select xs]


--------------------------------------------------------------------------------
selectN :: Int -> [a] -> [([a], [a])]
selectN = undefined


--------------------------------------------------------------------------------
selectRemainder :: [a] -> [[a]]
selectRemainder = undefined


--------------------------------------------------------------------------------
eliminate :: Eq a => a -> [a] -> [[a]]
eliminate _ []  = []
eliminate x (y : ys)
    | x == y    = ys : map (y :) (eliminate x ys)
    | otherwise = map (y :) (eliminate x ys)
