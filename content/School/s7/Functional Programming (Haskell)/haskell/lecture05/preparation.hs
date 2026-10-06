-- Lecture 5 - Preparation
-- (placeholder: prep sheet tasks/notes before the lecture)

-- ===== Prep 1 =====
--replicatee :: (Eq n, Num n) => n -> [e] -> [e]

replicatee 0 [e] = []
replicatee n [e] = replicatee (n-1) [e] ++ [e]


replicateee n e = take n (repeat e)

-- >>> replicateee 4 1
-- >>> replicatee 4 1
-- No instance for `Num [()]' arising from a use of `it_aHYh'
-- In the first argument of `evalPrint', namely `it_aHYh'
-- In a stmt of an interactive GHCi command: evalPrint it_aHYh



-- ===== Prep 2 =====
--improve :: [a] -> [a]
improve ([]) = []
improve (x:[]) = [x]
improve (x:xs) = [x] ++ improve (drop 1 xs)

-- >>> improve [1,1,2,2,3,3,4,4]
-- [1,2,3,4]


