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
