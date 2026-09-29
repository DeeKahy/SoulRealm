---
tags:
  - resource
  - resource/haskell
  - resource/exercises
---
# Lecture 2 - Haskell Exercises

> Auto-generated from `haskell/lecture2/*.hs` by `sync-notes.sh` - edit the .hs files, not this note.

Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## a.hs

```haskell
double x = x * 2


-- >>> double 21
-- 42










```

## l2.hs

```haskell

-- ===== 1 Opgaver vi skal snakke om =====

-- ===== 1.1 =====
allbutsecond :: [a] -> [a]
allbutsecond (x:_:xs) = x : xs
-- >>> allbutsecond [1,2,3,4,5]
-- >>> allbutsecond ["some", "thing", "hello"]
-- [1,3,4,5]
-- ["some","hello"]

-- ===== 1.2 ===== 


midtover :: [a] -> ([a],[a])
midtover as = (xs, zs) where
  half = div (length as) 2
  xs = take half as
  zs = drop half as 

-- >>> midtover [1,2,3,4,5]
-- ([1,2],[3,4,5])

-- ===== 1.3 =====

n = a `div` length xs where
  a = 10
  xs = [1,2,3,4,5]

-- >>> n
-- 2


-- ===== Bogstavopgaverne =====
-- ===== A =====

last' :: [a] -> a
last' xs = head sx where
  sx = reverse xs

-- >>> last' [1,2,3,4,5,6]
-- 6


-- ===== B =====

qsort :: (Ord a) => [a] -> [a]

qsort [] = []
qsort (x:xs) = big ++ [x] ++ small
                 where small = qsort [a | a <- xs, a <= x]
                       big   = qsort [a | a <- xs, a > x]

-- >>> qsort [6,2,2,3,1,5,6]
-- [6,5,4,3,2,2,1]



```

## simple.hs

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
