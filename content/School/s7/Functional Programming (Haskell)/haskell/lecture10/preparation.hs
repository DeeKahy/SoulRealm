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

-- instance Functor Onion where
--   fmap =


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
