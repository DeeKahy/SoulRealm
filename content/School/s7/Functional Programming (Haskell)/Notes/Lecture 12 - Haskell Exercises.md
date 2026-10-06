---
tags:
  - resource
  - resource/haskell
  - resource/exercises
---
# Lecture 12 - Haskell Exercises

> Auto-generated from `haskell/lecture12/*.hs` by `sync-notes.sh` - edit the .hs files, not this note.

Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## preparation.hs

```haskell
-- Lecture 12 - Preparation
-- Monadisk parsing
-- (OBS: arket er fra PP 2025 - opgaverne kan ændre sig for 2026)
-- Læsning: Kapitel 13 i Programming in Haskell + podcast.
--
-- Læringsmål:
--   * Forklare de centrale idéer bag Parser-monaden
--   * Forklare hvordan Parser-monaden kan bruges til at bygge parsere
--   * Bygge en parser ved hjælp af monadisk parsing
--
-- Husk!
--   * Genopfrisk kontekstfrie grammatikker og begrebet parsing inden tirsdag.
--   * Hent Parsing.hs fra Moodle (indeholder modulerne og funktionerne fra kap. 13).
--     Kompilér den i en terminal med:
--       ghc -I. --make Parsing.hs
--     Det giver Parsing.hi og Parsing.o - læg dem i samme mappe som denne fil.
--   * Fjern derefter kommentaren fra import-linjen herunder.

-- import Parsing


-- ===== Prep 1 =====
-- Tidligere i kurset så vi, hvordan man kan deklarere en algebraisk datatype for
-- løg. Her skal vi se på heltals-løg:

data Onion = Core Integer | Layer Onion deriving Show

-- Brug Parser-monaden til at definere en parser theonion, der kan parse strenge.
-- Når en streng har den rigtige form, skal parseren give os den tilsvarende værdi
-- af typen Onion.
-- Hvis vi for eksempel giver parseren strengen "LLLLL7", skal vi få
--   Layer (Layer (Layer (Layer (Layer (Core 7)))))

-- theonion :: Parser Onion
-- theonion =


-- >>> parse theonion "LLLLL7"
-- >>> parse theonion "7"
-- >>> parse theonion "LLx"
-- [(Layer (Layer (Layer (Layer (Layer (Core 7))))),"")]
-- [(Core 7,"")]



-- ===== Prep 2 =====
-- Sproget L = { a^n b^n | n >= 0 } er et velkendt eksempel på et kontekstfrit
-- sprog, der ikke også er et regulært sprog. For eksempel er aabb ∈ L, men
-- aab ∉ L. L kan defineres ved hjælp af den kontekstfrie grammatik
--
--   S -> a S b | ε
--
-- Brug Parser-monaden til at definere en parser ab, der genkender sproget L.
-- (arket skriver "abab ∈ L", men abab er ikke på formen a^n b^n - formentlig en
--  tastefejl for aabb)

-- ab :: Parser
-- ab =


-- >>> parse ab ""
-- >>> parse ab "ab"
-- >>> parse ab "aabb"
-- >>> parse ab "aaabbb"
-- >>> parse ab "aab"
-- >>> parse ab "abab"

```

## exercises.hs

```haskell
-- Lecture 12 - Exercises
-- (placeholder: write the task text as comments, then the solution below)

-- ===== Task 1 =====


```
