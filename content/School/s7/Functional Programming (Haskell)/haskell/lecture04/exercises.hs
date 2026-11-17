-- Lecture 4 - Exercises
-- Funktioner og lister

-- ===== Task 1 ===== (10 min)
-- Definer en funktion idhead, der fortæller os, om en liste af par starter med et
-- par, hvor første og andet element er identiske.
-- Vi vil have, at
--   idhead [(42,42),(3,4),(484000,5)]          giver True, men at
--   idhead [("plip","mango"),("dingo","kpst")]  giver False.
-- I din definition må du ikke bruge head eller if-then-else-udtryk!
-- Er funktionen polymorf? Hvis ja, på hvilken måde?


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

-- Forklaring:
--   Yes, polymorphic: idhead :: Eq a => [(a, a)] -> Bool. It works for any a that
--   supports ==, so it is AD HOC polymorphism (overloading via the Eq class).
--   Both components must be the same type a, because we compare them with x == y.
--   idhead' is the nicer version: x == y already IS a Bool, so the guards
--   "| x == y = True | otherwise = False" just repeat it.
--   Note: neither handles the empty list. idhead [] crashes with "Non-exhaustive
--   patterns". Add  idhead [] = False  to make it total.



-- ===== Task 2 ===== (15 min)
-- En pythagoræisk trippel er en trippel (a, b, c) af naturlige tal a, b og c,
-- således at a <= b < c og a^2 + b^2 = c^2. Med andre ord betegner en trippel på
-- denne form længderne af de tre sider i en retvinklet trekant, hvor alle sider har
-- heltallig længde. Den mindste pythagoræiske trippel er (3, 4, 5).
-- Brug listeabstraktion til at definere en funktion pyt, der, når den får et heltal
-- k, giver os en liste af alle pythagoræiske tripler, hvis største element er højst k.
-- Før du skriver definitionen af pyt, skal du finde ud af, hvad dens type bør være.
--
-- pyt :: (Num c, Ord c, Enum c) => c -> [(c, c, c)]
--   (written by hand you would usually just say  pyt :: Int -> [(Int, Int, Int)])
pyt k = [ (a,b,c) | a <- [3..k], b <- [4..k], c <- [5..k], a <= b, b < c, a^2 + b^2 == c^2]

-- >>> :t pyt
-- >>> pyt 30
-- pyt :: (Num c, Ord c, Enum c) => c -> [(c, c, c)]
-- [(3,4,5),(5,12,13),(6,8,10),(7,24,25),(8,15,17),(9,12,15),(10,24,26),(12,16,20),(15,20,25),(18,24,30),(20,21,29)]

-- Forklaring (type):
--   Input: a number k. Output: a LIST of TRIPLES of the same kind of number.
--   Constraints come from what we do with the numbers: [3..k] needs Enum, <= and <
--   need Ord, ^ and + need Num.
--
-- Faster version: let the generators do the work of a <= b < c instead of
-- filtering afterwards (b starts at a, c starts at b+1). Same result, far fewer
-- candidates.
pyt' :: Int -> [(Int, Int, Int)]
pyt' k = [ (a,b,c) | c <- [1..k], b <- [1..c-1], a <- [1..b], a^2 + b^2 == c^2 ]

-- >>> pyt' 20
-- [(3,4,5),(6,8,10),(5,12,13),(9,12,15),(8,15,17),(12,16,20)]


-- ===== Task 3 ===== (10 min)
-- I sidste uge så vi, at en berømt influencer på Instagram har defineret en
-- Haskell-funktion bighead, der kan fortælle os, hvor mange elementer i en liste xs
-- er større end (>) det første element i xs. Et eksempel på hvad funktionen gør,
-- er at resultatet af bighead [7,4,5,8,9] bliver 2.
-- Nu er det din tur til at være en berømt influencer. Hvordan ville du definere
-- bighead-funktionen? Hvad skal funktionens type være?

bighead (x:xs) = length [ a | a <- xs, a > x ]

-- >>> bighead [7,1,2,3,8,9]
-- 2

-- >>> :t bighead
-- >>> bighead [7,4,5,8,9]
-- bighead :: Ord a => [a] -> Int
-- 2

-- Forklaring:
--   We compare elements with > so we need Ord a. length always returns Int.
--   The pattern (x:xs) gives us the first element x directly, without head.

-- ===== Task 4 ===== (10 min)
-- Vis, hvordan følgende funktionsdefinition kan udtrykkes ved hjælp af
-- lambda-udtryk i Haskell (der er mere end ét korrekt svar!).
--   plonk x y z = x+y+z
-- Find ud af typen af plonk uden at spørge Haskell-fortolkeren.
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

-- Other correct lambda versions (they all mean the same thing):
plonk2 = \x -> \y -> \z -> x + y + z       -- one argument at a time (true currying)
plonk3 x = \y z -> x + y + z               -- mix: some args left, some in a lambda

-- Forklaring:
--   Type by hand: + :: Num a => a -> a -> a, so x, y, z and the result share one
--   Num type: plonk :: Num a => a -> a -> a -> a.
--
--   Why is plonk' :: Integer -> ... and not Num a => ...? That is the
--   MONOMORPHISM RESTRICTION: a definition with NO arguments on the left of =
--   (plonk' = \x y z -> ...) and NO type signature is not allowed to be overloaded.
--   GHC has to pick one concrete type and "defaults" Num to Integer. Fix: give it a
--   signature  plonk' :: Num a => a -> a -> a -> a  (or put the args on the left).
--   plonk itself has its arguments on the left, so it stays polymorphic.



-- ===== Task 5 ===== (20 min)
-- Et perfekt tal n er et naturligt tal, der er summen af sine egne divisorer, når
-- n selv er medregnet. 28 er et perfekt tal, da 1 + 2 + 4 + 7 + 14 = 28.
-- (sic - arket skriver "er medregnet", men eksemplet viser, at n IKKE tælles med)
-- Brug listeabstraktion til at definere en funktion isperfect, der fortæller os, om
-- et givet naturligt tal er et perfekt tal.
-- Tip: Lav en hjælpefunktion, der finder listen af divisorer for et naturligt tal.
-- Den slags kræver et vist mod.

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
-- Brug listeabstraktion til at definere en funktion sevens, der, når den får et
-- heltal k, giver os en liste af alle naturlige tal, der er delelige med 7 og
-- mindre end k. Find først ud af, hvad dens type bør være.
sevens :: Integral a => a -> [a]
sevens k = [x | x <- [7..k], (mod x 7) == 0]

-- >>> sevens 77
-- [7,14,21,28,35,42,49,56,63,70,77]

-- === B) ===
-- Brug listeabstraktion til at definere en funktion flop, der, når den får en
-- liste af par, returnerer en liste af par, hvis komponenter er ombyttet. Listen
-- kan være tom. For eksempel skal
--   flop [(1,'a'),(3,'r'),(9,'e')]  returnere  [('a',1),('r',3),('e',9)]
-- Hvad er typen af flop?
flop :: [(a, b)] -> [(b, a)]
flop xs = [(a, b) | (b, a) <- xs]

-- >>> flop [('a',1),('b',2),('c',3),('d',4)]
-- [(1,'a'),(2,'b'),(3,'c'),(4,'d')]

-- >>> flop [(1,'a'),(3,'r'),(9,'e')]


-- === C) ===
-- Skriv en funktion dupli, der gentager hvert element i en given liste. Som
-- eksempel skal dupli [1,2,3] give os [1,1,2,2,3,3]. Hvad bør typen af dupli være?
-- Tip: Funktionen concat fra Kapitel 5 er nyttig til at sætte det hele sammen med.

dupli :: [a] -> [a]
dupli [] = []
dupli (x:xs) = x : x : dupli xs

-- >>> dupli [1,2,3]
-- [1,1,2,2,3,3]

-- Version with concat (as the hint suggests): make a small list [x,x] for each
-- element, which gives a list of lists, then glue them together.
dupli' :: [a] -> [a]
dupli' xs = concat [ [x,x] | x <- xs ]

-- >>> [ [x,x] | x <- [1,2,3] ]
-- >>> dupli' [1,2,3]
-- [[1,1],[2,2],[3,3]]
-- [1,1,2,2,3,3]

-- Forklaring (type): we never look inside the elements, so no constraint is needed:
--   dupli :: [a] -> [a]   (parametric polymorphism)


-- === D) ===
-- Her er en funktion sums, hvis definition har én enkelt anvendelse af
-- listeabstraktion.
--   sums m n = [ x+y | x <- [1..m], y <- [1..n] ]
-- Listeabstraktionen i denne definition bruger to generatorer. Skriv en alternativ
-- definition af sums, der kun bruger listeabstraktioner (du kan have brug for mere
-- end én listeabstraktion) med én generator hver.
-- Tip: Funktionen concat fra Kapitel 5 vil også være nyttig her.


sums m n = [ x+y | x <- [1..m], y <- [1..n] ]

sums' m n = concat [ [y+1 | y <- [x..x+n-1]] | x <- [1..m]]

-- A more direct version: the inner comprehension uses the outer x directly.
-- (The inner list is one comprehension with one generator, and x is just a variable.)
sums'' m n = concat [ [ x+y | y <- [1..n] ] | x <- [1..m] ]

-- >>> sums'' 4 9 == sums 4 9
-- True

-- Forklaring:
--   With two generators, the LAST generator (y) runs fastest. For each x, y runs
--   through all of [1..n]. That is exactly "for each x, make the list [x+1..x+n],
--   then concat them", which is what sums' and sums'' do.


-- >>> sums 4 9
-- >>> sums' 4 9
-- [2,3,4,5,6,7,8,9,10,3,4,5,6,7,8,9,10,11,4,5,6,7,8,9,10,11,12,5,6,7,8,9,10,11,12,13]
-- [2,3,4,5,6,7,8,9,10,3,4,5,6,7,8,9,10,11,4,5,6,7,8,9,10,11,12,5,6,7,8,9,10,11,12,13]

