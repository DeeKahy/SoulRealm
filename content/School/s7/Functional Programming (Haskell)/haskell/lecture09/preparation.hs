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

hej :: IO ()
hej = do
  putStrLn "Hvad er dit navn?"
  name <- getLine
  putStrLn ("Hej " ++ name)

-- (Test i ghci - interaktiv input virker ikke med >>> i editoren)
--   ghci> hej
--   Hvad er dit navn?
--   Graham
--   Hej Graham

-- Forklaring:
--   * hej :: IO () is an ACTION: a description of something to do that, when run,
--     produces a value of type (), i.e. nothing interesting. Defining hej does not
--     run anything. GHCi runs it when you type hej.
--   * do sequences actions top to bottom.
--   * name <- getLine runs getLine :: IO String and binds the RESULT (a plain
--     String) to name. You need <- and not =, because getLine is not a String. It
--     is an action that GIVES a String when run.
--   * "Hej " ++ name is pure String code, used inside the IO block. This is the
--     "combine pure and impure" learning goal: do the IO with <-, and do the pure
--     work with ordinary functions.



-- ===== Prep 2 =====
-- Find ud af, hvad følgende udtryk gør:
--
--   sequence_ [ putStr "rip ", putStr "rap ", return () ]
--
-- og hvorfor Haskell vil brokke sig over:
--
--   sequence_ [ putStr "rip ", putStr "rap ", getChar ]
--
-- Giv derefter en forklaring. (Side 135 er din ven.)

-- >>> :t sequence_
-- >>> :t putStr "rip "
-- >>> :t return ()
-- >>> :t getChar
-- sequence_ :: (Foldable t, Monad m) => t (m a) -> m ()
-- putStr "rip " :: IO ()
-- return () :: Monad m => m ()
-- getChar :: IO Char

-- Udtryk 1:
-- >>> sequence_ [ putStr "rip ", putStr "rap ", return () ]
-- rip rap

-- Udtryk 2 (does not typecheck):
-- >>> sequence_ [ putStr "rip ", putStr "rap ", getChar ]
-- Couldn't match type `Char' with `()'
-- Expected: IO ()
--   Actual: IO Char
-- In the expression: getChar
-- In the first argument of `sequence_', namely
--   `[putStr "rip ", putStr "rap ", getChar]'

-- Forklaring:
--   What expression 1 does:
--     sequence_ takes a LIST OF ACTIONS and runs them one after another, left to
--     right, throwing away their results (hence the _ and the result type IO ()).
--     So it prints "rip ", then "rap ", and return () does nothing. Output: rip rap
--     It is the same as
--       do putStr "rip "
--          putStr "rap "
--          return ()
--
--   Why Haskell complains about expression 2:
--     The problem is the LIST, not sequence_. All elements of a Haskell list must
--     have the SAME type. Read the type of sequence_ (for lists and IO):
--       sequence_ :: [IO a] -> IO ()
--     There is ONE a for the whole list.
--       putStr "rip " :: IO ()      so a = ()
--       getChar       :: IO Char    so a = Char
--     a cannot be both () and Char, so you get "Couldn't match type Char with ()".
--     In expression 1, return () is polymorphic (Monad m => m ()), so it fits in as
--     IO () without problems.
--
--   Even though sequence_ throws the results away, the list still has to be
--   well-typed BEFORE sequence_ ever sees it.
--   Fix if you really want getChar in there: discard its result first, e.g.
--     sequence_ [ putStr "rip ", putStr "rap ", getChar >> return () ]
--   (>> runs getChar, ignores the Char, and continues with return ().)
