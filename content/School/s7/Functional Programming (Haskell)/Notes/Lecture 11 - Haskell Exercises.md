---
tags:
  - resource
  - resource/haskell
  - resource/exercises
---
# Lecture 11 - Haskell Exercises

> Auto-generated from `haskell/lecture11/*.hs` by `sync-notes.sh` - edit the .hs files, not this note.

Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## preparation.hs

```haskell
-- Lecture 11 - Preparation
-- Monader
-- (OBS: arket er fra PP 2025 - opgaverne kan ændre sig for 2026)
-- Læsning: Afsnit 12.3 i Programming in Haskell + podcast.
--
-- Læringsmål:
--   * Forstå Maybe-monaden
--   * Forstå definitionen af en monade
--   * Forstå bind-operatoren (>>=) og hvordan den kan udtrykkes med do-notation
--   * Forstå definitionen af List-monaden
--   * Forstå State-monaden og hvordan den anvendes i programmering med tilstand


-- ===== Prep 1 =====
-- Definer en funktion
--   tuple :: Monad m => m a -> m b -> m (a, b)
-- ved hjælp af eksplicit (>>=) og derefter igen, denne gang ved hjælp af
-- do-notation. Hvad gør funktionen i tilfældet, hvor monaden er Maybe?
--
-- Husk:  (>>=) :: Monad m => m a -> (a -> m b) -> m b

-- Med eksplicit (>>=):
-- tuple :: Monad m => m a -> m b -> m (a, b)
-- tuple ma mb =


-- Med do-notation:
-- tuple' :: Monad m => m a -> m b -> m (a, b)
-- tuple' ma mb = do


-- Maybe:
-- >>> tuple (Just 1) (Just 'a')
-- >>> tuple (Just 1) (Nothing :: Maybe Char)
-- >>> tuple (Nothing :: Maybe Int) (Just 'a')
-- >>> tuple' (Just 1) (Just 'a')

-- Bonus - prøv også List-monaden:
-- >>> tuple [1,2] "ab"

-- Hvad gør tuple for Maybe?
--



-- ===== Prep 2 =====
-- Hvilket udtryk (som bruger (>>=)) er ækvivalent med følgende do-blok?
-- (Du bliver nødt til at slå definitionen af (>>=) op)
--
--   do y <- z
--      s y
--      return (f y)
--
-- Svar:
--

```

## exercises.hs

```haskell
-- Lecture 11 - Exercises
-- Monader (17. november 2026)


-- ===== Task 1 ===== (10 min)
-- To influencere havde en ophedet diskussion om List-monaden. Influencer 1
-- præsenterede en ny funktion kaldet fourfirst:
--
--   fourfirst xs = do
--     x <- xs
--     return (4,x)
--
-- "Denne funktion tager en liste og giver os et par (4, x), hvor x er det
-- første element i listen," sagde den første influencer.
--
-- "Du tager fejl," sagde Influencer 2. "Koden tildeler xs til variablen x, og
-- vi får et par, hvor den første komponent er 4 og den anden komponent er x,
-- som er en liste, der også er kendt som xs."
--
-- Forklar, ved hjælp af definitionen af List-monaden men uden at eksekvere
-- koden, hvad denne funktion egentlig gør, og hvorfor.
--
-- Husk:  instance Monad [] where
--          xs >>= f = concat (map f xs)

-- Svar:
--



-- ===== Task 2 ===== (15 min)
-- Her er et stykke Haskell-kode.

data W x = Bingo x deriving Show

instance Functor W where
  fmap f (Bingo x) = Bingo (f x)

instance Monad W where
  return x = Bingo x
  Bingo x >>= f = f x

-- a. For at dette giver mening, mangler der en definition af W som en
--    applikativ funktor. Skriv en sådan definition.
--
-- (Når du har skrevet den, skal du muligvis fjerne "return x = Bingo x" i
--  Monad-instansen, hvis GHC brokker sig - return er normalt = pure.)

-- instance Applicative W where
--   pure  =
--   (<*>) =


-- b. Et stort tøjfirma sponsorerer et populært tv-show og bad stjernen om at
--    definere en funktion
--      wrapadd :: Num b => W b -> W b -> W b
--    der opfylder, at
--      wrapadd (Bingo x) (Bingo y) = Bingo (x+y)
--    og udnytter, at W er en monade. Definitionen skulle bruges i reklamer på
--    sociale medier for en serie nye jakker. TV-stjernen kom med følgende
--    definition:
--
--      wrapadd (Bingo x) (Bingo y) = do
--        Bingo (x+y)
--
--    Tøjfirmaet klagede dog over, at denne definition ikke brugte monader på
--    en fornuftig måde og derfor ikke ville appellere til forbrugerne i
--    målgruppen. TV-stjernen blev bedt om at revidere definitionen, så den
--    bedre kunne bruges i reklameøjemed. Hvad er galt med den?
--
--    Svar:
--
--    Skriv en revideret definition, der rent faktisk bruger monaden:

-- wrapadd :: Num b => W b -> W b -> W b
-- wrapadd = undefined


-- >>> wrapadd (Bingo 3) (Bingo 4)
-- Bingo 7



-- ===== Task 3 ===== (20 min)
-- I kursusgang 7 så vi på en Haskell-datatype Aexp for aritmetiske udtryk med
-- addition og numeraler. Opbygningsreglerne var
--
--   E ::= n | E1 + E2
--
-- Nu tilføjer vi en ny konstruktion, error, så opbygningsreglerne bliver
--
--   E ::= n | error | E1 + E2
--
-- Du skal nu definere datatypen Aerr for sådanne udtryk og definere en
-- funktion eval, der kan evaluere vilkårlige Aerr-udtryk. Udtryk, der
-- indeholder forekomster af error, evaluerer til Nothing. Ellers, hvis
-- udtrykkets værdi er v, skal de evaluere til Just v.
--
-- Du skal bruge Maybe-monaden i din besvarelse.

-- data Aerr = ...
--   deriving Show

-- eval :: Aerr -> Maybe Int
-- eval = undefined


-- Eksempler (tilpas konstruktørnavne til din egen datatype):
-- >>> eval (Add (Num 1) (Num 2))
-- >>> eval (Add (Num 1) Error)
-- >>> eval Error
-- Just 3
-- Nothing
-- Nothing



-- ===== Task a ===== (eget tempo)
-- Definér en foldM-funktion, hvis type skal være:
--
--   foldM :: Monad m => (t1 -> t2 -> m t2) -> [t1] -> t2 -> m t2
--
-- Idéen er, at funktionen virker som foldl, men folder over en monade. Her er
-- et eksempel, der viser, hvad der sker, hvis vi folder over IO-monaden.
-- Hvis vi lader:

dingo :: Show a => a -> IO a
dingo x = do
  putStrLn (show x)
  return x

-- så bør vi se følgende adfærd:
--
--   *Main> foldM (\x y -> (dingo (x+y))) [1,2,3,4] 0
--   1
--   3
--   6
--   10
--
-- (Vi kalder den foldM', så den ikke støder sammen med Control.Monad.)

-- foldM' :: Monad m => (t1 -> t2 -> m t2) -> [t1] -> t2 -> m t2
-- foldM' = undefined


-- Kør i ghci:
-- foldM' (\x y -> dingo (x+y)) [1,2,3,4] 0



-- ===== Task b ===== (eget tempo)
-- Betragt træer, hvis elementer er værdier af en type i typeklassen Ord.
-- Typen Tree a er defineret ved:

data Tree a = Leaf a | Node (Tree a) (Tree a)
  deriving Show

-- Figur 1: det ordnede træ mytree1
--
--            .
--           / \
--          .   "plop"
--         / \
--     "aha" "dingo"
--
-- Figur 2: det uordnede træ mytree2
--
--            .
--           / \
--          .   "dingo"
--         / \
--     "aha" "plip"
--
-- (OBS: figurerne er aflæst fra PDF'en - tjek dem mod opgaveteksten, hvis
--  træernes form ser forkert ud.)

mytree1 :: Tree String
mytree1 = Node (Node (Leaf "aha") (Leaf "dingo")) (Leaf "plop")

mytree2 :: Tree String
mytree2 = Node (Node (Leaf "aha") (Leaf "plip")) (Leaf "dingo")

-- Brug en monade til at skrive en funktion minorder, der tager et sådant træ
-- og tjekker, om tallene i strukturen er i ikke-aftagende orden, når de læses
-- fra venstre mod højre. Hvis det er tilfældet, skal funktionen returnere
-- Just k, hvor k er det mindste tal i træet, ellers skal den give os Nothing.
--
-- Træet mytree1 er ordnet, så minorder mytree1 skal returnere Just "aha", men
-- mytree2 er ikke ordnet, så minorder mytree2 skal returnere Nothing.
--
-- Definér først en anden funktion minmax, der finder det mindste og det
-- største element i et træ under antagelse af, at træet er ordnet. Brug
-- derefter minmax til at definere minorder.
--
-- Hint: Find først nogle gode testtilfælde. Find derefter ud af, hvilken
-- monade du skal bruge.
-- Advarsel! Brug kun monadisk notation!

-- minmax :: Ord a => Tree a -> (a, a)
-- minmax = undefined

-- minorder :: Ord a => Tree a -> Maybe a
-- minorder = undefined


-- >>> minorder mytree1
-- >>> minorder mytree2
-- Just "aha"
-- Nothing

```
