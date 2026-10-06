-- Lecture 5 - Preparation
-- Rekursion
-- Læsning: Kapitel 6 i Programming in Haskell + podcast.
--
-- Læringsmål:
--   * Forstå strukturen af en rekursiv funktionsdefinition
--   * Læse og skrive rekursive funktionsdefinitioner på lister
--   * Læse og skrive rekursive definitioner med flere rekursive kald eller
--     gensidig rekursion
--   * Skrive rekursive funktionsdefinitioner på en struktureret måde (Afsnit 6.6)

-- ===== Prep 1 =====
-- Definér funktionen replicate ved hjælp af rekursion - og brug mønstre i din
-- løsning. Denne funktion tager et heltal n og et element x og returnerer en liste
-- med n elementer, hvor x er gentaget præcis n gange. Som eksempel skal
--   replicate 3 5  give  [5,5,5]
-- Hvilken type skal replicate have?

--replicatee :: (Eq n, Num n) => n -> [e] -> [e]

replicatee 0 [e] = []
replicatee n [e] = replicatee (n-1) [e] ++ [e]


replicateee n e = take n (repeat e)

-- >>> replicateee 4 1
-- >>> replicatee 4 1
-- No instance for `Num [()]' arising from a use of `it_aHYh'
-- In the first argument of `evalPrint', namely `it_aHYh'
-- In a stmt of an interactive GHCi command: evalPrint it_aHYh

-- >>> replicatee 3 5
-- [5,5,5]



-- ===== Prep 2 =====
-- Definér funktionen improve ved hjælp af rekursion - og brug mønstre i din
-- løsning. Den tager en liste xs og, hvis xs indeholder mindst to elementer,
-- returnerer den en liste, hvor hvert andet element er fjernet. Som eksempel skal
--   improve [1,2,3,4,5,6,7]  give  [1,3,5,7]
-- Hvilken type skal improve have?

--improve :: [a] -> [a]
improve ([]) = []
improve (x:[]) = [x]
improve (x:xs) = [x] ++ improve (drop 1 xs)

-- >>> improve [1,1,2,2,3,3,4,4]
-- [1,2,3,4]

-- >>> improve [1,2,3,4,5,6,7]
-- [1,3,5,7]

