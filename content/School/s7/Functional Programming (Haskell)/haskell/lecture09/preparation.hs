-- Lecture 9 - Preparation
-- Interaktiv programmering
-- (OBS: arket er fra PP 2025 - opgaverne kan ændre sig for 2026)
-- Læsning:
--   * Kapitel 10 i Programming in Haskell
--   * Noten "The simply typed lambda-calculus in one page" (Moodle)
-- To videoer, én for hvert emne.
--
-- Læringsmål:
--   * Forstå den underliggende idé med I/O i Haskell
--   * Bruge IO-typen i Haskell
--   * Bruge sekventering med do-blokke til at skrive interaktive programmer
--   * Skrive programmer, der kombinerer de rene og urene funktioner i Haskell


-- ===== Prep 1 =====
-- Skriv et Haskell-program, der spørger efter brugerens navn og derefter siger
-- "Hej" efterfulgt af brugerens navn. Det, vi gerne vil have, er denne adfærd:
--
--   *Main> hej
--   Hvad er dit navn?
--   Graham
--   Hej Graham
--   *Main>

-- hej ::
-- hej =


-- (Test i ghci - interaktiv input virker ikke med >>> i editoren)
--   ghci> hej



-- ===== Prep 2 =====
-- Find ud af, hvad følgende udtryk gør:
--
--   sequence [ putStr "rip ", putStr "rap ", return () ]
--
-- og hvorfor Haskell vil brokke sig over:
--
--   sequence [ putStr "rip ", putStr "rap ", getChar ]
--
-- Giv derefter en forklaring. (Side 135 er din ven.)

-- >>> :t sequence
-- >>> :t putStr "rip "
-- >>> :t return ()
-- >>> :t getChar
-- >>> sequence [ putStr "rip ", putStr "rap ", return () ]

-- Udtryk 2 (udkommenteret, da det ikke typetjekker):
-- >>> sequence [ putStr "rip ", putStr "rap ", getChar ]

-- Forklaring:
--
