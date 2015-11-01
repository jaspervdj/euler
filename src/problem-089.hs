data Atom
    = I
    | V
    | X
    | L
    | C
    | D
    | M
    deriving (Eq, Ord, Show)

parseAtom :: Char -> Atom
parseAtom 'I' = I
parseAtom 'V' = V
parseAtom 'X' = X
parseAtom 'L' = L
parseAtom 'C' = C
parseAtom 'D' = D
parseAtom 'M' = M
parseAtom c   = error $ "parseAtom: Unknown character: " ++ show c

atomValue :: Atom -> Int
atomValue I = 1
atomValue V = 5
atomValue X = 10
atomValue L = 50
atomValue C = 100
atomValue D = 500
atomValue M = 1000

type Numeral = [Atom]

parseNumeral :: String -> Numeral
parseNumeral = map parseAtom

numeralValue :: Numeral -> Int
numeralValue = go
  where
    go numeral0 = case takeAtom numeral0 of
        Nothing                     -> 0
        Just ((atom0, n), numeral1) -> case takeAtom numeral1 of
            Nothing             -> atomValue atom0 * n
            Just ((atom1, m), numeral2)
                -- Normal case
                | atom0 > atom1 -> atomValue atom0 * n + go numeral1
                -- Subtractive pair
                | otherwise     ->
                    atomValue atom1 * m - atomValue atom0 * n + go numeral2

    takeAtom :: Numeral -> Maybe ((Atom, Int), Numeral)
    takeAtom []       = Nothing
    takeAtom (x : xs) =
        let (nx, xs') = break (/= x) xs
        in Just ((x, length nx + 1), xs')

toNumeral :: Int -> Numeral
toNumeral = go100
  where
    go100 n =
        let (hundreds0, remainder) = n `divMod` 100
            (thousands, hundreds)  = hundreds0 `divMod` 10
        in replicate thousands M ++ toDigit hundreds C D M ++ go10 remainder

    go10 n =
        let (tens, remainder) = n `divMod` 10
        in toDigit tens X L C ++ go1 remainder

    go1 n = toDigit n I V X

    toDigit :: Int -> Atom -> Atom -> Atom -> Numeral
    toDigit value oner fiver tenner
        | value <= 3 = replicate value oner
        | value == 4 = [oner, fiver]
        | value <= 8 = [fiver] ++ replicate (value - 5) oner
        | otherwise  = replicate (10 - value) oner ++ [tenner]

main :: IO ()
main = do
    numerals <- map parseNumeral . lines <$> readFile "in/p089_roman.txt"
    let actualLength    = sum $ map length numerals
        optimized       = map (toNumeral . numeralValue) numerals
        optimizedLength = sum $ map length optimized

    print $ actualLength - optimizedLength
