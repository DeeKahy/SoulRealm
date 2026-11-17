-- Lecture 7 - Exercises
-- Erklæring af typer og typeklasser (20. oktober 2026)

-- Vi skjuler Prelude's Maybe, så du selv kan lave Eq-instansen i opgave D)
-- (ellers giver GHC en "Duplicate instance"-fejl).
import Prelude hiding (Maybe (..))


-- ===== Task 1 ===== (10 min)
-- Definer en Haskell-datatype Aexp for aritmetiske udtryk med addition,
-- multiplikation og numeraler. Opbygningsreglerne i den abstrakte syntaks er
--   E ::= n | E1 + E2 | E1 · E2
-- Antag at tal n er heltal.

data Aexp = Num Integer
          | Plus Aexp Aexp
          | Mult Aexp Aexp
          deriving Show


-- >>> Plus (Num 2) (Mult (Num 3) (Num 4))
-- Plus (Num 2) (Mult (Num 3) (Num 4))

-- Forklaring:
--   Each rule of the grammar becomes one constructor:
--     n        ->  Num Integer       (a leaf holding a number)
--     E1 + E2  ->  Plus Aexp Aexp    (two sub-expressions)
--     E1 · E2  ->  Mult Aexp Aexp
--   The type is RECURSIVE (Aexp mentions Aexp), just like the grammar.
--   This is ABSTRACT syntax: there are no parentheses or precedence. The tree
--   structure itself says what is grouped with what.

-- ===== Task 2 ===== (15 min)
-- Brug din Haskell-datatype fra den foregående opgave til at definere en funktion
-- eval, som, når den får en term af typen Aexp, finder værdien af udtrykket.
-- Som eksempel skal eval kunne fortælle os, at værdien af 2 · 3 + 4 er 10.

-- eval ::
eval (Num x) = x
eval (Mult x y) = eval x * eval y
eval (Plus x y) = eval x + eval y


-- >>> eval (Plus (Num 2) (Mult (Num 3) (Num 4)))
-- 14




-- Udtrykket 2 · 3 + 4 som en Aexp-term:
ex1 :: Aexp
ex1 = Plus (Mult (Num 2) (Num 3)) (Num 4)
-- >>> :t eval
-- >>> eval ex1
-- eval :: Aexp -> Integer
-- 10

-- Forklaring:
--   One equation per constructor, and recursion exactly where the type is
--   recursive. 2 · 3 + 4 must be Plus (Mult 2 3) 4: the tree encodes that · binds
--   tighter. (Plus (Num 2) (Mult ...) above is 2 + 3·4 = 14, a different tree.)



-- ===== Task 3 ===== (25 min)
-- På side 97 i bogen står en definition af datatypen List:
data List a = Nil | Cons a (List a)
  deriving Show

-- a) Forklar, hvordan vi kan repræsentere listerne [1,3,5,484000] og
--    [True,False,True] som elementer af type henholdsvis Num a => List a og List Bool.
--
-- Forklaring:
--   List a is the built-in list with other names:  Nil = []  and  Cons = (:).
--   [1,3,5,484000] is really  1 : (3 : (5 : (484000 : []))), so swap the names:
--     Cons 1 (Cons 3 (Cons 5 (Cons 484000 Nil)))
--   The type is Num a => List a because the literals 1, 3, ... can be any Num type
--   (the same way [1,3,5] :: Num a => [a]). With Bools there is no choice, so
--   List Bool.

l1 :: Num a => List a
l1 = Cons 1 (Cons 3 (Cons 5 (Cons 484000 Nil)))

l2 :: List Bool
l2 = Cons True (Cons False (Cons True Nil))


-- b) Definer en funktion tolist :: List a -> [a], der kan tage et element af type
--    List a og give os en liste af type [a].

-- tolist :: List a -> [a]
tolist Nil = []
tolist (Cons x y) = x : tolist y

-- >>> tolist l1
-- >>> tolist l2
-- [1,3,5,484000]
-- [True,False,True]


-- c) Definer en funktion append :: List a -> List a -> List a, som kan
--    konkatenere to vilkårlige elementer af type List a.

--append :: List a -> List a -> List a
append x y = append' ((tolist x) ++ (tolist y)) where
  append' [] = Nil
  append' (x:xs) = Cons x (append' xs)

-- >>> append l1 (Cons 7 Nil)
-- >>> tolist (append l2 l2)
-- Cons 1 (Cons 3 (Cons 5 (Cons 484000 (Cons 7 Nil))))
-- [True,False,True,True,False,True]

-- The version above works, but goes List -> [a] -> List and back. Directly on
-- List, it is the same as the definition of ++ for normal lists: walk down the
-- first list, and when it ends, the second list is the tail.
append' :: List a -> List a -> List a
append' Nil         ys = ys
append' (Cons x xs) ys = Cons x (append' xs ys)

-- >>> append' l2 (Cons False Nil)
-- Cons True (Cons False (Cons True (Cons False Nil)))

-- Forklaring:
--   Compare with  [] ++ ys = ys  and  (x:xs) ++ ys = x : (xs ++ ys).
--   tolist is the same pattern: replace Nil with [] and Cons with (:).



-- ===== Task 4 ===== (15 min) - Encyklopædien
-- Forfatterne til en ny encyklopædi om værdier af typen a repræsenterer deres
-- information ved hjælp af en hierarkisk struktur, hvor hver post i encyklopædien
-- er mærket med en nøgle, der er en streng, og en værdi af typen a. Poster kan have
-- underposter. Figur 1 viser to encyklopædier:
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
--
-- Forfatterne bad en berømt influencer om at definere en type Encyclopedia.
-- Influenceren skrev:
--
--   data Encyclopedia a = Leaf String a
--                       | Node1 String a (Encyclopedia a)
--                       | Node2 String a (Encyclopedia a) (Encyclopedia a)
--                       | Node3 String a (Encyclopedia a) (Encyclopedia a) (Encyclopedia a)
--     deriving Show
--
-- men klagede over Haskell's begrænsninger: "Jeg kan se af eksemplerne, at enhver
-- post højst kan have tre underposter. Intet i Haskell tillader at skrive, at der kan
-- være vilkårligt mange børn af samme type, så jeg er nødt til at skrive en meget
-- klodset definition. Haskell er ynkeligt!"
--
-- * Kom med en bedre definition. Find ud af, hvad der er galt, og kom med en bedre
--   løsning. Det er vigtigt at læse opgaveteksten meget omhyggeligt og finde ud af,
--   hvad den siger og ikke siger. Lad være med at forsøge at reparere den
--   eksisterende løsning. Begynd forfra.
-- * Vis, hvordan du repræsenterer t1 og t2 i Figur 1 som værdier t1 og t2 af din
--   type. Brug where til at undgå term-pølse!
--
-- Hvad er der galt:
--   * The text NEVER says "at most three sub-entries". It only says entries can have
--     sub-entries. The influencer generalised from two examples. A fourth child
--     would be impossible to represent.
--   * "Haskell can't express arbitrarily many children of the same type" is false:
--     that is exactly what a LIST is. [Encyclopedia a] = any number of children.
--   * Four constructors that all repeat String a is clumsy, and functions over the
--     type need four cases that all do the same thing.
--   * Leaf vs. Node is not needed either: a leaf is just an entry with NO children
--     (the empty list).

data Encyclopedia a = Entry String a [Encyclopedia a]
  deriving Show

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

-- Example of how easy functions become with one constructor: count all entries.
size :: Encyclopedia a -> Int
size (Entry _ _ children) = 1 + sum (map size children)

-- >>> t1
-- >>> size t1
-- >>> size t2
-- Entry "mango" True [Entry "dingo" False [Entry "plip" True [],Entry "ninka" False []],Entry "plop" True [],Entry "plys" False [Entry "boing" True []]]
-- 7
-- 6



-- ===== Task 5 ===== (10 min)
-- Fra lineær algebra ved vi, at et vektorrum med indre produkt er et rum, for hvilket
-- operationerne vektorsum og indre produkt (prikprodukt) er defineret. Givet to
-- vektorer v1 og v2, er summen v1 + v2 igen en vektor, og det indre produkt v1 · v2
-- er et tal. Vær opmærksom på: I lineær algebra er der meget mere til definitionen
-- af indre produkt rum end disse to krav, men i denne opgave skal du ignorere det.
-- Antag også, at det indre produkt er et tal af typen Int.
--
-- Definer en typeklasse InVector, hvis instanser er typer, der kan betragtes som
-- indre produkt rum, hvor vektorsum kaldes &&& og indre produkt kaldes ***.
-- Hint: Hvilket afsnit i bogen har du brug for her?

class InVector a where
  (&&&) :: a -> a -> a      -- vector sum: two vectors give a vector
  (***) :: a -> a -> Int    -- inner product: two vectors give a number (Int)

-- Forklaring:
--   Section 8.5 (class and instance declarations). A class lists the operations
--   (with types) that every instance must provide. a stands for "the vector type".
--   Operators made of symbols are declared in parentheses, like (==) in Eq.



-- ===== Task 6 ===== (10 min)
-- Find ud af, hvordan du erklærer Bool som en instans af InVector.
-- Hint: Du skal finde en definition af vektorsum og indre produkt for
-- sandhedsværdier.

instance InVector Bool where
  x &&& y = x || y
  x *** y = if x && y then 1 else 0

-- >>> True &&& False
-- >>> True *** True
-- >>> False *** True
-- True
-- 1
-- 0

-- Forklaring:
--   Think of a Bool as a 1-dimensional vector with coordinate 0 (False) or 1 (True).
--   * Inner product of 1-dim vectors is just multiplication: 1·1 = 1, else 0. That
--     is "and", turned into an Int.
--   * Vector sum must give another Bool. "or" is a natural choice (1+1 is capped at
--     1). Another valid choice is xor (x /= y): addition modulo 2.
--   The task ignores the vector space laws, so several answers are fine. The point
--   is the syntax: the instance gives a definition of each class method for Bool.

-- Another instance, to see that it really generalises: 2D integer vectors.
instance InVector (Int, Int) where
  (a, b) &&& (c, d) = (a + c, b + d)
  (a, b) *** (c, d) = a * c + b * d

-- >>> ((1,2) :: (Int,Int)) &&& (3,4)
-- >>> ((1,2) :: (Int,Int)) *** (3,4)
-- (4,6)
-- 11



-- ===== Alphabet Worksheet =====
-- Flere opgaver til løsning i dit eget tempo.
-- Husk læringsmålene for denne session, når du løser opgaverne!

-- === A) ===
-- Vi siger, at et binært træ er balanceret, hvis antallet af blade i ethvert venstre
-- og højre undertræ højst adskiller sig med én, hvor blade i sig selv er trivielt
-- balancerede. Definer en funktion balanced, der kan fortælle os, om et binært træ
-- er balanceret eller ej.
-- Hint: Det er en god idé også at definere en funktion, der finder antallet af
-- blade i et træ.
--
-- Træ-typen fra bogens opgaver til kapitel 8 (værdier kun i bladene):
data Tree a = Leaf a | Node (Tree a) (Tree a)
  deriving Show

-- Testtræer:
bal :: Tree Int
bal = Node (Node (Leaf 1) (Leaf 2)) (Node (Leaf 3) (Leaf 4))

unbal :: Tree Int
unbal = Node (Leaf 1) (Node (Leaf 2) (Node (Leaf 3) (Leaf 4)))

leaves :: Tree a -> Int
leaves (Leaf _)   = 1
leaves (Node l r) = leaves l + leaves r

balanced :: Tree a -> Bool
balanced (Leaf _)   = True
balanced (Node l r) = abs (leaves l - leaves r) <= 1 && balanced l && balanced r

-- Forklaring:
--   "In EVERY left and right subtree" means it is not enough to check the root:
--   both subtrees must also be balanced, so recurse with && balanced l && balanced r.
--   unbal: at the root, left has 1 leaf and right has 3, a difference of 2: False.
--   (Recomputing leaves at every node makes this O(n^2). A smarter version returns
--   the leaf count and the balance verdict together in one pass, but this is fine.)


-- >>> leaves bal
-- >>> balanced bal
-- >>> balanced unbal
-- >>> balanced (Leaf 1)
-- 4
-- True
-- False
-- True


-- === B) ===
-- Denne opgave refererer til afsnit 8.6 i bogen og de typer og funktioner, der er
-- defineret der. To boolske udsagn p og q er ækvivalente, hvis de er sande for de
-- samme substitutioner, det vil sige, for enhver substitution s gælder det, at p er
-- sandt under s hvis og kun hvis q er sandt under s. Definer en funktion equiv, hvor
--   equiv :: Prop -> Prop -> Bool
-- og sådan at equiv p q returnerer True, hvis p og q er ækvivalente, og False ellers.
-- Hint: Hvad betyder "hvis og kun hvis" i logik?
--
-- Koden fra afsnit 8.6 (bogens eval er omdøbt til evalProp, så den ikke støder
-- sammen med eval fra Task 2):
data Prop = Const Bool
          | Var Char
          | Not Prop
          | And Prop Prop
          | Imply Prop Prop
  deriving Show

type Assoc k v = [(k, v)]

find :: Eq k => k -> Assoc k v -> v
find k t = head [v | (k', v) <- t, k == k']

type Subst = Assoc Char Bool

evalProp :: Subst -> Prop -> Bool
evalProp _ (Const b)   = b
evalProp s (Var x)     = find x s
evalProp s (Not p)     = not (evalProp s p)
evalProp s (And p q)   = evalProp s p && evalProp s q
evalProp s (Imply p q) = evalProp s p <= evalProp s q

vars :: Prop -> [Char]
vars (Const _)   = []
vars (Var x)     = [x]
vars (Not p)     = vars p
vars (And p q)   = vars p ++ vars q
vars (Imply p q) = vars p ++ vars q

bools :: Int -> [[Bool]]
bools 0 = [[]]
bools n = map (False :) bss ++ map (True :) bss
  where bss = bools (n - 1)

rmdups :: Eq a => [a] -> [a]
rmdups []       = []
rmdups (x : xs) = x : filter (/= x) (rmdups xs)

substs :: Prop -> [Subst]
substs p = map (zip vs) (bools (length vs))
  where vs = rmdups (vars p)

equiv :: Prop -> Prop -> Bool
equiv p q = and [ evalProp s p == evalProp s q | s <- substs (And p q) ]

-- Forklaring:
--   "p iff q" means: p and q have the SAME truth value. For Bools, "iff" is ==.
--   So: for every substitution s, evalProp s p == evalProp s q.
--   Subtle point: we need substitutions for the variables of BOTH p and q.
--   substs p alone misses variables that only occur in q (e.g. p2 = A, q2 = A and B:
--   substs p2 only knows A, and find 'B' would crash on head []). substs (And p q)
--   is a trick to get all variables of both, since vars (And p q) = vars p ++ vars q.


-- Testudsagn:
--   A => B  er ækvivalent med  not (A and not B)
--   A       er ikke ækvivalent med  A and B
p1, q1, p2, q2 :: Prop
p1 = Imply (Var 'A') (Var 'B')
q1 = Not (And (Var 'A') (Not (Var 'B')))
p2 = Var 'A'
q2 = And (Var 'A') (Var 'B')

-- >>> equiv p1 q1
-- >>> equiv p2 q2
-- True
-- False


-- === C) ===
-- På side 106 er der en definition af Expr-datatypen for udtryk:
data Expr = Val Int | Add Expr Expr
  deriving Show

-- Definer en højereordens funktion
--   foldexp :: (Int -> a) -> (a -> a -> a) -> Expr -> a
-- således at foldexp f g erstatter hver Val-konstruktør i et udtryk med funktionen f
-- og hver Add-konstruktør med funktionen g. Brug derefter foldexp f g (med passende
-- valg for f og g) til at definere en funktion eval :: Expr -> Int, der evaluerer et
-- udtryk til en heltalværdi.
-- (Kaldes evalExpr her, så den ikke støder sammen med eval fra Task 2.)

foldexp :: (Int -> a) -> (a -> a -> a) -> Expr -> a
foldexp f _ (Val n)   = f n
foldexp f g (Add x y) = g (foldexp f g x) (foldexp f g y)

evalExpr :: Expr -> Int
evalExpr = foldexp id (+)

-- Forklaring:
--   Same idea as foldr on lists: foldr replaces (:) and []; foldexp replaces Add
--   and Val. Recursion goes into BOTH children of Add, and g combines the results.
--   eval: a Val n is just worth n (id), and Add means +.
--     evalExpr (Add (Val 2) (Val 3)) = (+) (id 2) (id 3) = 5
--   Other folds come for free, e.g. count the numbers: foldexp (const 1) (+).

-- >>> foldexp (const 1) (+) (Add (Val 2) (Add (Val 3) (Val 4)))
-- 3


-- >>> evalExpr (Add (Val 2) (Add (Val 3) (Val 4)))
-- >>> foldexp show (\x y -> "(" ++ x ++ " + " ++ y ++ ")") (Add (Val 2) (Val 3))
-- 9
-- "(2 + 3)"


-- === D) ===
-- Fuldfør følgende instansdeklaration:
--   instance Eq a => Eq (Maybe a) where
--   ...
--
-- Maybe defineret som i Prelude (Prelude's version er skjult øverst i filen):
data Maybe a = Nothing | Just a
  deriving Show

instance Eq a => Eq (Maybe a) where
  Nothing == Nothing = True
  Just x  == Just y  = x == y
  _       == _       = False

-- Forklaring:
--   "Eq a =>" means: Maybe a can only be compared if a can be. We need that because
--   comparing Just x with Just y compares x and y, using a's ==.
--   Only (==) has to be defined: Eq has a default /= = not (==).
--   The catch-all _ == _ covers the mixed cases (Just vs. Nothing).


-- >>> Just 3 == Just 3
-- >>> Just 3 == Just 4
-- >>> (Nothing :: Maybe Int) == Nothing
-- >>> Just 'a' == Nothing
-- True
-- False
-- True
-- False
