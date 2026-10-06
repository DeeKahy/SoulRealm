-- Lecture 4 - Preparation
-- Definition af funktioner; Listeabstraktion
-- Læsning: Kapitel 4 og 5 i Programming in Haskell (16 sider i alt) + podcast.
--
-- Læringsmål:
--   * Syntaks og uformel semantik for betingede udtryk og guards
--   * Mønstre og mønstermatchning
--   * Anonyme funktioner (lambda-udtryk)
--   * Listeabstraktion og guards i listeabstraktioner
--   * Bruge listeabstraktion til at definere funktioner


-- ===== Prep 1 =====
-- Definer, ved hjælp af mønstermatchning og uden at bruge længdefunktionen, en
-- funktion onlytwo, der fortæller os, om en liste har præcis to elementer - i
-- hvilket tilfælde den skal returnere True - eller ej, i hvilket tilfælde den skal
-- returnere False. Hvad er typen af onlytwo?

onlytwo (x:y:[]) = True
onlytwo (_) = False

-- >>> onlytwo [1,2,3]
-- >>> onlytwo [1,2]
-- >>> onlytwo [1]
-- False
-- True
-- False

-- >>> :t onlytwo

-- ===== Prep 2 =====
-- Prikproduktet af to talpar (a, b) og (c, d) er tallet a*c + b*d. Definer, ved
-- brug af listeabstraktion, en funktion alldots, der tager to lister af talpar og
-- returnerer alle mulige prikprodukter af hvert par fra den første liste og hvert
-- par fra den anden liste. Find to gode testcases til at afprøve din funktion og
-- brug dem til at teste din kode. Hvad er typen af alldots?

alldots xs ys = [a*c + b*d | (a, b) <- xs, (c, d) <- ys]


-- >>> alldots [(1,2),(3,4)] [(5,6),(7,8)]
-- >>> alldots [(1,2)] []
-- [17,23,39,53]
-- []

-- >>> :t alldots
