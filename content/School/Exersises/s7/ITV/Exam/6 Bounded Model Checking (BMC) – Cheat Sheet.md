### What is BMC?
**Goal:** Simulate a program from a set of states _symbolically_

| Program Structure | Paths | BMC Solution |
|-------------------|-------|--------------|
| Straight-line | 1 | Direct encoding |
| Branches | Finite | Direct encoding |
| Loops | **Infinite** | Bound to k iterations |

**Key:** Alarms are genuine (no false positives), but **incomplete** (may miss bugs needing >k iterations)

---

### Loop Unrolling Example (k=1)
**Original:** `f:=1; i:=1; while i≤n do {f:=f·i; i:=i+1}`

**Unrolled:** `f:=1; i:=1; if i≤n {f:=f·i; i:=i+1} else skip`

⚠️ Original postcondition may not hold after unrolling—only executions terminating in ≤k steps considered

---

### Safety Property Encoding
Counterexample of length k for property **Gp**:

$$I(s_0) \land \bigwedge_{i=0}^{k-1} T(s_i, s_{i+1}) \land \neg p(s_k)$$

- $I(s_0)$: initial state
- $T(s_i, s_{i+1})$: transition relation  
- $\neg p(s_k)$: final state violates property

**SAT → bug found | UNSAT → no bug up to k**

---

## Side 2: SSA Encoding & Summary

### Static Single Assignment (SSA)
- Every variable assigned **only once** (use indices: f₁, f₂, f₃...)
- **Negate postcondition** to detect violations

**SSA for factorial (k=1):**
```
n ≥ 0 ∧ f₁=1 ∧ i₁=1
∧ (i₁≤n → f₂=f₁·i₁ ∧ i₂=i₁+1) ∧ (i₁≤n → f₃=f₂ ∧ i₃=i₂)
∧ (i₁>n → f₃=f₁ ∧ i₃=i₁)
∧ ¬(i₃>n → f₃=fact(n))   ← negated!
```

---

### Strengths & Limitations

| ✓ Strengths | ✗ Limitations |
|-------------|---------------|
| Finds real bugs (sound) | Incomplete (only up to k) |
| SAT/SMT solvers optimized | Cannot prove correctness |
| Handles ∞ initial states (SMT) | Must choose bound k |
| Used in industry | Extensions needed: k-induction |

---

### Presentation Structure (4 min)
1. **Problem** (30s): Loops → infinite paths
2. **Solution** (1min): Unroll k times → finite paths
3. **Encoding** (1.5min): SSA + negate postcondition → SAT/SMT
4. **Pros/Cons** (1min): Real bugs found, but incomplete