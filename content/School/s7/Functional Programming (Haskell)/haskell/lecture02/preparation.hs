-- Lecture 2 - Preparation (Kursusgang 2: Første skridt)
-- Brug kun funktionerne fra kapitel 2 i Programming in Haskell.
-- Se også slide-examples.hs (simple.hs fra Moodle).

-- ===== Prep 1 =====
-- Indlæs simple.hs (slide-examples.hs). Prøv at evaluere laengde myList.
-- Hvad tror du resultatet af sumtree myBigOak bliver? Forklar hvorfor. Tjek derefter svaret i Haskell.

-- Svar: sumtree summerer alle tal i træet: 14 + 13 + 17 = 44
-- >>> laengde myList   -- se slide-examples.hs
-- >>> sumtree myBigOak  -- se slide-examples.hs


-- ===== Prep 2 =====
-- Definér second, som returnerer det andet element i en liste, hvis det findes.
--   second [1,4,5,6]                   giver 4
--   second ["some","bizarre","mango"]  giver "bizarre"
-- Vis at det virker, find to flere eksempler. Er funktionen total?

second :: [a] -> a
second (_:x:_) = x

-- >>> second [1,4,5,6]
-- >>> second ["some","bizarre","mango"]
-- 4
-- "bizarre"
-- Ikke total: second [] og second [1] fejler (non-exhaustive patterns).
