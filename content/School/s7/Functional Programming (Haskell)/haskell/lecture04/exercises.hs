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



-- ===== Task 2 ===== (15 min)
-- En pythagoræisk trippel er en trippel (a, b, c) af naturlige tal a, b og c,
-- således at a <= b < c og a^2 + b^2 = c^2. Med andre ord betegner en trippel på
-- denne form længderne af de tre sider i en retvinklet trekant, hvor alle sider har
-- heltallig længde. Den mindste pythagoræiske trippel er (3, 4, 5).
-- Brug listeabstraktion til at definere en funktion pyt, der, når den får et heltal
-- k, giver os en liste af alle pythagoræiske tripler, hvis største element er højst k.
-- Før du skriver definitionen af pyt, skal du finde ud af, hvad dens type bør være.
--
-- pyt :: a -> (a)
pyt k = [ (a,b,c) | a <- [3..k], b <- [4..k], c <- [5..k], a <= b, b < c, a^2 + b^2 == c^2]

-- >>> :t pyt
-- >>> pyt 30
-- pyt :: (Num c, Ord c, Enum c) => c -> [(c, c, c)]
-- [(3,4,5),(5,12,13),(6,8,10),(7,24,25),(8,15,17),(9,12,15),(10,24,26),(12,16,20),(15,20,25),(18,24,30),(20,21,29)]


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


-- >>> sums 4 9
-- >>> sums' 4 9
-- [2,3,4,5,6,7,8,9,10,3,4,5,6,7,8,9,10,11,4,5,6,7,8,9,10,11,12,5,6,7,8,9,10,11,12,13]
-- [2,3,4,5,6,7,8,9,10,3,4,5,6,7,8,9,10,11,4,5,6,7,8,9,10,11,12,5,6,7,8,9,10,11,12,13]

