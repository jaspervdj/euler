import Select
import Primes

data Fraction = Fraction Int Int
    deriving (Show)

instance Eq Fraction where
    Fraction x1 y1 == Fraction x2 y2 = x1 * y2 == x2 * y1

mul :: Fraction -> Fraction -> Fraction
mul (Fraction x1 y1) (Fraction x2 y2) = Fraction (x1 * x2) (y1 * y2)

simplify :: Fraction -> Fraction
simplify (Fraction x y) = case simplifications of
    []      -> Fraction x y
    (s : _) -> simplify s
  where
    simplifications =
        [ Fraction (x `div` d) (y `div` d)
        | d <- takeWhile (<= x * x) [2 ..]
        , x `isDivBy` d
        , y `isDivBy` d
        ]

cancelDigits :: Fraction -> [Fraction]
cancelDigits (Fraction x y) =
    [ Fraction (read x'Str) (read y'Str)
    | (d, x'Str) <- select (show x)
    , y'Str      <- eliminate d (show y)
    ]

trivial :: Fraction -> Bool
trivial (Fraction x y) =
    x == y ||
    (y `mod` 10 == 0)

main :: IO ()
main = print $ simplify $ foldr1 mul
    [ Fraction x y
    | x         <- [10 .. 99]
    , y         <- [x  .. 99]
    , cancelled <- cancelDigits (Fraction x y)
    , Fraction x y == cancelled
    , not (trivial (Fraction x y))
    ]
