---
tags:
  - resource
  - resource/haskell
  - resource/exercises
---
# Lecture 2 - Haskell Exercises

> Auto-generated from `haskell/lecture02/*.hs` by `sync-notes.sh` - edit the .hs files, not this note.

Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## preparation.hs

```haskell
-- Lecture 2 - Preparation (Kursusgang 2: Første skridt)
-- Brug kun funktionerne fra kapitel 2 i Programming in Haskell.
-- Se også slide-examples.hs (simple.hs fra Moodle).

-- ===== Prep 1 =====
-- Indlæs simple.hs (slide-examples.hs). Prøv at evaluere laengde myList.
-- Hvad tror du resultatet af sumtree myBigOak bliver? Forklar hvorfor. Tjek derefter svaret i Haskell.

-- Svar: sumtree summerer alle tal i træet: 14 + 13 + 17 = 44
-- >>> laengde myList   -- se slide-examples.hs
-- >>> sumtree myBigOak  -- se slide-examples.hs


-- ===== Prep 2 =====
-- Definér second, som returnerer det andet element i en liste, hvis det findes.
--   second [1,4,5,6]                   giver 4
--   second ["some","bizarre","mango"]  giver "bizarre"
-- Vis at det virker, find to flere eksempler. Er funktionen total?

second :: [a] -> a
second (_:x:_) = x

-- >>> second [1,4,5,6]
-- >>> second ["some","bizarre","mango"]
-- 4
-- "bizarre"
-- Ikke total: second [] og second [1] fejler (non-exhaustive patterns).

```

## exercises.hs

```haskell

-- ===== 1 Opgaver vi skal snakke om =====
-- Kursusgang 2: Første skridt i Haskell - Opgaver


-- ===== 1.1 =====
-- Opgave 1.1: Brug funktionerne i afsnit 2.4 til at definere allbutsecond, som returnerer listen uden det andet element.
--   allbutsecond [1,4,5,6]                   giver [1,5,6]
--   allbutsecond ["some","bizarre","mango"]  giver ["some","mango"]
-- Hvordan kan I blive mere sikre på, at jeres løsning er korrekt?


allbutsecond :: [a] -> [a]
allbutsecond (x:_:xs) = x : xs
-- >>> allbutsecond [1,2,3,4,5]
-- >>> allbutsecond ["some", "thing", "hello"]
-- [1,3,4,5]
-- ["some","hello"]

-- ===== 1.2 =====
-- Opgave 1.2 (parprogrammering): Brug funktionerne i afsnit 2.3 til at definere midtover, som ved en liste af længde n
-- returnerer (list1,list2), hvor list1 er de første ⌊n/2⌋ elementer og list2 resten. Brug `div`.
--   midtover [1,4,5,6]  giver ([1,4],[5,6])
--   midtover ["this","is","actually","a","fairly","long","list"]
--     giver (["this","is","actually"],["a","fairly","long","list"])
-- Hvordan kan I blive mere sikre på, at jeres løsning er korrekt?

 


midtover :: [a] -> ([a],[a])
midtover as = (xs, zs) where
  half = div (length as) 2
  xs = take half as
  zs = drop half as 

-- >>> midtover [1,2,3,4,5]
-- ([1,2],[3,4,5])

-- ===== 1.3 =====
-- Opgave 1.3: Der er noget galt i følgende kode. Hvad? Forklar, og ret koden.
--   N = a 'div' length xs
--     where
--       a = 10
--       xs = [1,2,3,4,5]
-- (Hint: variabelnavne skal starte med lille bogstav, og `div` skal bruge backticks.)



n = a `div` length xs where
  a = 10
  xs = [1,2,3,4,5]

-- >>> n
-- 2


-- ===== Bogstavopgaverne =====
-- ===== A =====
-- Opgave a: Brug reverse fra præludiet til at definere last, som returnerer sidste element i en liste.



last' :: [a] -> a
last' xs = head sx where
  sx = reverse xs

-- >>> last' [1,2,3,4,5,6]
-- 6


-- ===== B =====
-- Opgave b: Ændr qsort fra simple.hs, så den sorterer i aftagende rækkefølge: qsort [2,5,6,3,8] giver [8,6,5,3,2].
-- Vil qsort ["kpst","ding","bop","plip"] give mening? Hvorfor/hvorfor ikke?



qsort :: (Ord a) => [a] -> [a]

qsort [] = []
qsort (x:xs) = big ++ [x] ++ small
                 where small = qsort [a | a <- xs, a <= x]
                       big   = qsort [a | a <- xs, a > x]

-- >>> qsort [6,2,2,3,1,5,6]
-- [6,5,4,3,2,2,1]


-- ===== C =====
-- Opgave c: Forestil jer, at vi ændrede qsort fra simple.hs, så vi udskiftede <= med <. Hvad ville der så ske?

-- TODO: svar/test her

```

## scratch.hs

```haskell
double x = x * 2


-- >>> double 21
-- 42










```

## slide-examples.hs

```haskell
-- This is the simple program from the slides from the introduction

laengde :: (Num p) => [a] -> p

laengde [] = 0
laengde (x:l) = 1 + (laengde l)

myList = [2,3,17,9,69,484000]

-- >>> laengde myList
-- 6


data BTree = BLeaf Int | BBranch Int BTree BTree deriving Show

-- sumtree :: BTree -> Int

sumtree (BLeaf x) = x
sumtree (BBranch x t1 t2) = let v1 = sumtree t1
                                v2 = sumtree t2
                            in x + v1 + v2


myBigOak = BBranch 14 (BLeaf 13) (BLeaf 17)


-- >>> sumtree myBigOak
-- 44


-- Quicksort

qsort :: (Ord a) => [a] -> [a]

qsort [] = []
qsort (x:xs) = small ++ [x] ++ big
                 where small = qsort [a | a <- xs, a <= x]
                       big   = qsort [a | a <- xs, a > x]

second :: [a] -> a
second (_:x:_) = x
second' :: [a] -> [a]
second' xs = tail (take 2 xs)
second'' xs = head (drop 1 xs)
second''' (_:xs) = head xs
second'''' xs = head (tail xs)
second''''' xs = xs !! 1

-- >>> second myList
-- >>> second' myList
-- >>> second'' myList
-- >>> second''' myList
-- >>> second'''' myList
-- >>> second''''' myList
-- 3
-- [3]
-- 3
-- 3
-- 3
-- 3





-- quango :: a -> [a]
-- quango a = [a]


-- tango :: Num p1 => (a, b) -> p2 -> p1
-- tango (a, b) c = if a+1 == c+1 then c
-- >>> :t tango
-- Variable not in scope: tango

```
