---
tags:
  - resource
  - resource/haskell
  - resource/polymorphism
---
# Haskell - Polymorphism Rule of Thumb

Related: [[Lecture 1 - Intro to Functional Programming]]

Quick rule of thumb you can use just by looking at a type signature:

```
Only Big letters        → Monomorphic (no polymorphism)
Small letters, no =>    → Parametric polymorphism
Small letters + =>      → Ad-hoc polymorphism (type classes)
```

**Mnemonic:** "Big is fixed, small is free, arrow `=>` adds a condition."

## Monomorphic (big letters only)
Concrete types, so it works for exactly one type.

```haskell
not :: Bool -> Bool
```

## Parametric (small letters, no `=>`)
Type variables mean "any type at all." The function can't know anything about `a`, so it behaves the same for every type.

```haskell
id     :: a -> a
length :: [a] -> Int
```

## Ad-hoc (small letters + `=>`)
The constraint before `=>` says "any type, as long as it's in this class." Each type can have its own implementation (via `instance`).

```haskell
show :: Show a => a -> String
(==) :: Eq a => a -> a -> Bool
```

## Notes
- Haskell has no subtype polymorphism (no inheritance like in Java), so these three cases cover almost everything at the beginner level.
- If you later see an explicit `forall`, or a small letter applied to something like `f a` (e.g. `fmap :: Functor f => (a -> b) -> f a -> f b`), those are still the same categories, just more advanced forms.
