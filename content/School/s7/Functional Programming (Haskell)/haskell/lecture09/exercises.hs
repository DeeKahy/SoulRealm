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
