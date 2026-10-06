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

-- >>> wrapup [1,1,1,2,3,3,2]
-- >>> wrapup [True,True,False,False,False,True]



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

-- >>> triples [(1,2,3),(4,5,6),(7,8,9)]
-- ([1,4,7],[2,5,8],[3,6,9])



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

-- rle ::


-- >>> rle ['a','a','a','g','g','b','a','a']
-- >>> rle [1,1,1,2,2,1,3,3]
-- [('a',3),('g',2),('b',1),('a',2)]
-- [(1,3),(2,2),(1,1),(3,2)]


-- === B) ===
-- Definer en funktion amy, der fortæller os, om nogle elementer i en liste
-- opfylder et givet prædikat. For eksempel, hvis
--   odd x = ((x `mod` 2) == 1)
-- så skal
--   amy odd [2,5,8,3,7,4]  returnere True, mens
--   amy odd [2,8,42]       skal returnere False.

-- amy ::


-- >>> amy odd [2,5,8,3,7,4]
-- >>> amy odd [2,8,42]
-- True
-- False


-- === C) ===
-- Lav en funktion frequencies, der, givet en streng s, opretter en liste af par
-- [(x1,f1),...,(xk,fk)] således, at hvis tegnene xi forekommer et samlet antal af
-- fi gange i listen s, så vil listen af par indeholde parret (xi,fi).
-- Som eksempel skal
--   frequencies "regninger"
-- returnere listen
--   [('r',2),('e',2),('g',2),('n',2),('i',1)]
-- Find først ud af, hvilken type funktionen skal have.

-- frequencies ::


-- >>> frequencies "regninger"
-- [('r',2),('e',2),('g',2),('n',2),('i',1)]


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

-- cfrac ::


-- >>> cfrac pi 5
-- [3,7,15,1,292]
