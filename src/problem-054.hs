import           Control.Monad (forM_, guard, mplus, msum)
import           Data.List     (sort)

selectMax :: Ord a => [a] -> (a, [a])
selectMax []       = error "selectMax: empty list"
selectMax (x : xs) = go x [] xs
  where
    go m acc []     = (m, acc)
    go m acc (y : ys)
        | m >= y    = go m (y : acc) ys
        | otherwise = go y (m : acc) ys

selectRepeated :: Ord a => Int -> [a] -> Maybe (a, [a])
selectRepeated _ []       = Nothing
selectRepeated n (z : zs) = go z 1 [] zs `mplus`
    case selectRepeated n zs of
        Nothing      -> Nothing
        Just (x, xs) -> Just (x, z : xs)
  where
    go x count acc []
        | count >= n = Just (x, acc)
        | otherwise  = Nothing
    go x count acc (y : ys)
        | count >= n = go x count (y : acc) ys
        | y == x     = go x (count + 1) acc ys
        | otherwise  = go x count (y : acc) ys

consecutive :: (Enum a, Eq a) => [a] -> Bool
consecutive []           = True
consecutive [_]          = True
consecutive (x : y : zs) = succ x == y && consecutive (y : zs)

equal :: Eq a => [a] -> Bool
equal []           = True
equal [_]          = True
equal (x : y : zs) = x == y && equal (y : zs)

data Rank
    = Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | Ten
    | Jack
    | Queen
    | King
    | Ace
    deriving (Bounded, Enum, Eq, Ord, Show)

parseRank :: Char -> Rank
parseRank c = case c of
    '2' -> Two
    '3' -> Three
    '4' -> Four
    '5' -> Five
    '6' -> Six
    '7' -> Seven
    '8' -> Eight
    '9' -> Nine
    'T' -> Ten
    'J' -> Jack
    'Q' -> Queen
    'K' -> King
    'A' -> Ace
    _   -> error $ "parseRank: unknown rank: " ++ show c

data Suit
    = Hearts
    | Spades
    | Clubs
    | Diamonds
    deriving (Bounded, Enum, Eq, Ord, Show)

parseSuit :: Char -> Suit
parseSuit c = case c of
    'H' -> Hearts
    'S' -> Spades
    'C' -> Clubs
    'D' -> Diamonds
    _   -> error $ "parseSuit: unknown suit: " ++ show c

type Card = (Rank, Suit)

parseCard :: String -> Card
parseCard [r, s] = (parseRank r, parseSuit s)
parseCard str    = error $ "parseCard: unknown card: " ++ show str

rank :: Card -> Rank
rank = fst

suit :: Card -> Suit
suit = snd

data Score
    = HighCard Rank
    | OnePair Rank
    | TwoPair Rank Rank
    | ThreeOfAKind Rank
    | Straight Rank
    | Flush
    | FullHouse Rank Rank
    | FourOfAKind Rank
    | StraightFlush Rank
    | RoyalFlush
    deriving (Eq, Ord, Show)

type Hand = (Score, [Rank])

mkHand :: [Card] -> Hand
mkHand cards = orderRemainder $ case msum recognizers of
    Nothing -> let (m, r) = selectMax $ map rank cards in (HighCard m, r)
    Just h  -> h
  where
    orderRemainder (h, r) = (h, reverse (sort r))
    recognizers           =
        [ do
            let sorted = sort (map rank cards)
            guard (consecutive sorted)
            guard (equal $ map suit cards)
            return (StraightFlush (last sorted), [])
        , do
            (p, r) <- selectRepeated 4 (map rank cards)
            return (FourOfAKind p, r)
        , do
            (p1, r1) <- selectRepeated 3 (map rank cards)
            (p2, r2) <- selectRepeated 2 r1
            return (FullHouse p1 p2, r2)
        , do
            guard (equal $ map suit cards)
            return (Flush, map rank cards)
        , do
            let sorted = sort (map rank cards)
            guard (consecutive sorted)
            return (Straight (last sorted), [])
        , do
            (p, r) <- selectRepeated 3 (map rank cards)
            return (ThreeOfAKind p, r)
        , do
            (p1, r1) <- selectRepeated 2 (map rank cards)
            (p2, r2) <- selectRepeated 2 r1
            return (TwoPair (max p1 p2) (min p1 p2), r2)
        , do
            (p, r) <- selectRepeated 2 (map rank cards)
            return (OnePair p, r)
        ]

parseGame :: String -> (Hand, Hand)
parseGame str =
    let (c1, c2) = splitAt 5 $ map parseCard $ words str
    in (mkHand c1, mkHand c2)

main :: IO ()
main = do
    games <- map (\str -> (str, parseGame str)) . lines <$> getContents
    forM_ games $ \(str, (hand1@(score1, _), hand2@(score2, _))) -> do
        putStrLn str
        putStrLn $ "Player 1: " ++ show score1
        putStrLn $ "Player 2: " ++ show score2
        putStrLn $ if hand1 > hand2 then "Player 1 wins!" else "Player 2 wins!"
        putStrLn ""
    print $ length $ [h1 | (_, (h1, h2)) <- games, h1 > h2]
