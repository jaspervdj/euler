-- | Taken from <https://www.haskell.org/haskellwiki/Generic_number_type>
module SquareRoot
    ( squareRoot
    , isSquare
    ) where

import           Data.Maybe (isJust)

(^!) :: Num a => a -> Int -> a
(^!) x n = x^n

squareRoot :: Integer -> Maybe Integer
squareRoot n =
    let sr = squareRoot' n in if sr * sr == n then Just sr else Nothing

squareRoot' :: Integer -> Integer
squareRoot' 0 = 0
squareRoot' 1 = 1
squareRoot' n =
   let twopows = iterate (^!2) 2
       (lowerRoot, lowerN) =
          last $ takeWhile ((n>=) . snd) $ zip (1:twopows) twopows
       newtonStep x = div (x + div n x) 2
       iters = iterate newtonStep (squareRoot' (div n lowerN) * lowerRoot)
       isRoot r  =  r^!2 <= n && n < (r+1)^!2
   in  head $ dropWhile (not . isRoot) iters

isSquare :: Integer -> Bool
isSquare = isJust . squareRoot
