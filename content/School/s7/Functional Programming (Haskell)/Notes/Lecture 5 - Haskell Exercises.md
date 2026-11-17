---
tags:
  - resource
  - resource/haskell
  - resource/exercises
---
# Lecture 5 - Haskell Exercises

> Auto-generated from `haskell/lecture05/*.hs` by `sync-notes.sh` - edit the .hs files, not this note.

Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## preparation.hs

```haskell
-- Lecture 5 - Preparation
-- Rekursion
-- Læsning: Kapitel 6 i Programming in Haskell + podcast.
--
-- Læringsmål:
--   * Forstå strukturen af en rekursiv funktionsdefinition
--   * Læse og skrive rekursive funktionsdefinitioner på lister
--   * Læse og skrive rekursive definitioner med flere rekursive kald eller
--     gensidig rekursion
--   * Skrive rekursive funktionsdefinitioner på en struktureret måde (Afsnit 6.6)

-- ===== Prep 1 =====
-- Definér funktionen replicate ved hjælp af rekursion - og brug mønstre i din
-- løsning. Denne funktion tager et heltal n og et element x og returnerer en liste
-- med n elementer, hvor x er gentaget præcis n gange. Som eksempel skal
--   replicate 3 5  give  [5,5,5]
-- Hvilken type skal replicate have?

--replicatee :: (Eq n, Num n) => n -> [e] -> [e]

replicatee 0 [e] = []
replicatee n [e] = replicatee (n-1) [e] ++ [e]


replicateee n e = take n (repeat e)

-- >>> replicateee 4 1
-- [1,1,1,1]

-- OBS - why replicatee breaks:
--   The pattern [e] means "a list with exactly ONE element, call it e". So the second
--   argument must be a list, and replicatee 3 5 asks GHC to treat 5 as a list
--   (Num [a]), which is the 'No instance for Num [()]' error. Also the result is
--   built from [e] ++ [e] ++ ..., so you would get [[e],[e]]-ish nonsense if it
--   typechecked.
--   Fix: take the element x directly, no brackets.

replicate' :: Int -> a -> [a]
replicate' 0 _ = []
replicate' n x = x : replicate' (n - 1) x

-- >>> replicate' 3 5
-- >>> replicate' 2 "hej"
-- >>> replicate' 0 'x'
-- [5,5,5]
-- ["hej","hej"]
-- ""

-- Forklaring:
--   Type: a count (Int) and ONE element of any type a, giving a list of a's.
--   Parametric in a.
--   Base: 0 copies is []. Recursive: one x in front of n-1 copies.
--   x : ... (cons) is better than ... ++ [x]: it is O(1) instead of walking the list.
--   Note: replicate' (-1) 'x' never hits 0 and loops forever. Using  n <= 0  as the
--   base case (with a guard) makes it total.



-- ===== Prep 2 =====
-- Definér funktionen improve ved hjælp af rekursion - og brug mønstre i din
-- løsning. Den tager en liste xs og, hvis xs indeholder mindst to elementer,
-- returnerer den en liste, hvor hvert andet element er fjernet. Som eksempel skal
--   improve [1,2,3,4,5,6,7]  give  [1,3,5,7]
-- Hvilken type skal improve have?

--improve :: [a] -> [a]
improve ([]) = []
improve (x:[]) = [x]
improve (x:xs) = [x] ++ improve (drop 1 xs)

-- >>> improve [1,1,2,2,3,3,4,4]
-- [1,2,3,4]

-- >>> improve [1,2,3,4,5,6,7]
-- [1,3,5,7]

-- Cleaner with patterns only (no drop): match the first TWO elements and skip
-- the second one.
improve' :: [a] -> [a]
improve' (x:_:xs) = x : improve' xs
improve' xs       = xs              -- [] or [x]: nothing to remove

-- >>> improve' [1,2,3,4,5,6,7]
-- [1,3,5,7]

-- Forklaring: type improve :: [a] -> [a] (parametric). The pattern (x:_:xs) only
-- matches lists with at least two elements, so the last line catches [] and [x].


```

## exercises.hs

```haskell
-- Lecture 5 - Exercises
-- Rekursion

-- ===== Task 1 ===== (10 min)
-- Funktionen reverse findes i Haskell-præludiet. Den vender en liste, således at
-- f.eks. reverse [1,2,3] evaluerer til [3,2,1]. Din opgave er nu at definere din
-- egen version af denne funktion, rev. Prøv først at finde ud af, hvilken type rev
-- skal have, og følg den generelle tilgang beskrevet i Afsnit 6.6.

rev :: [a] -> [a]
rev ([]) = []
rev (x:xs) = rev xs ++ [x]


-- >>> rev [1,2,3,4,5]
-- [5,4,3,2,1]

-- Forklaring (6.6 step by step):
--   1. Type: rev :: [a] -> [a]. We never look inside the elements: parametric.
--   2. Cases: a list is either [] or (x:xs).
--   3. Base case: the reverse of [] is [].
--   4. Recursive case: reverse the tail, then put x at the END: rev xs ++ [x].
--   Bonus: this is O(n^2) because ++ walks the whole left list each time. A fast
--   version uses an accumulator, where you push onto the front as you go:
revAcc :: [a] -> [a]
revAcc xs = go xs []
  where
    go []     acc = acc
    go (y:ys) acc = go ys (y:acc)

-- >>> revAcc [1,2,3,4,5]
-- [5,4,3,2,1]

-- >>> tail "ABCD"
-- "BCD"


-- ===== Task 2 ===== (15 min)
-- En liste [a1, a2, ..., an] er aftagende, hvis a1 >= a2 >= ... >= an. Skriv en
-- funktion descending, der giver os True, når den liste, den får som argument, er
-- aftagende, og False ellers. Eksempelvis skal descending [6,5,5,1] give True, og
-- descending ["plip","pli","ppp"] skal give False.
-- Hvad er dens type?

descending [] =  True
descending (x:[]) = True
descending (x:y:xs)
  | x >= y = descending xs
  | otherwise = False

-- OBS - bug in the version above: after checking x >= y it recurses on xs, so y is
-- thrown away and never compared with the element AFTER it. Example:
--   descending [3,2,5]  ->  3 >= 2, then descending [5]  ->  True   (wrong!)
-- Fix: keep y in the list you recurse on.
descending' :: Ord a => [a] -> Bool
descending' []       = True
descending' [_]      = True
descending' (x:y:xs) = x >= y && descending' (y:xs)

-- >>> descending [3,2,5]
-- >>> descending' [3,2,5]
-- >>> descending' [6,5,5,1]
-- >>> descending' ["plip","pli","ppp"]
-- True
-- False
-- True
-- False

-- Forklaring:
--   Type: descending :: Ord a => [a] -> Bool (we use >=, so we need Ord: ad hoc).
--   "plip" >= "pli" is True ("pli" is a prefix, so it is smaller), but
--   "pli" >= "ppp" is False ('l' < 'p'), so the whole thing is False.
--   x >= y && ... reads nicer than guards that return True/False.

-- >>> descending [3,2,1]
-- >>> descending [3,2,2,1]
-- >>> descending [1,2,3]
-- >>> descending ["a","b","c"]
-- >>> descending ["c","b","a"]
-- True
-- True
-- False
-- False
-- True

-- >>> :t descending
-- >>> descending [6,5,5,1]
-- >>> descending ["plip","pli","ppp"]

-- ===== Task 3 ===== (20 min)
-- Funktionen wrapup er en funktion, der tager en liste og giver os en liste af
-- lister. Hver liste i denne liste indeholder de på hinanden følgende elementer
-- fra den oprindelige liste, der er identiske. For eksempel skal
--   wrapup [1,1,1,2,3,3,2]  give  [[1,1,1],[2],[3,3],[2]]
--   wrapup [True,True,False,False,False,True]  give  [[True,True],[False,False,False],[True]]
-- Definer wrapup i Haskell ved hjælp af rekursion (ikke listeabstraktion - det var
-- sidste uge!), men uden at bruge fst, snd, head eller tail.
-- Vink med vognstang: Husk definitionen af isolate-funktionen fra før.

--wrapup :: [a] -> [[a]]
wrapup (x:[]) = [x]
wrapup (x:xs)
  | take 1 x == head xs = wrapup ([x ++ head xs] ++ tail xs)
  | otherwise = [x] ++ wrapup xs

-- >>> wrapup ["a","a","b","c", "c"]
-- ["aa","b","cc"]

-- OBS - why the version above does not solve the task:
--   take 1 x and x ++ ... treat x as a LIST, so the input must be a list of lists.
--   It only "works" on ["a","a",...] because a String is a list of Chars. On
--   [1,1,1,2,...] you get  No instance for 'Num [()]'. It also uses head/tail, which
--   the task forbids, and wrapup [] crashes.
--
-- Solution: recurse on the tail FIRST, then decide what to do with x by looking
-- at the first group of the result (with a pattern, not head):
--   * if that group starts with an element equal to x, put x into that group
--   * otherwise x starts a new group [x]

wrapup' :: Eq a => [a] -> [[a]]
wrapup' []     = []
wrapup' (x:xs) = place (wrapup' xs)
  where
    place ((y:ys):rest) | x == y = (x:y:ys) : rest
    place groups                 = [x] : groups

-- >>> wrapup' [1,1,1,2,3,3,2]
-- >>> wrapup' [True,True,False,False,False,True]
-- >>> wrapup' "aabcc"
-- >>> wrapup' ([] :: [Int])
-- [[1,1,1],[2],[3,3],[2]]
-- [[True,True],[False,False,False],[True]]
-- ["aa","b","cc"]
-- []

-- Forklaring:
--   Type: wrapup :: Eq a => [a] -> [[a]] (we compare elements with ==).
--   Trace for [1,1,2]:
--     wrapup' [2]     = place []          = [[2]]
--     wrapup' [1,2]   = place [[2]]       = [[1],[2]]      (1 /= 2, new group)
--     wrapup' [1,1,2] = place [[1],[2]]   = [[1,1],[2]]    (1 == 1, join group)
--   The where-clause can see x, because it belongs to the equation that bound x.



-- ===== Task 4 ===== (15 min)
-- En tidligere videnskabs- og uddannelsesminister har besluttet at tage en
-- universitetsuddannelse og forsøger nu at definere en Haskell-funktion triples,
-- der tager en liste af tupler (hver tupel har præcis 3 elementer) og konverterer
-- denne liste af tupler til en tupel af lister.
--   triples [(1,2,3),(4,5,6),(7,8,9)]  skal producere  ([1,4,7],[2,5,8],[3,6,9])
-- Ministeren skrev følgende stykke kode og en typespecifikation, men løb ind i
-- problemer. Hvad er der mon i vejen?
--
--   triples :: Num a => [(a,a,a)] -> ([a],[a],[a])
--   triples [] = ()
--   triples [(a,b,c)] = ([a],[b],[c])
--   triples (x:xs,y:ys,z:zs) = [x,y,z] : Triples [(xs,ys,zs)]
--
-- Kan du gøre noget ved ministerens problemer? Hvordan kan Afsnit 6.6 hjælpe dig her?
--
-- Hvad er der galt:
--

-- triples ()
triples' ((a,b,c):xs) = [a,b,c] ++ triples' xs

-- OBS: triples' above FLATTENS the list ([1,2,3,4,5,6,7,8,9]) instead of splitting
-- it in three, it has no [] case (crashes at the end), and it forces a, b, c to have
-- the same type.
--
-- Hvad er der galt (see also lecture08/exercises.hs Task 2 for the full list):
--   * Num a is not needed and all three components are forced to one type a.
--   * triples [] = () returns unit, not a tuple of three empty lists ([],[],[]).
--   * The pattern (x:xs,y:ys,z:zs) is a TUPLE OF LISTS, but the input is a LIST OF
--     TUPLES. The pattern should be ((x,y,z):rest).
--   * [x,y,z] : ... builds a list, not a tuple, and Triples (capital T) is a
--     constructor name, not the function.
--
-- How 6.6 helps:
--   1. Type: [(a,b,c)] -> ([a],[b],[c])
--   2. Cases: [] and ((a,b,c):xs)
--   3. Base: ([],[],[])
--   4. Recursive: ASSUME triples xs already works and gives (as,bs,cs). Then just
--      put a, b, c on the front of each.

triples :: [(a, b, c)] -> ([a], [b], [c])
triples []           = ([], [], [])
triples ((a,b,c):xs) = (a:as, b:bs, c:cs)
  where (as, bs, cs) = triples xs

-- >>> triples [(1,2,3),(4,5,6),(7,8,9)]
-- >>> triples [(1,'x',True),(2,'y',False)]
-- ([1,4,7],[2,5,8],[3,6,9])
-- ([1,2],"xy",[True,False])



-- ===== Alphabet Worksheet =====
-- Her er Afsnit 6.6 rigtig nyttigt!

-- === A) ===
-- Funktionen rle er en funktion, der, når den får en liste xs, producerer en liste
-- af par af elementer fra xs og heltal (run-length encoding). Denne liste af par
-- har sine elementer i den rækkefølge, de oprindeligt optrådte, og indeholder
-- (x, n), hvis der er n på hinanden følgende forekomster af x i listen.
-- For eksempel skal
--   rle ['a','a','a','g','g','b','a','a']  give  [('a',3),('g',2),('b',1),('a',2)]
--   rle [1,1,1,2,2,1,3,3]                  give  [(1,3),(2,2),(1,1),(3,2)]
-- Definer rle i Haskell. Prøv først at finde ud af, hvilken type rle skal have,
-- og følg den generelle tilgang beskrevet i Afsnit 6.6.

rle :: Eq a => [a] -> [(a, Int)]
rle xs = map (\x -> (head x, length x)) (rle' (map (\x -> [x]) xs))

rle' (x:y:xs)
  | take 1 x == take 1 y = rle' ([x ++ y] ++ xs)
  | otherwise = [x] ++ rle' ([y] ++ xs)
rle' xs = xs

-- >>> rle ['a','a','a','g','g','b','a','a']
-- >>> rle [1,1,1,2,2,1,3,3]
-- [('a',3),('g',2),('b',1),('a',2)]
-- [(1,3),(2,2),(1,1),(3,2)]

-- Shorter alternative: rle is just wrapup followed by "count each group". Reusing
-- wrapup' means you get it almost for free:
rle2 :: Eq a => [a] -> [(a, Int)]
rle2 xs = [ (y, length g) | g@(y:_) <- wrapup' xs ]

-- >>> rle2 [1,1,1,2,2,1,3,3]
-- [(1,3),(2,2),(1,1),(3,2)]

-- Forklaring:
--   Type: we need == to see if neighbours are equal (Eq a), and the count is an Int.
--   g@(y:_) is an "as-pattern": g is the whole group, y is its first element.


-- === B) ===
-- Definer en funktion amy, der fortæller os, om nogle elementer i en liste
-- opfylder et givet prædikat. For eksempel, hvis
--   odd x = ((x `mod` 2) == 1)
-- så skal
--   amy odd [2,5,8,3,7,4]  returnere True, mens
--   amy odd [2,8,42]       skal returnere False.

amy :: (a -> Bool) -> [a] -> Bool
amy _ []     = False
amy p (x:xs) = p x || amy p xs

-- >>> amy odd [2,5,8,3,7,4]
-- >>> amy odd [2,8,42]
-- >>> amy odd []
-- True
-- False
-- False

-- Forklaring:
--   Type: the predicate takes an element and returns Bool; the result is one Bool.
--   Base: no elements means none satisfy p, so False.
--   Recursive: either x satisfies p, OR some element of the rest does.
--   || is lazy: if p x is True, the rest is never looked at (it stops early, even on
--   an infinite list: amy odd [2,4..] would loop, but amy even [1..] returns True).
--   This is Prelude's  any.



-- === C) ===
-- Lav en funktion frequencies, der, givet en streng s, opretter en liste af par
-- [(x1,f1),...,(xk,fk)] således, at hvis tegnene xi forekommer et samlet antal af
-- fi gange i listen s, så vil listen af par indeholde parret (xi,fi).
-- Som eksempel skal
--   frequencies "regninger"
-- returnere listen
--   [('r',2),('e',2),('g',2),('n',2),('i',1)]
-- Find først ud af, hvilken type funktionen skal have.

frequencies :: Eq a => [a] -> [(a, Int)]
frequencies []     = []
frequencies (x:xs) = (x, 1 + length [y | y <- xs, y == x])
                   : frequencies [y | y <- xs, y /= x]

-- >>> frequencies "regninger"
-- >>> frequencies ""
-- [('r',2),('e',2),('g',2),('n',2),('i',1)]
-- []

-- Forklaring:
--   Type: String -> [(Char, Int)] works, but nothing is Char-specific; we only need
--   ==, so the general type is Eq a => [a] -> [(a, Int)].
--   Idea: take the first character x, count how many times it occurs (itself plus
--   the copies in xs), then recurse on the rest with ALL copies of x removed. That
--   way each character is counted once, in order of first appearance, which is
--   exactly the order in the expected output (r, e, g, n, i).


-- === D) ===
-- En sætning inden for talteori siger, at ethvert ikke-nul reelt tal x kan skrives
-- som en kædebrøk. Det er et potentielt uendeligt udtryk på formen
--
--                     1
--   x = a0 + ---------------------
--                        1
--             a1 + ----------------
--                          1
--                  a2 + -----------
--                             1
--                       a3 + ------
--                             ...
--                                1
--                             + ----
--                                an
--
-- For rationale tal vil ai'erne til sidst alle være 0, så kædebrøken er endelig;
-- for irrationale tal vil den fortsatte brøk være uendelig.
-- Se f.eks. https://en.wikipedia.org/wiki/Continued_fraction for mere.
-- Målet med dette problem er at skrive en Haskell-funktion cfrac, der, givet et
-- reelt tal r og et naturligt tal n, finder listen af de første n tal i
-- kædebrøken for r. Hvad skal typen af cfrac være?

cfrac :: Double -> Int -> [Integer]
cfrac _ 0 = []
cfrac r n
  | frac == 0 = a : replicate (n - 1) 0        -- rational: the rest are 0
  | otherwise = a : cfrac (1 / frac) (n - 1)
  where
    a    = floor r
    frac = r - fromIntegral a

-- >>> cfrac pi 5
-- >>> cfrac (sqrt 2) 5
-- >>> cfrac 4.5 4
-- [3,7,15,1,292]
-- [1,2,2,2,2]
-- [4,2,0,0]

-- Forklaring:
--   The algorithm: write r = a0 + frac, where a0 = floor r (the integer part) and
--   0 <= frac < 1. From the formula, frac = 1 / (a1 + 1/(a2 + ...)), so
--   1/frac = a1 + 1/(a2 + ...), which is a new continued fraction starting at a1.
--   So: emit floor r, then do the same thing to 1/frac, n times.
--     pi = 3.14159...  -> a0 = 3,  1/0.14159... = 7.0625...
--                      -> a1 = 7,  1/0.0625...  = 15.996...
--                      -> a2 = 15, ...
--   Type: the input is a real number (Double), the count is an Int, and the outputs
--   are whole numbers (Integer). floor turns a Double into an Integer, and
--   fromIntegral turns it back so we can subtract.
--   Caveat: Double has limited precision, so after ~15 terms the numbers are noise.

```
