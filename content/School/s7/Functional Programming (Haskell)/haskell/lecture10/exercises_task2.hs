-- Lecture 10 - Exercises, Task 2
-- (Egen fil, fordi vi skjuler Prelude's Functor og fmap, og så kan resten af
-- opgaverne ikke bruge den rigtige Functor-klasse.)

import qualified Prelude
import Prelude hiding (Functor, fmap)


-- ===== Task 2 ===== (20 min)
-- Lad r være en given type. Funktionstypekonstruktøren Arrow-r er defineret, så
-- Arrow-r a bliver (r -> a). Definér en instans af Functor for denne
-- typekonstruktør.
-- Hint: Kig på typen af fmap.
--
-- -- For at teste din løsning, tilføj følgende i starten af filen, der indeholder
-- din kode:
--   import qualified Prelude
--   import Prelude hiding (Functor, fmap)
-- (gjort ovenfor)

-- Vores egen Functor-klasse, da Prelude's nu er skjult:
class Functor f where
  fmap :: (a -> b) -> f a -> f b

-- Arrow-r skrives ((->) r) i Haskell, så f a = ((->) r) a = (r -> a).
-- Hvad bliver typen af fmap så?




instance Functor ((->) r) where
  fmap g h x = g (h x)


-- >>> fmap (+1) (*2) 5
-- >>> fmap show length "hello"
