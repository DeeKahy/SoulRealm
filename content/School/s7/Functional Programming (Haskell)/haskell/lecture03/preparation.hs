-- Lecture 3 - Preparation (Kursusgang 3: Typer og typeklasser)

-- ===== Prep 1 =====
-- Skriv definitioner af quango og tango med følgende typer (typekorrekte er nok):
--   quango :: a -> [a]
--   tango  :: Num p1 => (a, b) -> p2 -> p1
-- Er de polymorfe? Parametrisk, ad hoc eller begge - og hvordan?

quango :: a -> [a]
quango a = [a]

tango :: Num p1 => (a, b) -> p2 -> p1
tango _ _ = 0

-- >>> :t quango
-- >>> :t tango
-- quango :: a -> [a]
-- tango :: Num p1 => (a, b) -> p2 -> p1

-- Forklaring:
--   quango: PARAMETRIC polymorphism. It works for every type a, with no constraints,
--   and does the same thing (wrap in a list) no matter what a is.
--   tango: BOTH kinds. a, b and p2 are unconstrained, so it is parametric in those.
--   p1 has the constraint Num p1, so it is AD HOC (overloading) in p1: the literal 0
--   means different things depending on which Num type the caller picks
--   (0 :: Int, 0.0 :: Double, ...).


-- ===== Prep 2 (λ-kalkyle) =====
-- Find en terminering af reduktionssekvensen for (λx.xy)(λz.(λu.uu)). Brug reglerne fra noten.

-- Forklaring:
--   Bound variables: x, z, u are all different, and y is FREE (no λ binds it).
--   So no renaming is needed.
--
--   (λx.xy)(λz.(λu.uu))
--     -> (λz.(λu.uu)) y      β: replace x in "xy" with (λz.(λu.uu))
--     -> λu.uu                β: replace z in "λu.uu" with y (z does not occur,
--                                so the argument y is just thrown away)
--
--   λu.uu is an abstraction with no redex inside (no (λ...)(...) application), so it is
--   in NORMAL FORM, and the reduction terminates after 2 steps.
