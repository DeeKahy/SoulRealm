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
-- quango :: a -> [a]
-- tango :: Num p1 => (a, b) -> p2 -> p1

-- Forklaring:
--   quango: PARAMETRIC polymorphism. It works for every type a, with no constraints,
--   and does the same thing (wrap in a list) no matter what a is.
--   tango: BOTH kinds. a, b and p2 are unconstrained, so it is parametric in those.
--   p1 has the constraint Num p1, so it is AD HOC (overloading) in p1: the literal 0
--   means different things depending on which Num type the caller picks
--   (0 :: Int, 0.0 :: Double, ...).


-- ===== Prep 2 (λ-kalkyle) =====
-- Find en terminering af reduktionssekvensen for (λx.xy)(λz.(λu.uu)). Brug reglerne fra noten.

-- Forklaring:
--   Bound variables: x, z, u are all different, and y is FREE (no λ binds it).
--   So no renaming is needed.
--
--   (λx.xy)(λz.(λu.uu))
--     -> (λz.(λu.uu)) y      β: replace x in "xy" with (λz.(λu.uu))
--     -> λu.uu                β: replace z in "λu.uu" with y (z does not occur,
--                                so the argument y is just thrown away)
--
--   λu.uu is an abstraction with no redex inside (no (λ...)(...) application), so it is
--   in NORMAL FORM, and the reduction terminates after 2 steps.

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

-- >>> :t twicetwo
-- >>> twice (*2) 5
-- >>> twicetwo ((*2), 5)
-- twicetwo :: (a -> a, a) -> a
-- 20
-- 20

-- Forklaring:
--   twice f x = f (f x). f is applied to x, and then f is applied to f's result.
--   So f's output type must equal its input type: f :: t -> t, x :: t, result :: t.
--   Nothing is assumed about t (no ==, +, ...), so it is PARAMETRIC polymorphism.
--   twicetwo is the uncurried version: both arguments are packed in one pair, so the
--   type is (t -> t, t) -> t. Same polymorphism, but you can no longer partially
--   apply it (twice (*2) is a function; twicetwo needs the whole pair at once).


-- ===== Task 4 =====
-- λ-kalkyle: (λx.xx)(λx.xx)
-- Er de bundne variable forskellige? Ellers omdøb dem. Find derefter et reduktionsskridt (brug reglerne fra noten).

-- Forklaring:
--   Both halves bind a variable called x, but they are two DIFFERENT binders (each
--   x only lives inside its own λ). To avoid confusion we α-rename the second one:
--     (λx.xx)(λy.yy)
--   β-reduction: (λx.M) N  ->  M[x := N]  (replace every free x in the body M by N).
--   Here M = xx and N = (λy.yy):
--     (λx.xx)(λy.yy)  ->  (λy.yy)(λy.yy)
--   which is the SAME term we started with (up to renaming). So the next step gives
--   the same thing again, forever:
--     (λx.xx)(λx.xx) -> (λx.xx)(λx.xx) -> ...
--   This term is usually called Ω. It has NO normal form: the reduction never
--   terminates. It is the λ-calculus version of an infinite loop. (In the simply
--   typed λ-calculus it is not even typable: x would need type A and A -> B at once.)


-- ===== Task 5 =====
-- Hvorfor er funktionstyper ikke tilladt som medlemmer af typeklassen Eq?
-- Hint: EQ_TM fra tidligere kurser.

-- Forklaring:
--   Two functions f, g :: a -> b are equal if f x == g x for EVERY x. For types like
--   Integer -> Integer there are infinitely many x, so you can never finish checking.
--   Worse, it is not just slow, it is impossible in general: Haskell functions are
--   as powerful as Turing machines, and deciding whether two TMs accept the same
--   language (EQ_TM) is UNDECIDABLE. If Eq existed for function types, (==) on
--   functions would decide EQ_TM, which is a contradiction.
--   So there is no instance Eq (a -> b), and e.g. (+1) == (1+) is a type error:
--     No instance for (Eq (Integer -> Integer))


-- ===== Bogstavopgaverne =====

-- ===== a =====
-- mango x y z = x * y + z - 42
-- Hvad er typen af mango 14? Forklar, tjek derefter i ghci.

mango x y z = x * y + z - 42
-- >>> :t mango
-- >>> :t mango 14
-- mango :: Num a => a -> a -> a -> a
-- mango 14 :: Num a => a -> a -> a

-- Forklaring:
--   *, + and - all have type Num a => a -> a -> a, so x, y, z and the result must all
--   have the same Num type: mango :: Num a => a -> a -> a -> a.
--   Functions are curried, so mango 14 is just mango with its first argument filled
--   in. One arrow disappears: mango 14 :: Num a => a -> a -> a.
--   (14 is itself a Num a => a literal, so it fits any number type.)

-- ===== b =====
-- Definér bingo :: a -> a. Er bingo polymorf? Parametrisk eller ad hoc?

bingo :: a -> a
bingo x = x

-- >>> bingo 5
-- >>> bingo "hej"
-- 5
-- "hej"

-- Forklaring:
--   Yes, polymorphic, and PARAMETRICALLY polymorphic: it works for every type a with
--   no class constraint. In fact the identity function is the ONLY total function of
--   type a -> a. Since bingo knows nothing about a, the only a it can return is the
--   one it was given.

-- ===== c =====
-- thesame tager en liste af par og returnerer parrene hvis første og andet element er ens.
--   thesame [(1,2),(4,4),(6,7),(17,17)] giver [(4,4),(17,17)]
-- Hvad skal typen af thesame være?

thesame :: Eq a => [(a, a)] -> [(a, a)]
thesame ps = [(x, y) | (x, y) <- ps, x == y]

-- >>> thesame [(1,2),(4,4),(6,7),(17,17)]
-- [(4,4),(17,17)]

-- Forklaring:
--   Both components are compared with ==, so they must be the SAME type a, and a must
--   be in Eq. The output is a subset of the input, so it has the same type.
--   Polymorphism: ad hoc (overloading) via Eq a.

-- ===== d =====
-- Hvad indeholder [ (+), (*), (+), (-) ] og hvad er typen? Svar uden ghci først, tjek derefter.
-- Hvad kan man sige om typen af [ (+), (*), (+), (-), (++) ]?

-- >>> :t [ (+), (*), (+), (-) ]
-- >>> :t [ (+), (*), (+), (-), (++) ]
-- [ (+), (*), (+), (-) ] :: Num a => [a -> a -> a]
-- [ (+), (*), (+), (-), (++) ] :: Num [a] => [[a] -> [a] -> [a]]

-- Forklaring:
--   The list contains four FUNCTIONS (the operators in parentheses are just ordinary
--   functions). All list elements must have the same type, and each is
--   Num a => a -> a -> a, so the list is Num a => [a -> a -> a].
--   Adding (++) :: [b] -> [b] -> [b] forces a = [b]. Then the Num constraint becomes
--   Num [b]: "lists must be numbers". GHC accepts the TYPE (it only infers the
--   constraint), but no instance Num [b] exists, so as soon as you try to USE the list
--   (e.g. show it, apply an element) you get "No instance for (Num [b])".
--   In practice the list is useless.

-- ===== e =====
-- Definér map, der anvender f på hvert element i xs. Eksempel: double n = 2 * n, map double [1,2,3,4] giver [2,4,6,8].
-- Hvad skal typen af map være?

map' :: (a -> b) -> [a] -> [b]
map' f xs = [f x | x <- xs]

double :: Num a => a -> a
double n = 2 * n

-- >>> map' double [1,2,3,4]
-- >>> map' show [1,2,3]
-- [2,4,6,8]
-- ["1","2","3"]

-- Forklaring:
--   (Called map' so it does not clash with Prelude's map.)
--   f takes an element of the input list (type a) and may return something of a
--   DIFFERENT type b (e.g. show :: Int -> String). So map :: (a -> b) -> [a] -> [b].
--   Parametric polymorphism: no constraints on a or b.

-- ===== f =====
-- Find et udtryk med typen (Ord a1, Eq a2) => a2 -> a2 -> (a1, a1) -> a1

hf :: (Ord a1, Eq a2) => a2 -> a2 -> (a1, a1) -> a1
hf x y (a, b) = if x == y then max a b else min a b

-- >>> :t hf
-- >>> hf 'c' 'c' (3,7)
-- >>> hf 'c' 'd' (3,7)
-- hf :: (Ord a1, Eq a2) => a2 -> a2 -> (a1, a1) -> a1
-- 7
-- 3

-- Forklaring (how to build it from the type):
--   * Eq a2 on the first two args -> compare them with ==.
--   * Ord a1 on the pair -> use something that needs ordering (max/min/</>) on it.
--   * The result is a1 -> return one of the pair's components.

-- ===== g =====
-- madras (f,x,y) = f (f x x) y
-- Skriv en curried version af madras med typen (t -> t -> t) -> t -> t -> t

madras :: (t -> t -> t, t, t) -> t
madras (f,x,y) = f (f x x) y

madras' :: (t -> t -> t) -> t -> t -> t
madras' f x y = f (f x x) y

-- >>> madras ((+), 2, 3)
-- >>> madras' (+) 2 3
-- 7
-- 7

-- Forklaring:
--   Curried = instead of one tuple, take the arguments one at a time. The body is
--   unchanged. Type: f is used as f x x and f (...) y, so f :: t -> t -> t; x and y
--   must be t, and the result is t.

```
