import           ContinuedFraction (ContinuedFraction)
import qualified ContinuedFraction as ContinuedFraction

hasOddPeriod :: ContinuedFraction -> Bool
hasOddPeriod (_, xs) = odd (length xs)

main :: IO ()
main = print $ length
    [ n
    | n <- [1 .. 10000]
    , hasOddPeriod (ContinuedFraction.find n)
    ]
