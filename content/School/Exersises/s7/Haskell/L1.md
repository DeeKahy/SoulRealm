- At kunne forklare begrebet en funktion i det funktionelle programmeringsparadigme på en præcis måde.
- At kunne installere Glasgow Haskell-compileren og bruge den i et simpelt programmeringsmiljø.
- At kunne redigere, indlæse og bruge simple Haskell-programmer.




In functional programming, a **function** is a deterministic mapping from inputs to outputs, modeled after mathematical functions.

## Essential Properties

**Pure functions** must satisfy:

1. **Determinism**: Same input always produces same output
2. **No side effects**: No mutation, I/O, or external state changes

## Key Characteristics

- **Referential transparency**: Function calls can be replaced by their return values
- **First-class values**: Functions can be passed as arguments, returned, and assigned to variables
- **Composition**: Functions combine to form new functions: `(g ∘ f)(x) = g(f(x))`

This enables equational reasoning and requires immutable data, contrasting with imperative procedures that rely on side effects and mutable state.