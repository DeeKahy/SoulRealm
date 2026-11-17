---
tags:
  - resource
  - resource/haskell
  - resource/exercises
---
# Lecture 6 - Haskell Exercises

> Auto-generated from `haskell/lecture06/*.hs` by `sync-notes.sh` - edit the .hs files, not this note.

Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## preparation.hs

```haskell
-- Lecture 6 - Preparation
-- Højere-ordens-funktioner (13. oktober 2026)
-- Læsning: Kapitel 7 i Programming in Haskell + podcast.
--
-- Læringsmål:
--   * Forklare præcist, hvad en højere-ordens-funktion er, og hvad dens type er
--   * Forklare højere-ordens-funktioner på lister: map, filter, foldr og foldl
--   * Forstå de rekursive definitioner af almindelige højere-ordens-funktioner
--   * Anvende map, filter, foldr og foldl til at løse programmeringsopgaver
--   * Forklare og bruge funktionssammensætning (.)


-- ===== Prep 1 =====
-- Hvert bogstav i det latinske alfabet af små bogstaver har en position.
-- 'a' har position 1, 'c' har position 3 og 'h' har position 8.
-- I Haskell er enhver streng en liste af tegn, så String er den samme type som
-- [Char]. Vi kan definere en funktion positions, som, givet en streng af små
-- bogstaver str, giver os listen af positioner for tegnene i str. Som eksempel:
--   positions "abba"  giver  [1,2,2,1]
-- Brug funktioner af højere orden fra kapitel 7 til at definere positions.
-- Her er det nyttigt at huske, at den ordinale værdi af et tegn kan beregnes ved
-- hjælp af funktionen fromEnum, som findes i præludiet:
--   fromEnum 'a'  er  97
--   fromEnum 'b'  er  98

-- >>> fromEnum 'a'
-- >>> fromEnum 'b'
-- 97
-- 98

positions :: String -> [Int]
positions str = map (\c -> fromEnum c - fromEnum 'a' + 1) str

-- >>> :t positions
-- >>> positions "abba"
-- >>> positions "hej"
-- positions :: String -> [Int]
-- [1,2,2,1]
-- [8,5,10]

-- Forklaring:
--   fromEnum 'a' = 97, so subtracting 97 gives 'a' -> 0, 'b' -> 1, ... and +1 shifts
--   it to the 1-based positions. map applies this to every character.
--   Point-free: positions = map ((subtract 96) . fromEnum)



-- ===== Prep 2 =====
-- Funktionen sumsq tager et heltal n som argument og giver os summen af
-- kvadraterne af de første n heltal. Så sumsq n returnerer summen
--   1^2 + 2^2 + ... + n^2
-- Som eksempel giver
--   sumsq 4  os  30
--   sumsq 9  os  285
-- Brug foldr til at definere sumsq - og brug ikke map.
--
-- Husk:  foldr :: (a -> b -> b) -> b -> [a] -> b

sumsq :: Int -> Int
sumsq n = foldr (\x acc -> x * x + acc) 0 [1..n]

-- >>> :t sumsq
-- >>> sumsq 4
-- >>> sumsq 9
-- sumsq :: Int -> Int
-- 30
-- 285

-- Forklaring:
--   foldr f v replaces each (:) in [1..n] with f and the final [] with v:
--     foldr f 0 [1,2,3,4] = f 1 (f 2 (f 3 (f 4 0)))
--                         = 1*1 + (2*2 + (3*3 + (4*4 + 0))) = 30
--   Without map, the squaring has to happen inside f: f x acc = x*x + acc.
--   (General type: (Num a, Enum a) => a -> a.)

```

## exercises.hs

```haskell
-- Lecture 6 - Exercises
-- Højere-ordens-funktioner

-- ===== Diskussion - dbs =====
-- En præsident for et stort land kan lide at omtale sig selv som "den største
-- programmør, der nogensinde har levet". For at imponere en journalist definerede
-- han en funktion dbs over lister ved hjælp af højere-ordens-funktioner. Listen skal
-- tage en liste af talpar og returnere listen af tupler, hvor det andet element er
-- det dobbelte af det første element. Som eksempel skal
--   dbs [(1,4),(3,6),(9,2),(4,8)]  returnere  [(3,6),(4,8)]
-- Her er, hvad præsidenten skrev (fra dbs.hs på Moodle):
--
--   dbs xs | length xs == 0 = []
--          | otherwise = filter ((2 * fst (head xs)) == (snd (head xs))) xs
--
-- Journalisten bemærkede, at der var noget, der ikke var helt rigtigt, og at
-- kodestilen var ret klodset. Kommentarer, tak!
--
-- Hvad er der galt:
--   1. TYPE ERROR: filter wants a PREDICATE (a function a -> Bool) as its first
--      argument. (2 * fst (head xs)) == (snd (head xs)) is a single Bool, not a
--      function, so it does not typecheck.
--   2. Even if it did, it only looks at the HEAD of the list: it would decide once,
--      for the first pair, and keep or drop EVERYTHING based on that. The test has to
--      be done for EACH pair.
--   3. Clumsy style: length xs == 0 walks the whole list just to check emptiness
--      (use null xs or a [] pattern), and it is not even needed, since filter on []
--      already gives []. fst/snd/head instead of a pattern (x, y) makes it hard to read.


-- ===== Task 1 ===== (10 min)
-- Nu er det din tur! Skriv en fornuftig og ikke-klodset definition af dbs. Brug
-- højere-ordens-funktioner. Giv gode eksempler på testcases.

-- dbs ::

dbs xs = filter (how) xs where
  how (x,y)
    | x * 2 == y = True
    | otherwise = False



dbs' [] = []
dbs' ((x,y):xs)
  | x * 2 == y = (x, y) : dbs' xs
  | otherwise = dbs' xs

-- >>> :t dbs
-- >>> dbs [(1,4),(3,6),(9,2),(4,8)]
-- >>> dbs' [(1,4),(3,6),(9,2),(4,8)]
-- dbs :: (Eq a, Num a) => [(a, a)] -> [(a, a)]
-- [(3,6),(4,8)]
-- [(3,6),(4,8)]

-- Shortest version: the predicate IS the Bool expression, no guards needed, and a
-- lambda with a pair pattern keeps it on one line.
dbs2 :: (Eq a, Num a) => [(a, a)] -> [(a, a)]
dbs2 = filter (\(x, y) -> 2 * x == y)

-- >>> dbs2 [(1,4),(3,6),(9,2),(4,8)]
-- >>> dbs2 []
-- >>> dbs2 [(0,0),(-2,-4),(5,10)]
-- >>> dbs2 [(1,1),(2,3)]
-- [(3,6),(4,8)]
-- []
-- [(0,0),(-2,-4),(5,10)]
-- []

-- Forklaring:
--   Good test cases cover: the given example, the empty list, edge numbers (0,
--   negatives), all kept, and none kept.
--   dbs' (with recursion) is fine as code but is not what the task asks for:
--   filter IS that recursion, written once and for all.



-- ===== Task 2 ===== (15 min)
-- Funktionen within tager en liste af tal og et par af tal, som repræsenterer et
-- interval, og giver os en liste af tal, der er i inputlisten og inden for
-- intervallet (inklusive endepunkterne) givet af inputparret.
-- Elementerne i outputlisten skal fremstå i den samme rækkefølge, som de optrådte
-- i inputlisten. Hvis inputparret er (n1,n2), antages det, at n1 er den nedre
-- grænse for intervallet, og n2 er den øvre grænse. Som eksempel skal
--   within [1,3,4,5,2] (1,3)  give os  [1,3,2], og
--   within [1,3,4,5,2] (3,1)  give os  []
-- Definer within ved hjælp af højere-ordens-funktioner fra kapitel 7. Giv gode
-- eksempler på testcases.

-- within ::

within xs (lower, upper) = filter (pred) xs where
  pred x
    | lower <= x && upper >= x = True
    | otherwise = False

-- >>> :t within
-- >>> within [1,3,4,5,2] (1,3)
-- >>> within [1,3,4,5,2] (3,1)
-- within :: Ord a => [a] -> (a, a) -> [a]
-- [1,3,2]
-- []

-- Same idea, shorter: the condition already is a Bool.
within2 :: Ord a => [a] -> (a, a) -> [a]
within2 xs (lo, hi) = filter (\x -> lo <= x && x <= hi) xs

-- >>> within2 [1,3,4,5,2] (1,3)
-- >>> within2 [1,3,4,5,2] (3,1)
-- >>> within2 [] (1,3)
-- >>> within2 [5,5,5] (5,5)
-- >>> within2 "haskell" ('a','k')
-- [1,3,2]
-- []
-- []
-- [5,5,5]
-- "hake"

-- Forklaring:
--   filter keeps the ORDER of the input, which is what the task demands.
--   (3,1) gives [] because no x satisfies 3 <= x <= 1. Endpoints are included (<=).
--   Only Ord is needed, so it also works on Chars/Strings.


-- ===== Task 3 ===== (10 min)
-- Implementer funktionen sumrows. Funktionen tager en liste af lister af tal og
-- returnerer en endimensional liste af tal, hvor hvert tal er lig med summen af den
-- tilsvarende række i inputlisten. Hvis en liste er tom, er dens sum 0.
-- Som eksempel skal
--   sumrows [[1,2],[3,4]]  give os  [3,7], og
--   sumrows [[],[],[1]]    give os  [0,0,1]
-- Definer sumrows ved hjælp af højere-ordens-funktioner fra kapitel 7. Giv gode
-- eksempler på testcases.

-- sumrows ::
sumrows [] = []
sumrows (x:xs) = sum x : sumrows xs

sumrows' xs = map sum xs

-- >>> :t sumrows
-- >>> sumrows [[1,2],[3,4]]
-- >>> sumrows [[],[],[1]]
-- >>> sumrows' [[1,2],[3,4]]
-- >>> sumrows' [[],[],[1]]
-- sumrows :: (Foldable t, Num a) => [t a] -> [a]
-- [3,7]
-- [0,0,1]
-- [3,7]
-- [0,0,1]

-- Forklaring:
--   sumrows' is the intended answer: "do sum to every row" = map sum.
--   The first sumrows is the definition of map written out by hand.
--   Point-free version: sumrows'' = map sum
--   Type: you would write  sumrows :: Num a => [[a]] -> [a]. GHC shows
--   Foldable t because Prelude's sum works on any Foldable container, not only lists.
--   Empty rows give 0 because sum [] = 0 (the identity for +).



-- ===== Task 4 ===== (15 min) - Det er helt naturligt
-- Grundtallet for den naturlige eksponentialfunktion e = 2,718... kan skrives som
-- grænsen for den uendelige række
--   sum_{k=0}^{inf} 1/k!
-- Funktionen approx skal give os en approksimation af e, som vi finder ved at lægge
-- de første n led af denne uendelige række sammen. Det vil sige at
--   approx n = sum_{k=0}^{n} 1/k!
-- Definer approx ved hjælp af højere-ordens-funktioner fra kapitel 7;
-- fakultetsfunktionen k! er defineret ved
--   fact k = product [1..k]
-- Giv gode eksempler på testcases.

fact k = product [1..k]

approx :: (Enum a, Fractional a) => a -> a
approx n = sum (map (\k -> 1 / fact k) [0..n])

-- >>> :t approx
-- >>> approx 0
-- >>> approx 1
-- >>> approx 10
-- >>> exp 1
-- approx :: (Enum a, Fractional a) => a -> a
-- 1.0
-- 2.0
-- 2.7182818011463845
-- 2.718281828459045

-- Forklaring:
--   map turns each k in [0..n] into the term 1/k!, and sum adds them up.
--   fact 0 = product [] = 1 (the identity for *), so the k = 0 term is 1/1 = 1.
--   We divide with /, which needs Fractional, so k must be Fractional, and [0..n]
--   needs Enum. With Double it works. If you want  approx :: Int -> Double  you
--   need fromIntegral:
approxInt :: Int -> Double
approxInt n = sum (map (\k -> 1 / fromIntegral (fact k)) [0..n])

-- >>> approxInt 10
-- 2.7182818011463845

--   Already at n = 10 we are correct to 7 decimals: the terms shrink very fast.



-- ===== Task 5 ===== (10 min) - fingo
-- Her er en funktion. Hvad gør den? Og hvorfor? Brug forklaringen helt til sidst i
-- afsnit 7.3 i bogen til at hjælpe dig med at besvare "hvorfor"-spørgsmålet.

fingo :: [a] -> [a] -> [a]
fingo xs ys = foldr (:) xs ys

-- Hvad gør den:
--   fingo xs ys = ys ++ xs. It appends the FIRST list to the END of the second.
--
-- Hvorfor:
--   The end of section 7.3 explains foldr as "replace every (:) in the list with f,
--   and the final [] with v". ys = [4,5,6] is really  4 : (5 : (6 : [])).
--   foldr (:) xs replaces each (:) with (:) (no change!) and the final [] with xs:
--     4 : (5 : (6 : [1,2,3]))  =  [4,5,6,1,2,3]
--   So we just rebuild ys, but with xs stuck on the end, which is exactly ++.
--   (In fact Prelude defines  xs ++ ys = foldr (:) ys xs.)

-- >>> fingo [1,2,3] [4,5,6]
-- [4,5,6,1,2,3]



-- ===== Alphabet Worksheet =====
-- Flere opgaver til løsning i dit eget tempo.
-- Husk læringsmålene for denne kursusgang! Du skal bruge højere-ordens-funktioner
-- fra kapitel 7 - IKKE rekursion eller listeabstraktion!!

-- === A) ===
-- Funktionen partition generaliserer funktionen isolate fra kursusgang 5.
-- Funktionen partition tager et prædikat p og en liste xs og giver os parret af
-- lister af elementer, der henholdsvis opfylder og ikke opfylder prædikatet.
--   a) Definer partition ved hjælp af filter.
--   b) Definer partition ved hjælp af foldr.

partition :: (a -> Bool) -> [a] -> ([a], [a])
partition p xs = (filter p xs, filter (not . p) xs)

partition' :: (a -> Bool) -> [a] -> ([a], [a])
partition' p = foldr step ([], [])
  where
    step x (yes, no)
      | p x       = (x : yes, no)
      | otherwise = (yes, x : no)

-- Forklaring:
--   a) Two filters: keep the ones that satisfy p, and the ones that satisfy
--      "not p". not . p is function composition: \x -> not (p x).
--      Walks the list twice.
--   b) foldr walks the list once from the right. The accumulator is the PAIR of
--      lists built so far (starting at ([],[])). For each x, put it into the left or
--      right list. Since foldr processes from the right but conses onto the front,
--      the original order is preserved.

-- >>> partition even [1,2,3,4,5,6]
-- >>> partition' even [1,2,3,4,5,6]
-- ([2,4,6],[1,3,5])
-- ([2,4,6],[1,3,5])


-- === B) ===
-- Hvordan kan vi implementere funktionen filter ved hjælp af foldr?

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x acc -> if p x then x : acc else acc) []

-- >>> filter' even [1,2,3,4,5,6]
-- >>> filter' odd []
-- [2,4,6]
-- []

-- Forklaring:
--   Same pattern as partition' but with only one list. Recipe for foldr f v:
--     v   = the answer for the empty list ([] here)
--     f x acc = how to combine one element x with the answer for the rest (acc).
--   Here: if x passes, put it on the front of acc, otherwise just return acc.


-- === C) ===
-- Brug foldr til at definere en funktion remove, der tager to strenge som
-- argumenter og fjerner hvert bogstav fra den anden streng, der forekommer i den
-- første streng. Som eksempel skal
--   remove "first" "second"  give os  "econd"
-- Find først ud af, hvad funktionens type skal være.

remove :: String -> String -> String
remove xs ys = foldr (\c acc -> if c `elem` xs then acc else c : acc) [] ys

-- >>> remove "first" "second"
-- >>> remove "" "abc"
-- >>> remove "abc" "cabbage"
-- "econd"
-- "abc"
-- "ge"

-- Forklaring:
--   Type: two Strings in, a String out. (General version: Eq a => [a] -> [a] -> [a],
--   since we only need elem, which uses ==.)
--   We fold over the SECOND string and drop every character that appears in the
--   first. It is filter written as a foldr; equivalently
--   remove xs = filter (`notElem` xs).


-- === D) ===
-- Funktionen map kan anvendes på enhver funktion, så vi kan skrive map map.
-- Hvad er typen af map map? Find ud af dette UDEN at spørge Haskell-fortolkeren -
-- prøv at begrunde dit svar og spørg først derefter fortolkeren.
--
-- Mit gæt + begrundelse:
--   map :: (a -> b) -> [a] -> [b]
--   In  map map  the OUTER map gets the inner map as its function argument. To avoid
--   confusion, rename the inner one:  map :: (c -> d) -> [c] -> [d]
--   which we can read as  (c -> d) -> ([c] -> [d])  (one argument, returns a function).
--   The outer map's first argument has type (a -> b), so we match:
--     a = (c -> d)
--     b = ([c] -> [d])
--   What is left of the outer map's type is [a] -> [b], so:
--     map map :: [c -> d] -> [[c] -> [d]]
--   In words: give it a list of functions, and you get a list of "list versions" of
--   those functions.

-- >>> :t map map
-- >>> [ f [1,2,3] | f <- map map [(+1), (*10)] ]
-- map map :: [a -> b] -> [[a] -> [b]]
-- [[2,3,4],[10,20,30]]


-- === E) ===
-- Funktionen min2 tager en liste af tal og returnerer det næstmindste tal i
-- inputlisten. Hvis en liste indeholder duplikater, kan det næstmindste tal og det
-- mindste tal være identiske; i så fald skal funktionen returnere dette tal.
-- Antag, at hver inputliste indeholder mindst to tal. Som eksempel skal
--   min2 [2110, 4820, 3110, 4120]  give os  3110, og
--   min2 [2110, 4820, 2110, 4120]  give os  2110
-- Definer funktionen min2 ved hjælp af funktioner af højere orden fra kapitel 7.

min2 :: Ord a => [a] -> a
min2 (x:y:zs) = snd (foldr step (min x y, max x y) zs)
  where
    -- the accumulator is (smallest, second smallest) seen so far
    step z (a, b)
      | z <  a    = (z, a)        -- new smallest; the old smallest becomes second
      | z <  b    = (a, z)        -- between the two: new second smallest
      | otherwise = (a, b)

-- Forklaring:
--   Keep a pair (smallest, second smallest). Start with the first two elements in
--   order, then fold the rest in. Duplicates work automatically: in
--   [2110, 4820, 2110, 4120] the second 2110 is not < 2110, but it IS < 4820, so it
--   becomes the second smallest, giving 2110.
--   (A "cheat" without folds: sort and take the 2nd element, but sort is not ch. 7.)
--   Type: we only compare, so Ord a. The pattern needs >= 2 elements, as the task
--   allows us to assume.

-- >>> min2 [2110, 4820, 3110, 4120]
-- >>> min2 [2110, 4820, 2110, 4120]
-- 3110
-- 2110

```
