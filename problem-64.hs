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

findContinuedFraction :: Int -> (Int, [Int])
findContinuedFraction r = case baseFormReduce (mkBaseForm r) of
    Nothing      -> error "findContinuedFraction"
    Just (v, bf) -> (v, go [] bf bf)
  where
    go pat bf0 bf = case baseFormReduce bf of
        Nothing          -> reverse pat
        Just (v, bf')
            | bf' == bf0 -> reverse (v : pat)
            | otherwise  -> go (v : pat) bf0 bf'

hasOddPeriod :: (a, [a]) -> Bool
hasOddPeriod (_, xs) = odd (length xs)

main :: IO ()
main = print $ length
    [ n
    | n <- [1 .. 10000]
    , hasOddPeriod (findContinuedFraction n)
    ]
