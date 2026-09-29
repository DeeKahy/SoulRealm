
-- ===== 1 Opgaver vi skal snakke om =====
-- Kursusgang 2: Første skridt i Haskell - Opgaver


-- ===== 1.1 =====
-- Opgave 1.1: Brug funktionerne i afsnit 2.4 til at definere allbutsecond, som returnerer listen uden det andet element.
--   allbutsecond [1,4,5,6]                   giver [1,5,6]
--   allbutsecond ["some","bizarre","mango"]  giver ["some","mango"]
-- Hvordan kan I blive mere sikre på, at jeres løsning er korrekt?


allbutsecond :: [a] -> [a]
allbutsecond (x:_:xs) = x : xs
-- >>> allbutsecond [1,2,3,4,5]
-- >>> allbutsecond ["some", "thing", "hello"]
-- [1,3,4,5]
-- ["some","hello"]

-- ===== 1.2 =====
-- Opgave 1.2 (parprogrammering): Brug funktionerne i afsnit 2.3 til at definere midtover, som ved en liste af længde n
-- returnerer (list1,list2), hvor list1 er de første ⌊n/2⌋ elementer og list2 resten. Brug `div`.
--   midtover [1,4,5,6]  giver ([1,4],[5,6])
--   midtover ["this","is","actually","a","fairly","long","list"]
--     giver (["this","is","actually"],["a","fairly","long","list"])
-- Hvordan kan I blive mere sikre på, at jeres løsning er korrekt?

 


midtover :: [a] -> ([a],[a])
midtover as = (xs, zs) where
  half = div (length as) 2
  xs = take half as
  zs = drop half as 

-- >>> midtover [1,2,3,4,5]
-- ([1,2],[3,4,5])

-- ===== 1.3 =====
-- Opgave 1.3: Der er noget galt i følgende kode. Hvad? Forklar, og ret koden.
--   N = a 'div' length xs
--     where
--       a = 10
--       xs = [1,2,3,4,5]
-- (Hint: variabelnavne skal starte med lille bogstav, og `div` skal bruge backticks.)



n = a `div` length xs where
  a = 10
  xs = [1,2,3,4,5]

-- >>> n
-- 2


-- ===== Bogstavopgaverne =====
-- ===== A =====
-- Opgave a: Brug reverse fra præludiet til at definere last, som returnerer sidste element i en liste.



last' :: [a] -> a
last' xs = head sx where
  sx = reverse xs

-- >>> last' [1,2,3,4,5,6]
-- 6


-- ===== B =====
-- Opgave b: Ændr qsort fra simple.hs, så den sorterer i aftagende rækkefølge: qsort [2,5,6,3,8] giver [8,6,5,3,2].
-- Vil qsort ["kpst","ding","bop","plip"] give mening? Hvorfor/hvorfor ikke?



qsort :: (Ord a) => [a] -> [a]

qsort [] = []
qsort (x:xs) = big ++ [x] ++ small
                 where small = qsort [a | a <- xs, a <= x]
                       big   = qsort [a | a <- xs, a > x]

-- >>> qsort [6,2,2,3,1,5,6]
-- [6,5,4,3,2,2,1]


-- ===== C =====
-- Opgave c: Forestil jer, at vi ændrede qsort fra simple.hs, så vi udskiftede <= med <. Hvad ville der så ske?

-- TODO: svar/test her
