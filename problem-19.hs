--------------------------------------------------------------------------------
type Year = Int


--------------------------------------------------------------------------------
isLeapYear :: Year -> Bool
isLeapYear year
    | not (year `isDivBy` 4) = False
    | year `isDivBy` 400     = True
    | year `isDivBy` 100     = False
    | otherwise              = True
  where
    isDivBy x y = x `mod` y == 0


--------------------------------------------------------------------------------
data DayOfTheWeek
    = Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday
    | Saturday
    | Sunday
    deriving (Bounded, Enum, Eq, Show)


----------------------------------------------------------------------
type DayOfTheMonth = Int


--------------------------------------------------------------------------------
data Month
    = January
    | February
    | March
    | April
    | May
    | June
    | July
    | August
    | September
    | October
    | November
    | December
    deriving (Bounded, Enum, Eq, Show)


--------------------------------------------------------------------------------
numDaysInMonth :: Bool -> Month -> Int
numDaysInMonth leapYear month = case month of
    January   -> 31
    February  -> if leapYear then 29 else 28
    March     -> 31
    April     -> 30
    May       -> 31
    June      -> 30
    July      -> 31
    August    -> 31
    September -> 30
    October   -> 31
    November  -> 30
    December  -> 31


--------------------------------------------------------------------------------
next :: (Bounded a, Enum a, Eq a) => a -> a
next x = if x == maxBound then minBound else succ x


--------------------------------------------------------------------------------
nextDay
    :: (DayOfTheWeek, DayOfTheMonth, Month, Year)
    -> (DayOfTheWeek, DayOfTheMonth, Month, Year)
nextDay (dotw, dotm, month, year) =
    (dotw', dotm', month', year')
  where
    leapYear  = isLeapYear year
    monthEnds = dotm >= numDaysInMonth leapYear month
    yearEnds  = month == December && monthEnds

    dotw'  = next dotw
    dotm'  = if monthEnds then 1          else dotm + 1
    month' = if monthEnds then next month else month
    year'  = if yearEnds  then year + 1   else year


--------------------------------------------------------------------------------
main :: IO ()
main = print $ length $
    filter (\(dotw, dotm, _, _) -> dotw == Sunday && dotm == 1) $
    takeWhile (\(_, _, _, year) -> year < 2001)                 $
    dropWhile (\(_, _, _, year) -> year < 1901)                 $
    iterate nextDay (Monday, 1, January, 1900)
