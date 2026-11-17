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
-- [1,1,1,1]

-- OBS - why replicatee breaks:
--   The pattern [e] means "a list with exactly ONE element, call it e". So the second
--   argument must be a list, and replicatee 3 5 asks GHC to treat 5 as a list
--   (Num [a]), which is the 'No instance for Num [()]' error. Also the result is
--   built from [e] ++ [e] ++ ..., so you would get [[e],[e]]-ish nonsense if it
--   typechecked.
--   Fix: take the element x directly, no brackets.

replicate' :: Int -> a -> [a]
replicate' 0 _ = []
replicate' n x = x : replicate' (n - 1) x

-- >>> replicate' 3 5
-- >>> replicate' 2 "hej"
-- >>> replicate' 0 'x'
-- [5,5,5]
-- ["hej","hej"]
-- ""

-- Forklaring:
--   Type: a count (Int) and ONE element of any type a, giving a list of a's.
--   Parametric in a.
--   Base: 0 copies is []. Recursive: one x in front of n-1 copies.
--   x : ... (cons) is better than ... ++ [x]: it is O(1) instead of walking the list.
--   Note: replicate' (-1) 'x' never hits 0 and loops forever. Using  n <= 0  as the
--   base case (with a guard) makes it total.



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

-- Cleaner with patterns only (no drop): match the first TWO elements and skip
-- the second one.
improve' :: [a] -> [a]
improve' (x:_:xs) = x : improve' xs
improve' xs       = xs              -- [] or [x]: nothing to remove

-- >>> improve' [1,2,3,4,5,6,7]
-- [1,3,5,7]

-- Forklaring: type improve :: [a] -> [a] (parametric). The pattern (x:_:xs) only
-- matches lists with at least two elements, so the last line catches [] and [x].

