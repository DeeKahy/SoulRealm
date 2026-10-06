-- Lecture 4 - Exercises
-- Funktioner og lister

-- ===== Task 1 =====


idhead ((x,y):_)
  | x == y = True
  | otherwise = False

idhead' ((x,y):_) = x == y

-- >>> :t idhead
-- >>> idhead [(42,42),(3,4),(484000,5)]
-- >>> idhead [(42,43),(3,4),(484000,5)]
-- >>> idhead [("plip","mango"),("dingo","kpst")]
-- >>> idhead [("plip","plip"),("dingo","kpst")]
-- idhead :: Eq a => [(a, a)] -> Bool
-- True
-- False
-- False
-- True

-- >>> :t idhead'
-- >>> idhead' [(42,42),(3,4),(484000,5)]
-- >>> idhead' [(42,43),(3,4),(484000,5)]
-- >>> idhead' [("plip","mango"),("dingo","kpst")]
-- >>> idhead' [("plip","plip"),("dingo","kpst")]
-- idhead' :: Eq a => [(a, a)] -> Bool
-- True
-- False
-- False
-- True



-- ===== Task 2 =====
-- 
-- pyt :: a -> (a)
pyt k = [ (a,b,c) | a <- [3..k], b <- [4..k], c <- [5..k], a <= b, b < c, a^2 + b^2 == c^2]

-- >>> :t pyt
-- >>> pyt 30
-- pyt :: (Num c, Ord c, Enum c) => c -> [(c, c, c)]
-- [(3,4,5),(5,12,13),(6,8,10),(7,24,25),(8,15,17),(9,12,15),(10,24,26),(12,16,20),(15,20,25),(18,24,30),(20,21,29)]


-- ===== Task 3 =====

bighead (x:xs) = length [ a | a <- xs, a > x ]

-- >>> bighead [7,1,2,3,8,9]
-- 2

-- ===== Task 4 =====
plonk x y z = x+y+z
plonk' = \x y z -> x + y + z

-- >>> :t plonk
-- >>> :t plonk'
-- >>> plonk 1 2 3
-- >>> plonk' 1 2 3
-- plonk :: Num a => a -> a -> a -> a
-- plonk' :: Integer -> Integer -> Integer -> Integer
-- 6
-- 6



-- ===== Task 5 =====

divisors x = [a | a <- [1..(div x 2)], mod x a == 0]

-- >>> divisors 28
-- [1,2,4,7,14]

-- isperfect :: Integral a => a -> Bool
isperfect x = sum (divisors x) == x

-- >>> isperfect 28
-- >>> isperfect 23
-- >>> [x | x <- [2,4..500], isperfect x == True]
-- True
-- False
-- [6,28,496]



-- ===== Alphabet Worksheet =====

-- === A) ===
sevens :: Integral a => a -> [a]
sevens k = [x | x <- [7..k], (mod x 7) == 0]

-- >>> sevens 77
-- [7,14,21,28,35,42,49,56,63,70,77]

-- === B) ===
flop :: [(a, b)] -> [(b, a)]
flop xs = [(a, b) | (b, a) <- xs]

-- >>> flop [('a',1),('b',2),('c',3),('d',4)]
-- [(1,'a'),(2,'b'),(3,'c'),(4,'d')]


-- === C) ===

dupli :: [a] -> [a]
dupli [] = []
dupli (x:xs) = x : x : dupli xs

-- >>> dupli [1,2,3]
-- [1,1,2,2,3,3]


-- === D) ===


sums m n = [ x+y | x <- [1..m], y <- [1..n] ]

sums' m n = concat [ [y+1 | y <- [x..x+n-1]] | x <- [1..m]]


-- >>> sums 4 9
-- >>> sums' 4 9
-- [2,3,4,5,6,7,8,9,10,3,4,5,6,7,8,9,10,11,4,5,6,7,8,9,10,11,12,5,6,7,8,9,10,11,12,13]
-- [2,3,4,5,6,7,8,9,10,3,4,5,6,7,8,9,10,11,4,5,6,7,8,9,10,11,12,5,6,7,8,9,10,11,12,13]

