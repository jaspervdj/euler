--------------------------------------------------------------------------------
import           Primes.State
import           Select


--------------------------------------------------------------------------------
main :: IO ()
main = print $ sum
    [ fromDigits [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10]
    | (d10, digits9) <- select digits10
    , (d9, digits8)  <- select digits9
    , (d8, digits7)  <- select digits8, isDivBy3 d8 d9 d10 17
    , (d7, digits6)  <- select digits7, isDivBy3 d7 d8 d9  13
    , (d6, digits5)  <- select digits6, isDivBy3 d6 d7 d8  11
    , (d5, digits4)  <- select digits5, isDivBy3 d5 d6 d7  7
    , (d4, digits3)  <- select digits4, isDivBy3 d4 d5 d6  5
    , (d3, digits2)  <- select digits3, isDivBy3 d3 d4 d5  3
    , (d2, digits1)  <- select digits2, isDivBy3 d2 d3 d4  2
    , d1             <- digits1
    ]
  where
    digits10         = [0 .. 9]
    isDivBy3 x y z d = (x * 100 + y * 10 + z) `isDivBy` d
    fromDigits       = foldl (\a d -> a * 10 + d) 0
