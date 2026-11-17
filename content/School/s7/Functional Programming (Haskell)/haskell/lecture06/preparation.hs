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
