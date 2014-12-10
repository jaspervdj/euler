module ContinuedFraction
    ( ContinuedFraction
    , find
    , converge
    ) where

import           Data.Ratio (Ratio)

-- BaseForm r a b -> (sqrt(r) + a) / b
data BaseForm = BaseForm Int Int Int
    deriving (Eq)

instance Show BaseForm where
    show (BaseForm r a b) =
        "(√" ++ show r ++ " - " ++ show (negate a) ++ ") / " ++ show b

mkBaseForm :: Int -> BaseForm
mkBaseForm r = BaseForm r 0 1

baseFormVal :: BaseForm -> Double
baseFormVal (BaseForm r a b) =
    (sqrt (fromIntegral r) + fromIntegral a) / fromIntegral b

baseFormZero :: BaseForm -> Bool
baseFormZero (BaseForm r a _) = a * a == r

baseFormSubtract :: BaseForm -> Int -> BaseForm
baseFormSubtract (BaseForm r a b) x = BaseForm r (a - b * x) b

baseFormInvert :: BaseForm -> BaseForm
baseFormInvert (BaseForm r a b) =
    let b' = (r - (a * a)) `div` b
        a' = negate a
    in BaseForm r a' b'

baseFormReduce :: BaseForm -> Maybe (Int, BaseForm)
baseFormReduce bf
    | baseFormZero bf = Nothing
    | otherwise       =
        let v   = floor (baseFormVal bf)
            bf' = baseFormInvert (baseFormSubtract bf v)
        in Just (v, bf')

type ContinuedFraction = (Int, [Int])

find :: Int -> ContinuedFraction
find r = case baseFormReduce (mkBaseForm r) of
    Nothing      -> error "ContinuedFraction.find"
    Just (v, bf) -> (v, go [] bf bf)
  where
    go pat bf0 bf = case baseFormReduce bf of
        Nothing          -> reverse pat
        Just (v, bf')
            | bf' == bf0 -> reverse (v : pat)
            | otherwise  -> go (v : pat) bf0 bf'

converge :: Int -> ContinuedFraction -> Ratio Integer
converge n (c, cs) = go (take n (c : cycle cs))
  where
    go :: [Int] -> Ratio Integer
    go []       = 1
    go [x]      = fromIntegral x
    go (x : xs) = fromIntegral x + (1 / go xs)
