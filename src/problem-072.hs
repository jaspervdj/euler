import           Totient (phi)

main :: IO ()
main = print $ sum [phi n | n <- [1 .. 1000000]] - 1
