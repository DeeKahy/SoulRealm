# Hoare Logic & Hoare Calculus – Exam Notes (Two-Sided A4)

## 1. Hoare Triple: Definition & Meaning
- Notation: `{P} S {Q}`
- **Meaning**: If we start in a state where the precondition `P` holds, and execute statement `S`, then if `S` terminates, we end in a state where the postcondition `Q` holds.
- **Key point**: Validation is done *logically*, not by running the program. We reason backwards from the postcondition.

## 2. Validating a Hoare Triple (Assignment Example)
For an assignment `x = e`, we use the **assignment rule** backwards:
- Rule: `{Q[x/e]} x = e {Q}`
- To validate `{P} x = e {Q}`, we check if `P ⇒ Q[x/e]`.

**Example**: `{x = 0} x = x + 1 {x > 0}`
- Apply assignment rule: `{ (x > 0)[x/(x+1)] } x = x + 1 {x > 0}` → `{x+1 > 0} x = x + 1 {x > 0}`
- Check: Does `x = 0` imply `x+1 > 0`? Yes (since `0+1 = 1 > 0`).
- Therefore, the triple is valid.

## 3. Key Rules of Hoare Calculus
### Assignment Rule
`{Q[x/e]} x = e {Q}`

### Precondition Strengthening
If `P' ⇒ P` and `{P} S {Q}`, then `{P'} S {Q}`.
- We can replace the precondition with a *stronger* one (i.e., one that implies the original).

### Postcondition Weakening
If `{P} S {Q}` and `Q ⇒ Q'`, then `{P} S {Q'}`.
- We can replace the postcondition with a *weaker* one (i.e., one that is implied by the original).

### Sequencing
If `{P} S1 {R}` and `{R} S2 {Q}`, then `{P} S1; S2 {Q}`.

### Conditionals
If `{P ∧ b} S1 {Q}` and `{P ∧ ¬b} S2 {Q}`, then `{P} if b then S1 else S2 {Q}`.

### While Loops
If `{P ∧ b} S {P}`, then `{P} while b do S {P ∧ ¬b}` (where `P` is the loop invariant).

## 4. Formal Proof Example (From Video Script)
**Goal**: Prove `{x ≥ 0} x = x + 1 {x > 0}`.

### Proof Method 1 (Using Assignment Backwards)
1. **Assignment Rule**:
   - Start with postcondition `x > 0` and assignment `x = x+1`.
   - Rule gives: `{x+1 > 0} x = x + 1 {x > 0}`.
2. **Logic Step**:
   - Show `x ≥ 0 ⇒ x+1 > 0`: If `x ≥ 0`, then `x+1 ≥ 1 > 0`.
3. **Precondition Strengthening**:
   - Since `x ≥ 0 ⇒ x+1 > 0`, we can strengthen the precondition from `x+1 > 0` to `x ≥ 0`.
   - Result: `{x ≥ 0} x = x + 1 {x > 0}`.

### Proof Method 2 (Using Precondition Strengthening & Postcondition Weakening)
1. **Assignment Rule** (with a different postcondition):
   - Choose postcondition `x ≥ 1`. Then `{ (x ≥ 1)[x/(x+1)] } x = x + 1 {x ≥ 1}` → `{x+1 ≥ 1} x = x + 1 {x ≥ 1}`.
2. **Precondition Strengthening**:
   - `x ≥ 0 ⇒ x+1 ≥ 1` (since adding 1 to both sides preserves inequality).
   - So, `{x ≥ 0} x = x + 1 {x ≥ 1}`.
3. **Postcondition Weakening**:
   - `x ≥ 1 ⇒ x > 0` (any number ≥1 is >0).
   - Thus, `{x ≥ 0} x = x + 1 {x > 0}`.

## 5. Important Concepts
- **Precondition Strengthening**: Valid because starting in a state that satisfies a stronger condition guarantees the original precondition.
- **Postcondition Weakening**: Valid because if we end in a state satisfying the original postcondition, any weaker condition is also satisfied.
- **Do NOT mix up**:
  - *Weakening the precondition* is invalid (starting with a weaker condition may not satisfy the original precondition).
  - *Strengthening the postcondition* is invalid (ending state may not satisfy the stronger condition).

## 6. Connection to Weakest Precondition (Next Chapter)
- The **weakest precondition** `wp(S, Q)` is the weakest condition `P` such that `{P} S {Q}` holds.
- It is computed systematically using Hoare rules:
  - Assignment: `wp(x = e, Q) = Q[x/e]`
  - Sequencing: `wp(S1; S2, Q) = wp(S1, wp(S2, Q))`
  - Conditionals: `wp(if b then S1 else S2, Q) = (b ⇒ wp(S1, Q)) ∧ (¬b ⇒ wp(S2, Q))`
- Weakest precondition calculus builds on Hoare logic, using precondition strengthening and postcondition weakening to derive the minimal required precondition.

---

**Note for Exam**: You may be asked to prove a Hoare triple using these rules. Practice with simple assignments and conditionals. Remember to always reason backwards from the postcondition and use the rules step-by-step.