Hoare logic: formal system to **prove** program correctness instead of testing.

**Hoare Triple**: $\{φ\}C\{ψ\}$ — "If precondition $φ$ holds and $C$ terminates, then postcondition $ψ$ holds"

### 2. Validity (45 sec)
| Triple                     | Valid? | Why?                                           |
| -------------------------- | ------ | ---------------------------------------------- |
| $\{⊤\}$ `i+=1` $\{⊤\}$     | ✓      | True always holds                              |
| $\{⊥\}$ `i+=1` $\{⊥\}$     | ✓      | Precondition never satisfied → trivially valid |
| $\{i<n\}$ `i+=1` $\{i≤n\}$ | ✓      | $i<n$ then $i+1≤n$ ✓                           |
| $\{i<n\}$ `i+=1` $\{i<n\}$ | ✗      | Counterexample: $i=1,n=2$                      |

### 3. Core Rules (1.5 min)
**Assignment** (read backwards): $\{ψ[e/x]\}$ x := e $\{ψ\}$
- Ex: $\{?\}$ `x:=x+1` $\{x>5\}$ → substitute → $\{x>4\}$

**Sequence**: $\dfrac{\{φ\}C_1\{φ'\} \quad \{φ'\}C_2\{ψ\}}{\{φ\}C_1; C_2\{ψ\}}$

**While**: $\dfrac{\{θ ∧ b\}C_0\{θ\}}{\{θ\} \text{ while } b \text{ do } C_0 \{θ ∧ ¬b\}}$ — requires **loop invariant** $θ$

### 4. Loop Invariants (1 min)
Property that holds before and after every iteration: $\{θ ∧ b\} C_0 \{θ\}$

**Ex**: `while (i<n) {i+=1}` — Invariant $i≤n$? Check: $\{i<n ∧ i≤n\}$ `i+=1` $\{i≤n\}$ ✓

Finding good invariants is the hard part — must be strong enough for postcondition!

### 5. Properties (15 sec)
- **Sound**: derivable → valid ✓
- **Not complete**: some valid triples not derivable (undecidable)
- **Relatively complete** (Cook '74): complete if invariants expressible & side conditions provable

---
### All Rules (System H)
| Rule | Form |
|------|------|
| **Skip** | $\{φ\}$ skip $\{φ\}$ |
| **Assign** | $\{ψ[e/x]\}$ x := e $\{ψ\}$ |
| **Seq** | $\dfrac{\{φ\}C_1\{φ'\} \quad \{φ'\}C_2\{ψ\}}{\{φ\}C_1; C_2\{ψ\}}$ |
| **Cond** | $\dfrac{\{φ ∧ b\}C_1\{ψ\} \quad \{φ ∧ ¬b\}C_2\{ψ\}}{\{φ\} \text{ if } b \text{ then } C_1 \text{ else } C_2 \{ψ\}}$ |
| **While** | $\dfrac{\{θ ∧ b\}C_0\{θ\}}{\{θ\} \text{ while } b \text{ do } C_0 \{θ ∧ ¬b\}}$ |
| **Conseq** | $\dfrac{\{φ\}C\{ψ\}}{\{φ'\}C\{ψ'\}}$ if $φ' → φ$ and $ψ → ψ'$ |

### Factorial Example
```
{n ≥ 0}  f := 1; i := 1;
while i ≤ n do ⟨f = fact(i-1) ∧ 1 ≤ i ≤ n+1⟩
  { f := f·i; i := i+1 }
{f = fact(n)}
```

### Key Definitions
- **Valid**: $∀s,s'$: if $⟦φ⟧(s)=T$ and $(C,s) \leadsto s'$ then $⟦ψ⟧(s')=T$
- **Auxiliary vars**: in $φ$/$ψ$ but not in $C$ (e.g., $x_0$ for initial value)
- **Loop unfolding**: while $b$ do $C$ $≡$ if $b$ then $(C;$ while $b$ do $C)$ else skip

### Proof Strategy
1. Work bottom-up from conclusion
2. Assignments: substitute backwards into postcondition
3. While: identify invariant $θ$, show $\{θ∧b\}C_0\{θ\}$, conclude $\{θ\}$while$\{θ∧¬b\}$
4. Use consequence rule to bridge logical gaps
5. Verify side conditions ($φ'→φ$, $ψ→ψ'$)

### Common Invariant Patterns
- Counter bounds: $0 ≤ i ≤ n$
- Accumulator: $result = f(i)$ where $f$ is partial computation
- Relationship: $x·y = x_0·y_0$ (for multiplication by addition)