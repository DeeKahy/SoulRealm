---
tags:
  - resource
  - resource/haskell
  - resource/exercises
---
# Lecture 3 - Haskell Exercises

> Auto-generated from `haskell/lecture03/*.hs` by `sync-notes.sh` - edit the .hs files, not this note.

Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## preparation.hs

```haskell
-- Lecture 3 - Preparation
-- (placeholder: prep sheet tasks/notes before the lecture)

-- ===== Prep 1 =====


```

## exercises.hs

```haskell
-- ===== 1 =====
dingo (x,y) = [x,y]

-- is parametric polymorphism because it can take any tuple as input.
-- >>> dingo (1,2)
-- >>> :t dingo
-- [1,2]
-- dingo :: (a, a) -> [a]


-- ===== 2 =====
--h1 :: Eq a => (a, a) -> a -> [a]
h1 (x,y) z = if x == z then [x] else [y]
-- >>> :t h1
-- h1 :: Eq a => (a, a) -> a -> [a]
-- Ad-hoc Polymorohism


-- h2 :: (Ord a, Num a) => (a, a) -> (a, Bool)
h2 (x,y) = if x < 4 then (x, True) else (y, False)
 
-- >>> :t h2
-- h2 :: (Ord a, Num a) => (a, a) -> (a, Bool)
-- Ad-hoc Polymorphism


-- h3 :: a -> p -> a -> [a]
h3 x y z = [x,z]
-- >>> :t h3
-- h3 :: a -> p -> a -> [a]
-- Parametric Polymorohism


--h4 :: Bool -> (String, String)
h4 True = ("id", "k")
-- >>> :t h4
-- h4 :: Bool -> (String, String)
-- Monomorphism

--h5 :: (Ord a, Num a) => a -> a -> (Maybe [a], Bool)
h5 a b = if a+1 > b+1 then (Just [a], True) else (Just [b], False)
-- >>> :t h5
-- h5 :: (Ord a, Num a) => a -> a -> (Maybe [a], Bool)
-- Ad-hoc Polymorphism


-- ===== Task 3 =====
-- twice :: (a -> a) -> a -> a
twice f x = f (f (x))

-- >>> :t twice
-- twice :: (t -> t) -> t -> t
-- Parametric Polymorohism




twicetwo :: ((a -> a), a) -> a
twicetwo (f,x) = f (f ( x ))




-- ===== Task 4 =====

```
