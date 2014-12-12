import           Data.Ratio (Ratio, denominator, numerator, (%))

-- | Generate the fraction @n/d@ just smaller than the given fraction, with the
-- denominator being a fixed @d@.
fractionJustSmallerThanWithDenominator :: Int -> Ratio Int -> Ratio Int
fractionJustSmallerThanWithDenominator d ratio
    | se < ratio = se
    | otherwise  = (n - 1) % d
  where
    n  = numerator ratio * d `div` denominator ratio
    se = n % d  -- Smaller or equal than ratio

main :: IO ()
main = print $ maximum $
    [ fractionJustSmallerThanWithDenominator d (3 % 7)
    | d <- [1 .. 1000000]
    ]
