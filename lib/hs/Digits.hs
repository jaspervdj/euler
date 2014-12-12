--------------------------------------------------------------------------------
{-# LANGUAGE BangPatterns #-}
module Digits
    ( digits
    ) where


--------------------------------------------------------------------------------
digits :: Integer -> [Int]
digits = go []
  where
    go acc n
        | n >= 10    =
            let (d, !m) = divMod n 10 in go (fromIntegral m : acc) d
        | otherwise  = fromIntegral n : acc
