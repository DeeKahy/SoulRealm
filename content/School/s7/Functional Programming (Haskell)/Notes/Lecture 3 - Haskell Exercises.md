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
-- Lecture 3 - Preparation (Kursusgang 3: Typer og typeklasser)

-- ===== Prep 1 =====
-- Skriv definitioner af quango og tango med følgende typer (typekorrekte er nok):
--   quango :: a -> [a]
--   tango  :: Num p1 => (a, b) -> p2 -> p1
-- Er de polymorfe? Parametrisk, ad hoc eller begge - og hvordan?

quango :: a -> [a]
quango a = [a]

tango :: Num p1 => (a, b) -> p2 -> p1
tango _ _ = 0

-- >>> :t quango
-- >>> :t tango
-- TODO: forklar polymorfi (quango: parametrisk; tango: parametrisk i a,b,p2 og ad hoc via Num p1)


-- ===== Prep 2 (λ-kalkyle) =====
-- Find en terminering af reduktionssekvensen for (λx.xy)(λz.(λu.uu)). Brug reglerne fra noten.

-- TODO: reduktionsskridt

```

## exercises.hs

```haskell
-- Kursusgang 3: Typer og typeklasser - Opgaver

-- ===== Task 1 =====
-- Hvad er typen af dingo (x,y) = [x,y]? Forklar hvordan du fandt den, tjek derefter i ghci.
-- Er funktionen polymorf? Hvis ja: parametrisk polymorfi eller overloading (ad hoc)? Hvis nej: forklar hvorfor.

dingo (x,y) = [x,y]

-- is parametric polymorphism because it can take any tuple as input.
-- >>> dingo (1,2)
-- >>> :t dingo
-- [1,2]
-- dingo :: (a, a) -> [a]


-- ===== Task 2 =====
-- Fem typer. For hver: find et udtryk/definition med typen, og forklar om/hvilken polymorfi den bruger.
--   a) Eq a => (a, a) -> a -> [a]
--   b) (Ord a, Num a) => (a, a) -> (a, Bool)
--   c) a -> p -> a -> [a]
--   d) Bool -> (String, String)
--   e) (Ord a, Num a) => a -> a -> (Maybe [a], Bool)

--h1 :: Eq a => (a, a) -> a -> [a]
h1 (x,y) z = if x == z then [x] else [y]
-- >>> :t h1
-- h1 :: Eq a => (a, a) -> a -> [a]
-- Ad-hoc Polymorphism


-- h2 :: (Ord a, Num a) => (a, a) -> (a, Bool)
h2 (x,y) = if x < 4 then (x, True) else (y, False)
 
-- >>> :t h2
-- h2 :: (Ord a, Num a) => (a, a) -> (a, Bool)
-- Ad-hoc Polymorphism


-- h3 :: a -> p -> a -> [a]
h3 x y z = [x,z]
-- >>> :t h3
-- h3 :: a -> p -> a -> [a]
-- Parametric Polymorphism


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
-- Hvad er typen af twice f x = f (f (x))? Forklar, tjek i ghci. Polymorf? Hvilken slags?
-- Hvad med twicetwo (f,x) = f (f (x))?

-- twice :: (a -> a) -> a -> a
twice f x = f (f (x))

-- >>> :t twice
-- twice :: (t -> t) -> t -> t
-- Parametric Polymorphism




twicetwo :: ((a -> a), a) -> a
twicetwo (f,x) = f (f ( x ))


-- ===== Task 4 =====
-- λ-kalkyle: (λx.xx)(λx.xx)
-- Er de bundne variable forskellige? Ellers omdøb dem. Find derefter et reduktionsskridt (brug reglerne fra noten).

-- TODO: svar (kommentarer)


-- ===== Task 5 =====
-- Hvorfor er funktionstyper ikke tilladt som medlemmer af typeklassen Eq?
-- Hint: EQ_TM fra tidligere kurser.

-- TODO: svar (kommentarer)


-- ===== Bogstavopgaverne =====

-- ===== a =====
-- mango x y z = x * y + z - 42
-- Hvad er typen af mango 14? Forklar, tjek derefter i ghci.

mango x y z = x * y + z - 42
-- >>> :t mango 14
-- TODO

-- ===== b =====
-- Definér bingo :: a -> a. Er bingo polymorf? Parametrisk eller ad hoc?

-- TODO

-- ===== c =====
-- thesame tager en liste af par og returnerer parrene hvis første og andet element er ens.
--   thesame [(1,2),(4,4),(6,7),(17,17)] giver [(4,4),(17,17)]
-- Hvad skal typen af thesame være?

-- TODO

-- ===== d =====
-- Hvad indeholder [ (+), (*), (+), (-) ] og hvad er typen? Svar uden ghci først, tjek derefter.
-- Hvad kan man sige om typen af [ (+), (*), (+), (-), (++) ]?

-- TODO

-- ===== e =====
-- Definér map, der anvender f på hvert element i xs. Eksempel: double n = 2 * n, map double [1,2,3,4] giver [2,4,6,8].
-- Hvad skal typen af map være?

-- TODO

-- ===== f =====
-- Find et udtryk med typen (Ord a1, Eq a2) => a2 -> a2 -> (a1, a1) -> a1

-- TODO

-- ===== g =====
-- madras (f,x,y) = f (f x x) y
-- Skriv en curried version af madras med typen (t -> t -> t) -> t -> t -> t

-- TODO

```
