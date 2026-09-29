
-- ===== 1 Opgaver vi skal snakke om =====

-- ===== 1.1 =====
allbutsecond :: [a] -> [a]
allbutsecond (x:_:xs) = x : xs
-- >>> allbutsecond [1,2,3,4,5]
-- >>> allbutsecond ["some", "thing", "hello"]
-- [1,3,4,5]
-- ["some","hello"]

-- ===== 1.2 ===== 


midtover :: [a] -> ([a],[a])
midtover as = (xs, zs) where
  half = div (length as) 2
  xs = take half as
  zs = drop half as 

-- >>> midtover [1,2,3,4,5]
-- ([1,2],[3,4,5])

-- ===== 1.3 =====

n = a `div` length xs where
  a = 10
  xs = [1,2,3,4,5]

-- >>> n
-- 2


-- ===== Bogstavopgaverne =====
-- ===== A =====

last' :: [a] -> a
last' xs = head sx where
  sx = reverse xs

-- >>> last' [1,2,3,4,5,6]
-- 6


-- ===== B =====

qsort :: (Ord a) => [a] -> [a]

qsort [] = []
qsort (x:xs) = big ++ [x] ++ small
                 where small = qsort [a | a <- xs, a <= x]
                       big   = qsort [a | a <- xs, a > x]

-- >>> qsort [6,2,2,3,1,5,6]
-- [6,5,4,3,2,2,1]


