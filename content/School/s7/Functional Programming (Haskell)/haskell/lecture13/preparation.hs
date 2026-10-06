-- Lecture 13 - Preparation
-- Lazy evaluering
-- (OBS: arket er fra PP 2025 - opgaverne kan ændre sig for 2026)
-- Læsning: Kapitel 15 i Programming in Haskell + podcast.
--
-- Læringsmål:
--   * Præcist forklare de to hovedstrategier for evaluering: call-by-value og
--     call-by-name, samt begrebet redex
--   * Give en præcis forklaring af begrebet lazy evaluering
--   * Forstå hvordan lazy evaluering tillader uendelige strukturer og endelige
--     beregninger på sådanne strukturer
--   * Forstå hvordan strict evaluering kan bruges i Haskell ($!)


-- ===== Prep 1 =====
-- Giv to forskellige definitioner (én med rekursion, én uden rekursion) af en
-- funktion nsonly, der tager et tal n som input og returnerer den uendelige liste
-- bestående af
--   0^n, 1^n, 2^n, 3^n, ...

-- Med rekursion:
-- nsonly ::
-- nsonly n =


-- Uden rekursion:
-- nsonly' ::
-- nsonly' n =


-- (Listen er uendelig - brug take!)
-- >>> take 6 (nsonly 2)
-- >>> take 6 (nsonly' 2)
-- >>> take 5 (nsonly 3)
-- [0,1,4,9,16,25]
-- [0,1,4,9,16,25]
-- [0,1,8,27,64]



-- ===== Prep 2 =====
-- Her er en definition af et udtryk.
--
--   plip = fst (17, f 484000)
--     where f x = f x + 1
--
-- Hvad er værdien af plip? Forklar!

plip = fst (17, f 484000)
  where f x = f x + 1

-- Gæt først, kør derefter:
-- >>> plip

-- Forklaring (hvad sker der med f 484000? call-by-value vs. call-by-name?):
--
