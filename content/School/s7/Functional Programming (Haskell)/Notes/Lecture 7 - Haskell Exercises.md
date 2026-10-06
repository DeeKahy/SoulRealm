---
tags:
  - resource
  - resource/haskell
  - resource/exercises
---
# Lecture 7 - Haskell Exercises

> Auto-generated from `haskell/lecture07/*.hs` by `sync-notes.sh` - edit the .hs files, not this note.

Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## preparation.hs

```haskell
-- Lecture 7 - Preparation
-- Erklæring af typer og typeklasser
-- (OBS: arket er fra PP 2025 - opgaverne kan ændre sig for 2026)
-- Læsning: Kapitel 8 i Programming in Haskell + podcast.
--
-- Læringsmål:
--   * Forstå type-, newtype- og data-erklæringer, og hvordan de adskiller sig
--   * Definere funktioner over rekursivt definerede datatyper med mønstermatching
--   * Forstå hvordan rekursive datatyper kan implementere opbygningsregler for et sprog
--   * Forstå termkonstruktører og hvordan de anvendes
--   * Forstå principperne for og kunne deklarere nye instanser af typeklasser


-- ===== Prep 1 =====
-- Unære tal består af en endelig sekvens af I'er efterfulgt af et Z. Det naturlige
-- tal n kan repræsenteres som n på hinanden følgende I'er og et Z, så f.eks.
-- repræsenteres 4 i unær notation som IIIIZ. Det naturlige tal 0 repræsenteres som Z.
--
-- Definer en rekursiv datatype Unary for unære tal og brug din typeerklæring til at
-- definere en funktion unary2int af typen
--   unary2int :: Unary -> Integer
-- der finder det naturlige tal, som et givet unært tal repræsenterer.
-- Som eksempel skal
--   unary2int (I (I (I (I Z))))  give os  4
-- (arket skriver "unary2int (I I I I Z)" - tænk over hvorfor parenteserne er nødvendige)

-- data Unary =


-- unary2int :: Unary -> Integer
-- unary2int =


-- >>> unary2int Z
-- >>> unary2int (I (I (I (I Z))))
-- 0
-- 4



-- ===== Prep 2 =====
-- Brug erklæringen af typen Tree på side 97 til at definere en funktion least, der
-- finder det mindste element i et givet binært træ. Hvilken type skal least have?
--
-- Typen fra side 97:
data Tree a = Leaf a | Node (Tree a) a (Tree a)

-- Eksempeltræ fra bogen (side 97):
t :: Tree Int
t = Node (Node (Leaf 1) 3 (Leaf 4)) 5
         (Node (Leaf 6) 7 (Leaf 9))

-- least ::
-- least =


-- >>> :t least
-- >>> least t
-- >>> least (Leaf 42)
-- 1
-- 42

```

## exercises.hs

```haskell
-- Lecture 7 - Exercises
-- (placeholder: write the task text as comments, then the solution below)

-- ===== Task 1 =====


```
