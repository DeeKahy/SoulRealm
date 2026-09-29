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
-- TODO: forklar polymorfi (quango: parametrisk; tango: parametrisk i a,b,p2 og ad hoc via Num p1)


-- ===== Prep 2 (λ-kalkyle) =====
-- Find en terminering af reduktionssekvensen for (λx.xy)(λz.(λu.uu)). Brug reglerne fra noten.

-- TODO: reduktionsskridt
