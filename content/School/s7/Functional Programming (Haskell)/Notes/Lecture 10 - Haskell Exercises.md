---
tags:
  - resource
  - resource/haskell
  - resource/exercises
---
# Lecture 10 - Haskell Exercises

> Auto-generated from `haskell/lecture10/*.hs` by `sync-notes.sh` - edit the .hs files, not this note.

Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## preparation.hs

```haskell
-- Lecture 10 - Preparation
-- Funktorer
-- (OBS: arket er fra PP 2025 - opgaverne kan ændre sig for 2026)
-- Læsning: Afsnit 12.1 og 12.2 i Programming in Haskell + podcast.
--
-- Læringsmål:
--   * Forstå begrebet en funktor
--   * Forstå hvordan Maybe-typer og lister kan opfattes som instanser af Functor
--   * Forstå begrebet en applikativ funktor
--   * Forstå pure og <*> og hvordan de bruges i den applikative programmeringsstil
--   * Anvende funktorer og applikative funktorer til velstrukturerede programmer


-- ===== Prep 1 =====
-- Et løg består af et endeligt antal lag, der omgiver en kerne. I denne opgave
-- lader vi kernen være en værdi. Figur 0.1 viser et løg med seks lag og kerne
-- "bingo". Nedenfor er der en erklæring af en algebraisk datatype Onion a,
-- parameteriseret med typen a.

data Onion a = Core a | Layer (Onion a) deriving Show
-- (deriving Show er tilføjet, så resultater kan vises)

-- Definér Onion som en instans af Functor.
-- Hint: Lad dig inspirere af, hvordan bogen viser, hvordan man kan lave typen Tree
-- til en instans af Functor.
--
-- Husk:  class Functor f where
--          fmap :: (a -> b) -> f a -> f b

instance Functor Onion where
  fmap f (Core x)  = Core (f x)
  fmap f (Layer o) = Layer (fmap f o)

-- Løget fra Figur 0.1 (seks lag, kerne "bingo"):
bingoOnion :: Onion String
bingoOnion = Layer (Layer (Layer (Layer (Layer (Layer (Core "bingo"))))))

-- >>> fmap length bingoOnion
-- >>> fmap (+1) (Layer (Layer (Core 41)))
-- Layer (Layer (Layer (Layer (Layer (Layer (Core 5))))))
-- Layer (Layer (Core 42))



-- ===== Prep 2 =====
-- Tjek, at de to første applikative love øverst på side 163 gælder for
-- Maybe-typen. Et tip: Brug definitionerne af pure og <*> på side 160.
--
-- De to første applikative love (s. 163):
--   (1)  pure id <*> x    = x
--   (2)  pure (g x)       = pure g <*> pure x
--
-- Maybe som Applicative (s. 160):
--   pure            = Just
--   Nothing  <*> _  = Nothing
--   (Just g) <*> mx = fmap g mx

-- Lov (1): tilfælde x = Nothing
--   pure id <*> Nothing
--   =
--
-- Lov (1): tilfælde x = Just v
--   pure id <*> Just v
--   =
--
-- Lov (2):
--   pure g <*> pure x
--   =


-- >>> pure id <*> (Nothing :: Maybe Int)
-- >>> pure id <*> Just 5
-- >>> (pure ((+1) 5) :: Maybe Int)
-- >>> pure (+1) <*> pure 5 :: Maybe Int

-- ----- Kørbar version: hvert trin i omskrivningen som rigtig kode -----
-- Hver liste indeholder trinene fra beviset. Er beviset rigtigt, giver alle
-- trin samme værdi.

-- Lov (1), x = Nothing
law1Nothing :: [Maybe Int]
law1Nothing =
  [ pure id <*> Nothing   -- start
  , Just id <*> Nothing   -- pure = Just
  , fmap id Nothing       -- (Just g) <*> mx = fmap g mx
  , Nothing               -- fmap g Nothing = Nothing
  ]

-- Lov (1), x = Just v  (her med v = 5)
law1Just :: [Maybe Int]
law1Just =
  [ pure id <*> Just 5    -- start
  , Just id <*> Just 5    -- pure = Just
  , fmap id (Just 5)      -- (Just g) <*> mx = fmap g mx
  , Just (id 5)           -- fmap g (Just x) = Just (g x)
  , Just 5                -- id v = v
  ]

-- Lov (2)  (her med g = (+1) og x = 5)
law2 :: [Maybe Int]
law2 =
  [ pure (+1) <*> pure 5  -- start
  , Just (+1) <*> Just 5  -- pure = Just (to gange)
  , fmap (+1) (Just 5)    -- (Just g) <*> mx = fmap g mx
  , Just ((+1) 5)         -- fmap g (Just x) = Just (g x)
  , pure ((+1) 5)         -- pure = Just (baglæns)
  ]

-- Er alle trin ens?
allSame :: Eq a => [a] -> Bool
allSame []       = True
allSame (x : xs) = all (== x) xs

-- Lovene som funktioner, så de kan testes på mange værdier
law1Holds :: Maybe Int -> Bool
law1Holds x = (pure id <*> x) == x

law2Holds :: (Int -> Int) -> Int -> Bool
law2Holds g x = (pure (g x) :: Maybe Int) == (pure g <*> pure x)

-- >>> law1Nothing
-- >>> law1Just
-- >>> law2
-- >>> map allSame [law1Nothing, law1Just, law2]
-- >>> map law1Holds [Nothing, Just 0, Just 5, Just (-3)]
-- >>> and [law2Holds g x | g <- [(+1), (*2), negate], x <- [-2 .. 2]]

```

## exercises.hs

```haskell
-- Lecture 10 - Exercises
-- Funktorer (10. november 2026)
-- (Task 2 ligger i exercises_task2.hs, fordi den skjuler Prelude's Functor)


-- ===== Task 1 ===== (15 min)
-- Typen for ubegrænsede træer UTree er givet ved

data UTree a = Node a [UTree a] deriving Show
-- (deriving Show er tilføjet, så resultater kan vises)

-- Definér en instans af Functor for UTree.
--
-- Husk:  class Functor f where
--          fmap :: (a -> b) -> f a -> f b

instance Functor UTree where
  fmap f (Node x xs) = Node (f x) (map (fmap f) xs)


exampleTree :: UTree Int
exampleTree = Node 1 [Node 2 [Node 4 []], Node 3 []]

-- >>> fmap (*10) exampleTree
-- >>> fmap show exampleTree
-- Node 10 [Node 20 [Node 40 []],Node 30 []]
-- Node "1" [Node "2" [Node "4" []],Node "3" []]



-- ===== Task 2 ===== (20 min)
-- Se exercises_task2.hs
-- Fuck this task. Its utter bullshit


-- ===== Task 3 ===== (15 min)
-- For den applikative funktor for lister har vi en definition af "sjov stjerne"-
-- sammensætningen <*> på side 160. Giv en alternativ rekursiv definition af
-- denne, der bruger fmap.
--
-- Bogens definition (s. 160):
--   instance Applicative [] where
--     pure x    = [x]
--     gs <*> xs = [g x | g <- gs, x <- xs]
--
-- (Vi kalder den funstar, så den ikke støder sammen med Prelude's <*>)

-- >>> :t map
-- map :: (a -> b) -> [a] -> [b]
--
-- >>> fmap length ["abc", "123", "1234"]
-- >>>  map length ["abc", "123", "1234"]
-- [3,3,4]
-- [3,3,4]

--funstar :: [a -> b] -> [a] -> [b]
funstar [] _ = []
funstar (f:fs) xs = fmap f xs ++ funstar fs xs 




-- >>> funstar [(+1), (*2)] [10, 20]
-- >>> [(+1), (*2)] <*> [10, 20]
-- [11,21,20,40]
-- [11,21,20,40]



-- ===== Task 4 ===== (20 min)
-- Brug det faktum, at listetypen kan betragtes som en applikativ funktor til at
-- definere en funktion prodthree, der tager tre lister af tal og beregner listen
-- af alle produkter af tripler af tal i listen. Som eksempel skal
--   prodthree [1,2,3] [4,5,6] [7,8,9]
-- give os listen
--   [28,32,36,35,40,45,42,48,54,56,64,72,70,80,90,84,96,108,84,96,108,
--    105,120,135,126,144,162]
--
-- Hint: Et eller andet sted skinner en sjov stjerne stadig.

prodthree :: Num a => [a] -> [a] -> [a] -> [a]
prodthree = undefined


-- >>> prodthree [1,2,3] [4,5,6] [7,8,9]
-- [28,32,36,35,40,45,42,48,54,56,64,72,70,80,90,84,96,108,84,96,108,105,120,135,126,144,162]



-- ===== Task a ===== (eget tempo)
-- Her er en typedeklaration for simple udtryk.

data Exp a = Var a | Val Integer | Add (Exp a) (Exp a) | Mult (Exp a) (Exp a)
  deriving Show

-- Vis, hvordan man gør denne type til en instans af Functor. Hvornår ville det
-- være nyttigt at betragte Exp a som en funktor? Tænk på et godt eksempel!

-- instance Functor Exp where
--   fmap =


-- Hvornår er det nyttigt?
--


exampleExp :: Exp String
exampleExp = Add (Var "x") (Mult (Val 2) (Var "y"))

-- >>> fmap length exampleExp
-- Add (Var 1) (Mult (Val 2) (Var 1))



-- ===== Task b ===== (eget tempo)
-- Vis, hvordan man gør typen Exp fra det foregående problem til en instans af
-- Applicative.
--
-- Husk:  class Functor f => Applicative f where
--          pure  :: a -> f a
--          (<*>) :: f (a -> b) -> f a -> f b

-- instance Applicative Exp where
--   pure  =
--   (<*>) =


-- >>> pure 5 :: Exp Int
-- >>> Var (+1) <*> Add (Var 1) (Val 7)



-- ===== Task c ===== (eget tempo)
-- For at løse dette problem skal du allerede have en definition af Exp som en
-- applikativ funktor fra problem b. Antag definitionerne

type Name = String
type Env = [(Name, Int)]

fetch :: Name -> Env -> Int
fetch x env = case lookup x env of
  Nothing -> error "ugyldigt navn"
  Just v  -> v

-- Brug nu alle disse definitioner til at definere en funktion
--   eval :: Exp Name -> Env -> Int
-- som, når den får et udtryk e og et miljø env, returnerer værdien af udtrykket,
-- under antagelse af, at alle variable i e er givet værdier i env.

eval :: Exp Name -> Env -> Int
eval = undefined


-- >>> eval exampleExp [("x", 3), ("y", 4)]
-- 11

```

## exercises_task2.hs

```haskell
-- Lecture 10 - Exercises, Task 2
-- (Egen fil, fordi vi skjuler Prelude's Functor og fmap, og så kan resten af
-- opgaverne ikke bruge den rigtige Functor-klasse.)

import qualified Prelude
import Prelude hiding (Functor, fmap)


-- ===== Task 2 ===== (20 min)
-- Lad r være en given type. Funktionstypekonstruktøren Arrow-r er defineret, så
-- Arrow-r a bliver (r -> a). Definér en instans af Functor for denne
-- typekonstruktør.
-- Hint: Kig på typen af fmap.
--
-- -- For at teste din løsning, tilføj følgende i starten af filen, der indeholder
-- din kode:
--   import qualified Prelude
--   import Prelude hiding (Functor, fmap)
-- (gjort ovenfor)

-- Vores egen Functor-klasse, da Prelude's nu er skjult:
class Functor f where
  fmap :: (a -> b) -> f a -> f b

-- Arrow-r skrives ((->) r) i Haskell, så f a = ((->) r) a = (r -> a).
-- Hvad bliver typen af fmap så?




instance Functor ((->) r) where
  fmap g h x = g (h x)


-- >>> fmap (+1) (*2) 5
-- >>> fmap show length "hello"

```
