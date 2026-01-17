# Weakest Precondition – Exam Notes (Two-Sided A4)

## 1. Definition & Motivation
- **Weakest precondition** `wp(C, ψ)` is the *weakest* (least restrictive) condition on the initial state such that executing command `C` is guaranteed to terminate in a state satisfying postcondition `ψ`[^1].
- **Motivation**: Hoare calculus requires guessing intermediate assertions. Weakest precondition provides a **deterministic, algorithmic method** to prove `{ϕ}C{ψ}` without guessing[^1].

## 2. Core Theorem (Connection to Hoare Logic)
**Theorem**: `{ϕ}C{ψ}` is valid **iff** `ϕ → wp(C, ψ)`[^1].
- Proof: `{ϕ}C{ψ}` means for all states `s` where `ϕ` holds, executing `C` from `s` yields a state where `ψ` holds. This is exactly equivalent to `ϕ` implying the set of states from which `C` establishes `ψ` (i.e., `wp(C, ψ)`).

## 3. Rules for Computing `wp(C, ψ)`
These rules define a **syntactic, backward-propagation** procedure[^1]:
- **Skip**: `wp(skip, ψ) = ψ`[^1].
- **Assignment**: `wp(x := e, ψ) = ψ[e/x]` (replace every `x` in `ψ` with `e`)[^1].
- **Sequence**: `wp(C₁; C₂, ψ) = wp(C₁, wp(C₂, ψ))`[^1].
- **Conditional**: `wp(if b then C₁ else C₂, ψ) = (¬b ∨ wp(C₁, ψ)) ∧ (b ∨ wp(C₂, ψ))`[^1].
- **Loop**: `wp(while b do ⟨θ⟩ C₀, ψ) = θ` **provided** `θ` is a valid loop invariant[^1].

## 4. Algorithm for Proving `{ϕ}C{ψ}` Using `wp`
**Assumption**: Loops are already annotated with invariants `θ`[^1].
1. **Compute** `wp(C, ψ)` syntactically using the rules above.
2. **Prove** the verification condition: `ϕ → wp(C, ψ)`[^1].
3. **For loops**, additionally prove two side conditions[^1]:
   - **Invariance**: `{θ ∧ b} C₀ {θ}` (the invariant is preserved by the loop body).
   - **Postcondition**: `θ ∧ ¬b → ψ` (after loop exit, the invariant implies the desired postcondition).

## 5. Example: Factorial Program
**Program**:
```
{n ≥ 0}
f := 1;
i := 1;
while i ≤ n do ⟨f = fact(i-1) ∧ i ≤ n+1⟩ {
    f := f * i;
    i := i + 1
}
{f = fact(n)}
```
**Weakest precondition calculation**[^1]:
- Loop rule: `wp(while..., f = fact(n)) = θ = (f = fact(i-1) ∧ i ≤ n+1)`.
- Side conditions to check:
  1. Invariance: `{f = fact(i-1) ∧ i ≤ n+1 ∧ i ≤ n} body {f = fact(i-1) ∧ i ≤ n+1}`.
  2. Postcondition: `(f = fact(i-1) ∧ i ≤ n+1 ∧ i > n) → f = fact(n)`.

## 6. Key Insights & Notes
- **Mechanization**: `wp` provides a purely syntactic, algorithmic alternative to the guesswork in Hoare calculus[^1].
- **Loop invariants are crucial**: The result for loops (`wp = θ`) depends entirely on a provided, correct invariant[^1].
- **Weakest liberal precondition**: Some authors use a variant that does **not** require loop termination, simplifying the while rule[^1].
- **Practical use**: In exam problems, you will typically:
  1. Apply `wp` rules step-by-step to compute `wp(C, ψ)`.
  2. Prove `ϕ → wp(C, ψ)` (often a simple logical implication).
  3. For loops, verify the two side conditions.

---

**Exam Connection**: This chapter directly builds on Hoare logic. Remember the main theorem: `{ϕ}C{ψ} ⇔ ϕ → wp(C, ψ)`. The `wp` calculus gives a systematic way to find the necessary precondition, eliminating the need for clever guessing in Hoare proofs. Practice computing `wp` for sequences and conditionals, and understand how loop invariants plug into the process.

[^1]: [Weakest precondition](document-24.pdf) (100%)
