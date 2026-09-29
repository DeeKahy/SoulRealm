-- This is the simple program from the slides from the introduction

laengde :: (Num p) => [a] -> p

laengde [] = 0
laengde (x:l) = 1 + (laengde l)

myList = [2,3,17,9,69,484000]

-- >>> laengde myList
-- 6


data BTree = BLeaf Int | BBranch Int BTree BTree deriving Show

-- sumtree :: BTree -> Int

sumtree (BLeaf x) = x
sumtree (BBranch x t1 t2) = let v1 = sumtree t1
                                v2 = sumtree t2
                            in x + v1 + v2


myBigOak = BBranch 14 (BLeaf 13) (BLeaf 17)


-- >>> sumtree myBigOak
-- 44


-- Quicksort

qsort :: (Ord a) => [a] -> [a]

qsort [] = []
qsort (x:xs) = small ++ [x] ++ big
                 where small = qsort [a | a <- xs, a <= x]
                       big   = qsort [a | a <- xs, a > x]

second :: [a] -> a
second (_:x:_) = x
second' :: [a] -> [a]
second' xs = tail (take 2 xs)
second'' xs = head (drop 1 xs)
second''' (_:xs) = head xs
second'''' xs = head (tail xs)
second''''' xs = xs !! 1

-- >>> second myList
-- >>> second' myList
-- >>> second'' myList
-- >>> second''' myList
-- >>> second'''' myList
-- >>> second''''' myList
-- 3
-- [3]
-- 3
-- 3
-- 3
-- 3





-- quango :: a -> [a]
-- quango a = [a]


-- tango :: Num p1 => (a, b) -> p2 -> p1
-- tango (a, b) c = if a+1 == c+1 then c
-- >>> :t tango
-- Variable not in scope: tango
