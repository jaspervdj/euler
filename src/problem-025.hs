--------------------------------------------------------------------------------
fibs :: [Integer]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)


--------------------------------------------------------------------------------
main :: IO ()
main = print $ fst $ head $
    dropWhile ((< 1000) . length . show . snd) $
    zip [1 :: Int .. ] fibs
