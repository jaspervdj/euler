--------------------------------------------------------------------------------
{-# LANGUAGE BangPatterns #-}


--------------------------------------------------------------------------------
import qualified Data.Set    as S
import qualified Data.Vector as V
import           Digits


--------------------------------------------------------------------------------
-- | Precomputed factorials
factorials :: V.Vector Integer
factorials = V.generate 10 $ \idx -> product [1 .. fromIntegral idx]
{-# NOINLINE factorials #-}


--------------------------------------------------------------------------------
sumFactorials :: Integer -> Integer
sumFactorials = sum . map (factorials V.!) . digits


--------------------------------------------------------------------------------
findRepeat
    :: Ord a
    => (a -> a)  -- ^ Next element
    -> a         -- ^ Starting element
    -> Int       -- ^ Length of repeating chain
findRepeat next = go S.empty 0
  where
    go visited !i x
        | x `S.member` visited = i
        | otherwise            = go (S.insert x visited) (i + 1) (next x)


--------------------------------------------------------------------------------
main :: IO ()
main = print $ length
    [ n
    | n <- [1 .. 1000000]
    , findRepeat sumFactorials n == 60
    ]
