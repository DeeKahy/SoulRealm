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
