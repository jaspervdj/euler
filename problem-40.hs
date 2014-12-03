import           Data.Char (digitToInt)

firstNumberWithNDigits :: Int -> Integer
firstNumberWithNDigits n = 10 ^ (n - 1)

lastNumberWithNDigits :: Int -> Integer
lastNumberWithNDigits n = firstNumberWithNDigits (n + 1) - 1

numNumbersWithNDigits :: Int -> Integer
numNumbersWithNDigits n =
    lastNumberWithNDigits n - firstNumberWithNDigits n + 1

findDigit :: Integer -> Int
findDigit nth = digitToInt $ go 1 $ nth - 1
  where
    go :: Int -> Integer -> Char
    go digits n
        | n > totalDigits = go (digits + 1) (n - totalDigits)
        | otherwise       =
            let (numberIdx, digitIdx) = n `divMod` fromIntegral digits
                number                =
                    firstNumberWithNDigits digits + numberIdx
                digit                 = show number !! fromIntegral digitIdx
            in digit
      where
        totalDigits =
            fromIntegral digits * numNumbersWithNDigits digits

main :: IO ()
main = print $
    findDigit 1 *
    findDigit 10 *
    findDigit 100 *
    findDigit 1000 *
    findDigit 10000 *
    findDigit 100000 *
    findDigit 1000000
