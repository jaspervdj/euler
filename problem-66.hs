{-# LANGUAGE BangPatterns #-}

import qualified ContinuedFraction as ContinuedFraction
import           Data.Maybe        (maybeToList)
import           Data.Ratio
import           SquareRoot

solveDiophantine :: Int -> Maybe (Integer, Integer)
solveDiophantine d
    | isSquare (fromIntegral d) = Nothing
    | otherwise                 = go 1
  where
    cf           = ContinuedFraction.find d
    solution x y = x * x - fromIntegral d * y * y == 1

    go i =
        let !c = ContinuedFraction.converge i cf
            !x = numerator c
            !y = denominator c
        in if solution x y then Just (x, y) else go (i + 1)

main :: IO ()
main = print $ snd $ maximum
    [ (x, d)
    | d      <- [1 .. 1000]
    , (x, _) <- maybeToList $ solveDiophantine d
    ]
