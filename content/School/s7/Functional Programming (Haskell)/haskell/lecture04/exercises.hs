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
-- >>> pyt 50
-- pyt :: (Num c, Ord c, Enum c) => c -> [(c, c, c)]
-- [(3,4,5),(5,12,13),(6,8,10),(7,24,25),(8,15,17),(9,12,15),(9,40,41),(10,24,26),(12,16,20),(12,35,37),(14,48,50),(15,20,25),(15,36,39),(16,30,34),(18,24,30),(20,21,29),(21,28,35),(24,32,40),(27,36,45),(30,40,50)]
