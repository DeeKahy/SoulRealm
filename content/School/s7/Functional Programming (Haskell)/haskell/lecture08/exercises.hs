-- Lecture 8 - Exercises
-- Vi genbesøger emner (27. oktober 2026)
-- Det store mål denne gang er at blive bedre til at forstå og anvende emner fra
-- kursets første halvdel, og især rekursion og datatyper.


-- ===== Task 1 ===== (10 min)
-- Find Haskell-udtryk, der har følgende typer:
--   1. (Ord a, Num a) => a -> a -> [[Bool]] -> Bool
--   2. Num a => (t -> a, t) -> a -> a

-- e1 :: (Ord a, Num a) => a -> a -> [[Bool]] -> Bool
e1 _ _ [[True]] = True
e1 x y _
  | x >= y = True
  | x == 3 && y == 3 = True
  | otherwise = False




-- e2 :: Num a => (t -> a, t) -> a -> a
e2 (f, x) y = f x + y


-- Tjek at GHC selv udleder de rigtige typer (fjern typesignaturerne først):
-- >>> :t e1
-- e1 :: (Ord a, Num a) => a -> a -> [[Bool]] -> Bool
--
-- >>> :t e2
-- >>> e2 (length, "hej") 10
-- e2 :: Num a => (t -> a, t) -> a -> a
-- 13

-- Forklaring (how to build an expression from a type):
--   Read the type as a "shopping list" and use every part:
--   * (t -> a, t): a pair of a function f and something x it can be applied to.
--     The only way to get an a out of it is f x.
--   * a -> a: one more a (y) comes in, and an a goes out.
--   * Num a: we must do arithmetic on a's, e.g. f x + y.
--   Nothing is done to t, so t stays fully polymorphic.
--   For e1: Ord a and Num a mean "compare and do arithmetic on the two a's", and
--   [[Bool]] must be USED as a list of lists of Bools (pattern [[True]] does that).
--   Simpler e1:  e1 x y bss = x + 1 > y && and (concat bss)



-- ===== Task 2 ===== (20 min) - Ministerens triples
-- En tidligere videnskabs- og uddannelsesminister forsøger at konstruere en funktion
-- triples, der tager en liste af tupler (hver tuple har præcis 3 elementer) og
-- omdanner denne liste af tupler til en tuple af lister.
--   triples [(1,2,3), (4,5,6), (7,8,9)]  skal producere  ([1,4,7], [2,5,8], [3,6,9])
--
-- Ministeren skrev følgende kode og typespecifikation, men løb ind i problemer:
--
--   triples :: Num a => [(a,a,a)] -> ([a],[a],[a])
--
--   triples [] = ()
--   triples [(a,b,c)] = ([a],[b],[c])
--   triples (x:xs,y:ys,z:zs) = [x,y,z] : Triples [(xs,ys,zs)]
--
-- a) Find de fejl, som ovenstående definition af triples har.
--
-- Fejl (markeret med ^^^ i ministerens kode):
--
--   triples :: Num a => [(a,a,a)] -> ([a],[a],[a])
--              ^^^^^     ^^^^^^^
--              (1)       (2)
--
--   triples [] = ()
--                ^^
--                (3)
--   triples [(a,b,c)] = ([a],[b],[c])
--   ^^^^^^^^^^^^^^^^^
--   (4)
--   triples (x:xs,y:ys,z:zs) = [x,y,z] : Triples [(xs,ys,zs)]
--           ^^^^^^^^^^^^^^^^   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--           (5)                (6)       ^^^^^^^ ^^^^^^^^^^^^
--                                        (7)     (8)
--
--   (1) Num a er unødvendig - funktionen regner ikke med elementerne, så den virker
--       kun på tal uden grund.
--   (2) Alle tre komponenter tvinges til samme type a. Det burde være
--       [(a,b,c)] -> ([a],[b],[c]), så f.eks. [(1,'x',True)] også virker.
--   (3) () er unit-værdien, ikke en tuple af lister. Skal være ([],[],[]).
--   (4) Overflødigt tilfælde: en liste med ét element håndteres allerede af det
--       rekursive tilfælde + basistilfældet. (Ikke en typefejl, men unødvendigt.)
--   (5) Mønstret er en TUPLE AF LISTER, men argumentet er en LISTE AF TUPLER.
--       Mønstret burde være ((x,y,z):rest).
--   (6) [x,y,z] : ... bygger en liste (af lister), ikke en tuple af lister - og
--       den samler elementerne fra én tuple i stedet for at fordele dem.
--   (7) Triples med stort T er en konstruktør, ikke funktionen triples.
--   (8) [(xs,ys,zs)] pakker halerne ind i en ny liste med én tuple - rekursionen
--       skal kaldes på resten af den oprindelige liste.

-- b) Skriv en rekursiv definition af triples, der rent faktisk virker. Brug venligst
--    rekursion og lokale erklæringer med mønstre i din løsning, og brug tilgangen
--    beskrevet i afsnit 6.6.


triples :: [(a, b, c)] -> ([a], [b], [c])

triples [] = ([],[],[])
triples ts = (first ts, second ts, third ts) where
  first [] = []
  first ((x, _, _):ts) = x : first ts
  second [] = []
  second ((_, y, _):ts) = y : second ts
  third [] = []
  third ((_, _, z):ts) = z : third ts

-- >>> triples [(1,2,3), (4,5,6), (7,8,9)]
-- >>> triples ([] :: [(Int,Int,Int)])
-- ([1,4,7],[2,5,8],[3,6,9])
-- ([],[],[])


-- c) Lav en ny definition af triples, der bruger foldr.

triplesF :: [(a,b,c)] -> ([a],[b],[c])
triplesF = foldr (\(a, b, c) (as, bs, cs) -> (a:as, b:bs, c:cs)) ([], [], [])

-- Forklaring:
--   Look at the recursive version in Lecture 5 (or below):
--     triples []           = ([], [], [])                  <- this is v
--     triples ((a,b,c):xs) = (a:as, b:bs, c:cs)            <- this is f
--       where (as, bs, cs) = triples xs                    <- the recursive result
--   Any recursion of the form "base case + combine head with result for tail" IS a
--   foldr. The base case becomes v, and the combining step becomes
--   f (a,b,c) (as,bs,cs). foldr does the recursion for you.
--   (Your version in b) works too, but walks the list 3 times, once for each
--   helper. This one walks it once.

-- >>> triplesF [(1,2,3), (4,5,6), (7,8,9)]
-- ([1,4,7],[2,5,8],[3,6,9])



-- ===== Task 3 ===== (20 min) - a-kasser
-- Regeringen har udarbejdet et nyt computerspil i forbindelse med kandidatreformen.
-- Den vigtigste datastruktur er en a-kasse, hvor a er en vilkårlig type. En a-kasse
-- kan være af en af følgende to typer:
--   * En a-kasse kan være RØD og indeholde et par af a-kasser, eller
--   * En a-kasse kan være BLÅ og indeholde en værdi.
-- Alle værdier, der findes i en nestet a-kasse, skal være af samme type.
--
-- Figur 1: En uensartet a-kasse      (R = rød, B = blå)
--   R
--   ├── R
--   │   ├── B True
--   │   └── B False
--   └── R
--       ├── R
--       │   ├── B True
--       │   └── B False
--       └── R
--           ├── R
--           │   ├── B True
--           │   └── B True
--           └── R
--               ├── B False
--               └── B False
--
-- Figur 2: En ensartet a-kasse
--   R
--   ├── R
--   │   ├── B True
--   │   └── B True
--   └── R
--       ├── R
--       │   ├── B False
--       │   └── B False
--       └── R
--           ├── R
--           │   ├── B True
--           │   └── B True
--           └── R
--               ├── B False
--               └── B False
--
-- a) Definér en algebraisk datatype Box, der beskriver de gyldige former for
--    a-kasser. Giv et udtryk af typen Box, der beskriver a-kassen i Figur 1.

data Box a = Blue a | Red (Box a) (Box a)
  deriving Show

fig1 :: Box Bool
fig1 =
  Red
    (Red (Blue True) (Blue False))
    (Red
      (Red (Blue True) (Blue False))
      (Red
        (Red (Blue True)  (Blue True))
        (Red (Blue False) (Blue False))))


fig2 :: Box Bool
fig2 =
  Red
    (Red (Blue True) (Blue True))
    (Red
      (Red (Blue False) (Blue False))
      (Red
        (Red (Blue True)  (Blue True))
        (Red (Blue False) (Blue False))))


-- >>> fig1
-- Red (Red (Blue True) (Blue False)) (Red (Red (Blue True) (Blue False)) (Red (Red (Blue True) (Blue True)) (Red (Blue False) (Blue False))))








-- b) En nestet a-kasse kaldes ensartet, hvis hver gang vi ser et par blå a-kasser
--    et eller flere niveauer nede i a-kassen, så er værdierne i disse to blå
--    a-kasser ens.
--    a-kassen i Figur 1 er IKKE ensartet. Men det er a-kassen i Figur 2. Definér en
--    funktion ensartet, der kan fortælle os, om en a-kasse er ensartet.
--    Hvad skal typen af ensartet være? Er ensartet en polymorf funktion, og hvis den
--    er, hvilke typer af polymorfi er der tale om?

ensartet :: Eq a => Box a -> Bool
ensartet (Red (Blue x) (Blue y))
  | x == y = True
  | otherwise = False

ensartet (Red l r) = ensartet l && ensartet r
ensartet (Blue _)  = True    -- ADDED: this case was missing (see OBS below)

-- OBS: Without the  ensartet (Blue _)  case, the function crashed with
-- "Non-exhaustive patterns" on any box where a Blue sits next to a Red, e.g.
--   ensartet (Red (Blue 1) (Red (Blue 2) (Blue 2)))
-- The second equation recurses into the Blue 1 alone, and no equation matched
-- a single Blue. fig1/fig2 happen to only have Blue PAIRS, so the tests passed.
-- A lone Blue has no pair, so it is trivially "ensartet".

-- >>> ensartet (Red (Blue 1) (Red (Blue 2) (Blue 2)))
-- >>> ensartet (Blue 'x')
-- True
-- True

-- Polymorfi:
--   ensartet :: Eq a => Box a -> Bool
--   * PARAMETRIC: it works for Box a for any a, and the box structure (Red/Blue) is
--     handled the same way regardless of what is inside.
--   * AD HOC (overloading): the Eq a constraint, because we compare the values with
--     ==. Which == runs depends on the type a (Bool's ==, Int's ==, ...).
--   So it is both.
--   Style: the guard | x == y = True | otherwise = False is just x == y.


-- >>> ensartet fig1
-- >>> ensartet fig2
-- False
-- True



-- ===== Flere opgaver, du kan løse =====

-- === A) ===
-- Find en funktion eller anden værdi, der har typen
--   Fractional t1 => (t2 -> t1) -> (t2 -> t1) -> (t1 -> t3) -> t2 -> t3

-- fA :: Fractional t1 => (t2 -> t1) -> (t2 -> t1) -> (t1 -> t3) -> t2 -> t3
fA f g h x = h (f x / g x)

-- >>> :t fA
-- >>> fA (+1) (*2) show 3
-- fA :: Fractional t1 => (t2 -> t1) -> (t2 -> t1) -> (t1 -> t3) -> t2 -> t3
-- "0.6666666666666666"

-- Forklaring:
--   Name the arguments: f, g :: t2 -> t1,  h :: t1 -> t3,  x :: t2.  Result: t3.
--   * The only way to get a t3 is h applied to some t1.
--   * The only way to get a t1 is f x or g x.
--   * Fractional t1 means we must use / (or another Fractional operation) on t1's.
--   So: h (f x / g x). Using BOTH f and g forces them to have the same type.
--   (Without the /, e.g. h (f x), GHC would infer a type without Fractional, and
--   g would get its own unrelated type.)


-- === B) ===
-- Målet med denne opgave er at definere en funktion frequencies, der, givet en streng
-- s, laver en liste af par [(x1,f1),...,(xk,fk)] sådan at hvis tegnet xi forekommer
-- i alt fi gange i s, så vil listen af par indeholde parret (xi,fi).
-- Som eksempel skal
--   frequencies "regninger"
-- give os listen
--   [('r',2),('e',2),('g',2),('n',2),('i',1)]
--
-- a) Hvad skal funktionens type være?
-- b) Brug REKURSION til at give en definition af frequencies.

-- a) Type: Eq a => [a] -> [(a, Int)]   (for Strings: String -> [(Char, Int)])
--    We only need == to compare characters, so it works for any Eq type.

-- b) Pure recursion, with two small recursive helpers:
frequencies :: Eq a => [a] -> [(a, Int)]
frequencies []     = []
frequencies (x:xs) = (x, 1 + count x xs) : frequencies (removeAll x xs)
  where
    count _ [] = 0
    count c (y:ys)
      | c == y    = 1 + count c ys
      | otherwise = count c ys
    removeAll _ [] = []
    removeAll c (y:ys)
      | c == y    = removeAll c ys
      | otherwise = y : removeAll c ys

-- Forklaring:
--   Take the first character x. It occurs once (itself) plus however many times it
--   is in xs. Then recurse on xs with ALL x's removed, so x is never counted again.
--   The order of the result is the order of first appearance: r, e, g, n, i.

-- >>> frequencies "regninger"
-- >>> frequencies ""
-- [('r',2),('e',2),('g',2),('n',2),('i',1)]
-- []


-- === C) ===
-- Niveauet for en a-kasse er det maksimale antal lag af røde a-kasser, der kan
-- omgive en blå a-kasse. Se Figur 1 (Task 3) for et eksempel; den a-kasse, der vises
-- der, har niveau 4. Definér en funktion niveau, der returnerer niveauet for en
-- a-kasse. Hvad skal typen af niveau være?

niveau :: Box a -> Int
niveau (Blue _)  = 0
niveau (Red l r) = 1 + max (niveau l) (niveau r)

-- >>> niveau fig1
-- >>> niveau (Blue 'x')
-- >>> niveau (Red (Blue 1) (Blue 2))
-- 4
-- 0
-- 1

-- Forklaring:
--   This is the "height" or depth of the tree. A Blue box has no red layers around
--   it (0). A Red box adds one layer on top of the DEEPEST of its two children, hence
--   max. Type: Box a -> Int. We never look at the values, so no constraint is needed:
--   parametric.


-- === D) === (20 min) - Lagdelte encyklopædier
-- Typen Encyclopedia er givet ved definitionen
data Encyclopedia a = Entry String a [Encyclopedia a]
  deriving Show

-- Figur 3 viser to encyklopædier:
--
--   t1:                    "mango" True
--                 /             |              \
--      "dingo" False      "plop" True      "plys" False
--        /        \                              |
--  "plip" True  "ninka" False              "boing" True
--
--   t2:                     "plonk" 1
--                 /             |            \
--           "zap" 3          "uhu" 4      "bingo" 5
--              |                |
--          "ninka" 8         "gif" 9

t1 :: Encyclopedia Bool
t1 = Entry "mango" True [dingo, plop, plys]
  where
    dingo = Entry "dingo" False [Entry "plip" True [], Entry "ninka" False []]
    plop  = Entry "plop" True []
    plys  = Entry "plys" False [Entry "boing" True []]

t2 :: Encyclopedia Int
t2 = Entry "plonk" 1 [zap, uhu, bingo]
  where
    zap   = Entry "zap" 3 [Entry "ninka" 8 []]
    uhu   = Entry "uhu" 4 [Entry "gif" 9 []]
    bingo = Entry "bingo" 5 []

-- En encyklopædi er lagdelt, hvis det gælder, at alle værdier på samme niveau i
-- encyklopædien er større end værdierne på niveauerne ovenover. Som eksempel er t2
-- lagdelt, da 8 og 9 på niveau 3 er større end værdierne 3, 4 og 5 på niveau 2 - som
-- igen er større end værdien 1 på niveau 1.
--
-- Definér en funktion layered, der kan fortælle os, om en encyklopædi er lagdelt.
-- Hint: Højereordensfunktionerne all og map er nyttige.

-- All values, level by level: level 1 is the root, level 2 its children, ...
levels :: Encyclopedia a -> [[a]]
levels e = go [e]
  where
    go []      = []
    go entries = map value entries : go (concat (map children entries))
    value    (Entry _ v _)  = v
    children (Entry _ _ cs) = cs

layered :: Ord a => Encyclopedia a -> Bool
layered e = all ok (zip lvls (drop 1 lvls))
  where
    lvls = levels e
    ok (upper, lower) = all (> maximum upper) lower

-- >>> levels t2
-- >>> levels t1
-- [[1],[3,4,5],[8,9]]
-- [[True],[False,True,False],[True,False,True]]

-- Forklaring:
--   1. levels does a breadth-first walk: start with [root], take the values of the
--      current entries, and the next level is all of their children concatenated.
--      It stops when there are no more entries.
--   2. zip lvls (drop 1 lvls) pairs each level with the one BELOW it:
--        [([1],[3,4,5]), ([3,4,5],[8,9])]
--   3. For each pair, every value below must be bigger than the biggest value above.
--      Checking only NEIGHBOURING levels is enough: > is transitive, so if level 3 >
--      level 2 > level 1, then level 3 > level 1 too.
--   t1: level 2 contains False, and False > True is false, so t1 is not layered.
--   Type: Ord a => Encyclopedia a -> Bool (we compare values with > and maximum).
--   maximum on an empty list would crash, but levels never produces an empty level
--   (go stops before that).

-- >>> layered t1
-- >>> layered t2
-- False
-- True


-- === E) === - Kædebrøker
-- En sætning inden for talteori siger, at ethvert reelt tal x forskelligt fra 0 kan
-- skrives som en kædebrøk. Dette er et potentielt uendeligt udtryk af formen
--
--                        1
--   x = a0 + ---------------------------
--                           1
--             a1 + ---------------------
--                              1
--                   a2 + ---------------
--                                 1
--                         a3 + ---------
--                               a4 + ...
--
-- For rationale tal vil ai'erne til sidst alle være 0, så kædebrøken er endelig; for
-- irrationale tal vil kædebrøken være uendelig.
-- Se f.eks. https://da.wikipedia.org/wiki/Kædebrøk
--
-- Skriv en Haskell-funktion cfrac, der, givet et reelt tal r og et naturligt tal n,
-- finder listen af de første n tal i kædebrøken for r. Hvad skal typen af cfrac være?

cfrac :: Double -> Int -> [Integer]
cfrac _ 0 = []
cfrac r n
  | frac == 0 = a : replicate (n - 1) 0
  | otherwise = a : cfrac (1 / frac) (n - 1)
  where
    a    = floor r
    frac = r - fromIntegral a

-- Forklaring: see lecture05/exercises.hs D) for the full explanation. Short version:
--   a0 is the integer part, floor r. What is left, frac, equals 1/(a1 + 1/(a2 + ...)),
--   so 1/frac is a new continued fraction starting with a1. Repeat n times.
--   For rational numbers frac eventually hits 0, and the rest of the a's are 0.

-- >>> cfrac pi 5
-- >>> cfrac (sqrt 2) 5
-- [3,7,15,1,292]
-- [1,2,2,2,2]
