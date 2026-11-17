-- Lecture 10 - Exercises
-- Funktorer (10. november 2026)
-- (Task 2 ligger i exercises_task2.hs, fordi den skjuler Prelude's Functor)


-- ===== Task 1 ===== (15 min)
-- Typen for ubegrænsede træer UTree er givet ved

data UTree a = Node a [UTree a] deriving Show
-- (deriving Show er tilføjet, så resultater kan vises)

-- Definér en instans af Functor for UTree.
--
-- Husk:  class Functor f where
--          fmap :: (a -> b) -> f a -> f b

instance Functor UTree where
  fmap f (Node x xs) = Node (f x) (map (fmap f) xs)


exampleTree :: UTree Int
exampleTree = Node 1 [Node 2 [Node 4 []], Node 3 []]

-- >>> fmap (*10) exampleTree
-- >>> fmap show exampleTree
-- Node 10 [Node 20 [Node 40 []],Node 30 []]
-- Node "1" [Node "2" [Node "4" []],Node "3" []]



-- ===== Task 2 ===== (20 min)
-- Se exercises_task2.hs
-- Fuck this task. Its utter bullshit


-- ===== Task 3 ===== (15 min)
-- For den applikative funktor for lister har vi en definition af "sjov stjerne"-
-- sammensætningen <*> på side 160. Giv en alternativ rekursiv definition af
-- denne, der bruger fmap.
--
-- Bogens definition (s. 160):
--   instance Applicative [] where
--     pure x    = [x]
--     gs <*> xs = [g x | g <- gs, x <- xs]
--
-- (Vi kalder den funstar, så den ikke støder sammen med Prelude's <*>)

-- >>> :t map
-- map :: (a -> b) -> [a] -> [b]
--
-- >>> fmap length ["abc", "123", "1234"]
-- >>>  map length ["abc", "123", "1234"]
-- [3,3,4]
-- [3,3,4]

--funstar :: [a -> b] -> [a] -> [b]
funstar [] _ = []
funstar (f:fs) xs = fmap f xs ++ funstar fs xs 




-- >>> funstar [(+1), (*2)] [10, 20]
-- >>> [(+1), (*2)] <*> [10, 20]
-- [11,21,20,40]
-- [11,21,20,40]



-- ===== Task 4 ===== (20 min)
-- Brug det faktum, at listetypen kan betragtes som en applikativ funktor til at
-- definere en funktion prodthree, der tager tre lister af tal og beregner listen
-- af alle produkter af tripler af tal i listen. Som eksempel skal
--   prodthree [1,2,3] [4,5,6] [7,8,9]
-- give os listen
--   [28,32,36,35,40,45,42,48,54,56,64,72,70,80,90,84,96,108,84,96,108,
--    105,120,135,126,144,162]
--
-- Hint: Et eller andet sted skinner en sjov stjerne stadig.

prodthree :: Num a => [a] -> [a] -> [a] -> [a]
prodthree = undefined


-- >>> prodthree [1,2,3] [4,5,6] [7,8,9]
-- [28,32,36,35,40,45,42,48,54,56,64,72,70,80,90,84,96,108,84,96,108,105,120,135,126,144,162]



-- ===== Task a ===== (eget tempo)
-- Her er en typedeklaration for simple udtryk.

data Exp a = Var a | Val Integer | Add (Exp a) (Exp a) | Mult (Exp a) (Exp a)
  deriving Show

-- Vis, hvordan man gør denne type til en instans af Functor. Hvornår ville det
-- være nyttigt at betragte Exp a som en funktor? Tænk på et godt eksempel!

-- instance Functor Exp where
--   fmap =


-- Hvornår er det nyttigt?
--


exampleExp :: Exp String
exampleExp = Add (Var "x") (Mult (Val 2) (Var "y"))

-- >>> fmap length exampleExp
-- Add (Var 1) (Mult (Val 2) (Var 1))



-- ===== Task b ===== (eget tempo)
-- Vis, hvordan man gør typen Exp fra det foregående problem til en instans af
-- Applicative.
--
-- Husk:  class Functor f => Applicative f where
--          pure  :: a -> f a
--          (<*>) :: f (a -> b) -> f a -> f b

-- instance Applicative Exp where
--   pure  =
--   (<*>) =


-- >>> pure 5 :: Exp Int
-- >>> Var (+1) <*> Add (Var 1) (Val 7)



-- ===== Task c ===== (eget tempo)
-- For at løse dette problem skal du allerede have en definition af Exp som en
-- applikativ funktor fra problem b. Antag definitionerne

type Name = String
type Env = [(Name, Int)]

fetch :: Name -> Env -> Int
fetch x env = case lookup x env of
  Nothing -> error "ugyldigt navn"
  Just v  -> v

-- Brug nu alle disse definitioner til at definere en funktion
--   eval :: Exp Name -> Env -> Int
-- som, når den får et udtryk e og et miljø env, returnerer værdien af udtrykket,
-- under antagelse af, at alle variable i e er givet værdier i env.

eval :: Exp Name -> Env -> Int
eval = undefined


-- >>> eval exampleExp [("x", 3), ("y", 4)]
-- 11
