-- Lecture 7 - Preparation
-- Erklæring af typer og typeklasser
-- (OBS: arket er fra PP 2025 - opgaverne kan ændre sig for 2026)
-- Læsning: Kapitel 8 i Programming in Haskell + podcast.
--
-- Læringsmål:
--   * Forstå type-, newtype- og data-erklæringer, og hvordan de adskiller sig
--   * Definere funktioner over rekursivt definerede datatyper med mønstermatching
--   * Forstå hvordan rekursive datatyper kan implementere opbygningsregler for et sprog
--   * Forstå termkonstruktører og hvordan de anvendes
--   * Forstå principperne for og kunne deklarere nye instanser af typeklasser


-- ===== Prep 1 =====
-- Unære tal består af en endelig sekvens af I'er efterfulgt af et Z. Det naturlige
-- tal n kan repræsenteres som n på hinanden følgende I'er og et Z, så f.eks.
-- repræsenteres 4 i unær notation som IIIIZ. Det naturlige tal 0 repræsenteres som Z.
--
-- Definer en rekursiv datatype Unary for unære tal og brug din typeerklæring til at
-- definere en funktion unary2int af typen
--   unary2int :: Unary -> Integer
-- der finder det naturlige tal, som et givet unært tal repræsenterer.
-- Som eksempel skal
--   unary2int (I (I (I (I Z))))  give os  4
-- (arket skriver "unary2int (I I I I Z)" - tænk over hvorfor parenteserne er nødvendige)

data Unary = Z | I Unary


unary2int :: Unary -> Integer
unary2int Z = 0
unary2int (I u) = unary2int u + 1



-- >>> unary2int Z
-- >>> unary2int (I (I (I (I Z))))
-- 0
-- 4

-- Forklaring:
--   data Unary = Z | I Unary says: a unary number is either Z (zero), or I wrapped
--   around another unary number. It is the same shape as Peano numbers (Nat in the
--   book: Zero | Succ Nat).
--   Why the parentheses: I I I I Z would mean "apply I to the four arguments
--   I, I, I, Z", but I takes ONE argument. Function application is left
--   associative, so you have to group: I (I (I (I Z))).
--   unary2int: Z is 0, and each I adds 1. One equation per constructor.



-- ===== Prep 2 =====
-- Brug erklæringen af typen Tree på side 97 til at definere en funktion least, der
-- finder det mindste element i et givet binært træ. Hvilken type skal least have?
--
-- Typen fra side 97:
data Tree a = Leaf a | Node (Tree a) a (Tree a)

-- Eksempeltræ fra bogen (side 97):
t :: Tree Int
t = Node (Node (Leaf 1) 3 (Leaf 4)) 5
         (Node (Leaf 6) 7 (Leaf 9))


least :: Ord a => Tree a -> a
least x = minimum (flatten x) where
         flatten (Leaf x) = [x]
         flatten (Node l x r) = flatten l ++ [x] ++ flatten r



-- >>> :t least
-- >>> least t
-- >>> least (Leaf 42)
-- least :: Ord a => Tree a -> a
-- 1
-- 42

-- Direct recursive version (without building a list first):
least' :: Ord a => Tree a -> a
least' (Leaf x)     = x
least' (Node l x r) = minimum [least' l, x, least' r]

-- >>> least' t
-- 1

-- Forklaring:
--   Type: we need to compare elements (Ord a), and return one of them (a).
--   The tree has values in BOTH leaves and nodes, so the minimum is the smallest of
--   the left subtree's minimum, the node's own value, and the right subtree's
--   minimum. (In a SEARCH tree, like t, you could just go left all the way down,
--   but the task says "a given binary tree", so we can't assume it is sorted.)

