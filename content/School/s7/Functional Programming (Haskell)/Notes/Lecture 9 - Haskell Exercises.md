---
tags:
  - resource
  - resource/haskell
  - resource/exercises
---
# Lecture 9 - Haskell Exercises

> Auto-generated from `haskell/lecture09/*.hs` by `sync-notes.sh` - edit the .hs files, not this note.

Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## preparation.hs

```haskell
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

```

## exercises.hs

```haskell
-- Lecture 9 - Exercises
-- Interaktiv programmering (3. november 2026)


-- ===== Task 1 ===== (15 min)
-- Her er et program:
--
--   main = do
--     w <- getLine
--     loop ((read w) :: Int)
--     where
--       loop 1 = putStr (show 1)
--       loop x = do
--         putStr (show x)
--         if even x
--           then loop (x `div` 2)
--           else loop (3*x + 1)
--
-- Kør det ikke! Prøv at finde ud af, hvad det gør.

-- Forklaring:
--   It prints the COLLATZ SEQUENCE of the number you type in.
--
--   1. w <- getLine          reads one line from the keyboard, as a String.
--   2. read w :: Int         turns that String into an Int (e.g. "6" -> 6).
--   3. loop is NOT a loop that runs "that many times". It is a recursive IO
--      action defined in the where-clause, and x is simply its argument: the first
--      time, x is the number you typed. Each call:
--        * if x is 1: print 1 and stop (the first equation, the base case)
--        * otherwise: print x, then call loop again with the NEXT number:
--            x even  ->  x `div` 2
--            x odd   ->  3*x + 1
--
--   Trace for input 6:
--     loop 6  prints 6, 6 even -> loop 3
--     loop 3  prints 3, 3 odd  -> loop 10
--     loop 10 prints 10        -> loop 5
--     loop 5  prints 5         -> loop 16
--     loop 16 -> 8 -> 4 -> 2 -> loop 1, which prints 1 and stops
--
--   putStr adds no newline or space, so everything is glued together:
--     6
--     63105168421
--   (6, 3, 10, 5, 16, 8, 4, 2, 1 with no separators).
--
--   Why "don't run it": the Collatz conjecture says every positive number
--   eventually reaches 1, but nobody has proved it. And for input 0 or a negative
--   number it really does loop forever (0 -> 0 -> 0 ...; -1 -> -2 -> -1 ...),
--   and non-numeric input crashes in read with "Prelude.read: no parse".

-- The program, renamed to main1 so it can be loaded without clashing:
main1 :: IO ()
main1 = do
  w <- getLine
  loop (read w :: Int)
  where
    loop 1 = putStr (show 1)
    loop x = do
      putStr (show x)
      if even x
        then loop (x `div` 2)
        else loop (3*x + 1)

--   ghci> main1
--   6
--   63105168421


-- ===== Task 2 ===== (15 min)
-- Brug rekursion til at definere en Haskell-værdi letters, der er en sekvens af
-- handlinger, som gør følgende:
--   * Modtager en streng
--   * Udskriver tegnene i strengen ét ad gangen, hvor hvert tegn efterfølges af
--     et linjeskift
--
-- Det, vi gerne vil have, er f.eks. følgende:
--
--   *Main> letters
--   dingo
--   d
--   i
--   n
--   g
--   o
--   *Main>

dostuff [] = return ()
dostuff (x:xs) = do
  putStrLn [x]
  dostuff xs

-- letters ::

letters = do
  word <- getLine
  dostuff word


-- (Test i ghci - interaktiv input virker ikke med >>> i editoren)
--   ghci> letters



-- ===== Task 3 ===== (10 min)
-- Giv en anden definition af letters, der bruger sequence_-funktionen fra
-- forberedelsesopgave 2.



-- letters' ::
letters' = do
  word <- getLine
  sequence_ [ putStrLn [k] | k <- word ]


--   ghci> letters'



-- ===== Task 4 ===== (20 min)
-- Definer en handling hugorm :: IO (), der læser et givet antal heltal fra
-- tastaturet, ét pr. linje, og til sidst viser summen af heltalene.
-- (Hugorm er det danske ord for adder.) Det, vi gerne vil have, er f.eks.:
--
--   *Main> hugorm
--   Hvor mange tal vil du plusse? 5
--   7
--   8
--   484000
--   2
--   3
--   Det giver i alt 484020*Main>
--
-- Du skal bruge funktionerne read :: Read a => String -> a og
-- show :: Show a => a -> String til at få tal fra strenge og vise tal som strenge.
-- Alle typer i typeklassen Num er også typer i typeklasserne Read og Show.

hugorm :: IO ()
hugorm = do
  putStr "Hvor mange tal vil du plusse? "
  times <- readLn
  loop times 0 where
    loop 0 acc = putStrLn (show acc)
    loop x acc = do
      num <- readLn
      loop (x -1) (acc + num)


--   ghci> hugorm



-- ===== Ekstra a) =====
-- Skriv en rekursiv funktion sumInts :: Integer -> IO Integer, der gentagne gange
-- læser heltal fra input, indtil tallet 0 indtastes. Når det sker, returnerer
-- funktionen summen af alle de indtastede tal plus den oprindelige (standard)værdi,
-- som er givet som det første argument til sumInts.

-- - w <- getLine
-- - loop (read w :: Int)
  

sumAll acc = do
  num <- readLn
  if num == 0 then return acc else sumAll (acc + num)



-- ===== Ekstra b) =====
-- Vi kan generalisere sumInts til at være en højereordens-funktion, whileIO, som
-- for en given IO-læsehandling getIO, termineringsbetingelse condF,
-- foldningsfunktion foldF og den oprindelige værdi, returnerer den ønskede
-- IO-handling. Tjek, at vi for nogle værdier af getIO, condF og foldF kan
-- gendefinere sumInts ved hjælp af whileIO.

-- whileIO ::
-- whileIO getIO condF foldF =


-- sumInts' :: Integer -> IO Integer
-- sumInts' =


--   ghci> sumInts' 10

```
