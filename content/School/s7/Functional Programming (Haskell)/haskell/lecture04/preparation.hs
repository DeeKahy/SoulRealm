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
