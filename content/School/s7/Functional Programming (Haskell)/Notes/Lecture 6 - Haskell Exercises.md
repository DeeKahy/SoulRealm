---
tags:
  - resource
  - resource/haskell
  - resource/exercises
---
# Lecture 6 - Haskell Exercises

> Auto-generated from `haskell/lecture06/*.hs` by `sync-notes.sh` - edit the .hs files, not this note.

Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## preparation.hs

```haskell
-- Lecture 6 - Preparation
-- Højere-ordens-funktioner (13. oktober 2026)
-- Læsning: Kapitel 7 i Programming in Haskell + podcast.
--
-- Læringsmål:
--   * Forklare præcist, hvad en højere-ordens-funktion er, og hvad dens type er
--   * Forklare højere-ordens-funktioner på lister: map, filter, foldr og foldl
--   * Forstå de rekursive definitioner af almindelige højere-ordens-funktioner
--   * Anvende map, filter, foldr og foldl til at løse programmeringsopgaver
--   * Forklare og bruge funktionssammensætning (.)


-- ===== Prep 1 =====
-- Hvert bogstav i det latinske alfabet af små bogstaver har en position.
-- 'a' har position 1, 'c' har position 3 og 'h' har position 8.
-- I Haskell er enhver streng en liste af tegn, så String er den samme type som
-- [Char]. Vi kan definere en funktion positions, som, givet en streng af små
-- bogstaver str, giver os listen af positioner for tegnene i str. Som eksempel:
--   positions "abba"  giver  [1,2,2,1]
-- Brug funktioner af højere orden fra kapitel 7 til at definere positions.
-- Her er det nyttigt at huske, at den ordinale værdi af et tegn kan beregnes ved
-- hjælp af funktionen fromEnum, som findes i præludiet:
--   fromEnum 'a'  er  97
--   fromEnum 'b'  er  98

-- >>> fromEnum 'a'
-- >>> fromEnum 'b'
-- 97
-- 98

-- positions ::
-- positions str =


-- >>> :t positions
-- >>> positions "abba"
-- >>> positions "hej"
-- [1,2,2,1]



-- ===== Prep 2 =====
-- Funktionen sumsq tager et heltal n som argument og giver os summen af
-- kvadraterne af de første n heltal. Så sumsq n returnerer summen
--   1^2 + 2^2 + ... + n^2
-- Som eksempel giver
--   sumsq 4  os  30
--   sumsq 9  os  285
-- Brug foldr til at definere sumsq - og brug ikke map.
--
-- Husk:  foldr :: (a -> b -> b) -> b -> [a] -> b

-- sumsq ::
-- sumsq n =


-- >>> :t sumsq
-- >>> sumsq 4
-- >>> sumsq 9
-- 30
-- 285

```

## exercises.hs

```haskell
-- Lecture 6 - Exercises
-- (placeholder: write the task text as comments, then the solution below)

-- ===== Task 1 =====


```
