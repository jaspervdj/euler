import qualified Data.Set as S

newtype Cube a = Cube (S.Set a)
    deriving (Eq, Ord, Show)

genCubes :: Ord a => Int -> [a] -> [Cube a]
genCubes 0 _        = [Cube S.empty]
genCubes _ []       = []
genCubes n (x : xs) =
    genCubes n xs ++
    [ Cube (S.insert x c)
    | Cube c <- genCubes (n - 1) xs
    ]

data Arrangement a = Arrangement (Cube a) (Cube a)
    deriving (Eq, Ord, Show)

mkArrangement :: Ord a => Cube a -> Cube a -> Arrangement a
mkArrangement c1 c2
    | c1 <= c2  = Arrangement c1 c2
    | otherwise = Arrangement c2 c1

canMakeAllSquares :: Arrangement Int -> Bool
canMakeAllSquares (Arrangement c1 c2) =
    all canMakeSquare squares
  where
    canMakeSquare (x, y) =
        (canMake x c1 && canMake y c2) ||
        (canMake x c2 && canMake y c1)

    canMake x (Cube s)
        | x == 6 || x == 9 = 6 `S.member` s || 9 `S.member` s
        | otherwise        = x `S.member` s

    squares =
        [ (0, 1)
        , (0, 4)
        , (0, 9)
        , (1, 6)
        , (2, 5)
        , (3, 6)
        , (4, 9)
        , (6, 4)
        , (8, 1)
        ]

main :: IO ()
main = print $ S.size $ S.fromList
    [ arrangement
    | cube1 <- genCubes 6 [0 .. 9]
    , cube2 <- genCubes 6 [0 .. 9]
    , let arrangement = mkArrangement cube1 cube2
    , canMakeAllSquares arrangement
    ]
