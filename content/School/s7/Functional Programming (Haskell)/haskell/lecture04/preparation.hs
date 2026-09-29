-- Lecture 4 - Preparation
-- Definition af funktioner; Listeabstraktion


-- ===== Prep 1 =====
onlytwo (x:y:[]) = True
onlytwo (_) = False

-- >>> onlytwo [1,2,3]
-- >>> onlytwo [1,2]
-- >>> onlytwo [1]
-- False
-- True
-- False

-- ===== Prep 2 =====
alldots xs ys = [a*c + b*d | (a, b) <- xs, (c, d) <- ys]


-- >>> alldots [(1,2),(3,4)] [(5,6),(7,8)]
-- >>> alldots [(1,2)] []
-- [17,23,39,53]
-- []
