--------------------------------------------------------------------------------
{-# LANGUAGE BangPatterns #-}


--------------------------------------------------------------------------------
import           Control.Monad (guard)
import           Data.Char     (digitToInt)
import           Data.List     (unfoldr)


--------------------------------------------------------------------------------
type Digits = [Int]


--------------------------------------------------------------------------------
toDigits :: Int -> Digits
toDigits = map digitToInt . show


--------------------------------------------------------------------------------
take2digits :: Digits -> (Int, Int, Digits)
take2digits = takeLastPair [] . reverse
  where
    takeLastPair acc [x, y]       = (y, x, acc)
    takeLastPair acc [x]          = (0, x, acc)
    takeLastPair acc []           = (0, 0, acc)
    takeLastPair acc (x : y : xs) = takeLastPair (y : x : acc) xs


--------------------------------------------------------------------------------
findXY :: Integer -> Integer -> (Int, Integer)
findXY p c = go 9
  where
    go !x =
        let y = fromIntegral x * (20 * p + fromIntegral x)
        in if y <= c then (x, y) else go (x - 1)


--------------------------------------------------------------------------------
findRoot :: Digits -> Digits
findRoot digits0 = unfoldr
    (\(digits, remainder, p) -> do
        guard $ not (remainder == 0 && null digits)
        let (x, digits', remainder', p') = step digits remainder p
        Just (x, (digits', remainder', p')))
    (digits0, 0, 0)
  where
    step :: Digits -> Integer -> Integer -> (Int, Digits, Integer, Integer)
    step digits remainder p =
        (x, digits', remainder', p')
      where
        (d1, d2, digits') = take2digits digits
        c = remainder * 100 + fromIntegral d1 * 10 + fromIntegral d2
        (x, y) = findXY p c
        remainder' = c - y
        p' = p * 10 + fromIntegral x


--------------------------------------------------------------------------------
main :: IO ()
main = print $ sum
    [ sum $ take 100 $ findRoot (toDigits x)
    | x <- [1 .. 100]
    , let s = sqrt (fromIntegral x) :: Double in floor s * floor s /= x
    ]
