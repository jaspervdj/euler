import           Select

main :: IO ()
main = putStrLn $ maximum $ filter ((== 16) . length) $
    map showSolution solutions

showSolution :: [(Int, Int, Int)] -> String
showSolution = concatMap (\(x, y, z) -> show x ++ show y ++ show z)

-- | Let's use the following names for our 5-gon:
--
-- >       a
-- >        \
-- >         b    d
-- >       /   \ /
-- >      i     c
-- >     / \   /
-- >    j  g - e - f
-- >        \
-- >         h
--
solutions :: [[(Int, Int, Int)]]
solutions =
    [ orderSolution
        [ (a, b, c)
        , (d, c, e)
        , (f, e, g)
        , (h, g, i)
        , (j, i, b)
        ]

    | (a, l9) <- select l10
    , (b, l8) <- select l9
    , (c, l7) <- select l8

    , (d, l6) <- select l7
    , (e, l5) <- select l6

    , a + b + c == d + c + e

    , (f, l4) <- select l5
    , (g, l3) <- select l4

    , a + b + c == f + e + g

    , (h, l2) <- select l3
    , (i, l1) <- select l2

    , a + b + c == h + g + i

    , (j, _) <- select l1

    , a + b + c == j + i + b
    ]
 where
    l10 = [1 .. 10] :: [Int]

orderSolution :: [(Int, Int, Int)] -> [(Int, Int, Int)]
orderSolution solution =
    take numGroups $
    dropWhile (\g -> externalNode g /= startingNode) $
    solution ++ solution
  where
    externalNode (x, _, _) = x
    numGroups              = length solution
    startingNode           = minimum $ map externalNode solution
