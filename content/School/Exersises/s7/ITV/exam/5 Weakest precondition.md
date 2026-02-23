---

## Weakest Precondition – Cheat Sheet (2 pages)

---
**Problem:** Given program $C$ and desired result $ψ$, what must be true *before* we run it?

**Answer:** Work **backwards**—"undo" each statement from the postcondition.

**The function:** $wp(C, ψ)$ = weakest precondition guaranteeing $ψ$ after $C$

**Core theorem:**
$$\{φ\}\,C\,\{ψ\} \text{ is valid} \iff φ → wp(C, ψ)$$

---

### 2. The Five Rules

| Rule           | Formula                                | How to say it                                                                      |
| -------------- | -------------------------------------- | ---------------------------------------------------------------------------------- |
| **skip**       | $wp(\texttt{skip}, ψ) = ψ$             | Does nothing → requirement unchanged                                               |
| **assignment** | $wp(x := e, ψ) = ψ[e/x]$               | You take the goal and undo the assignment in your head                             |
| **sequence**   | $wp(C_1;C_2, ψ) = wp(C_1, wp(C_2, ψ))$ | it is about chaining two statements together by finding an intermediate condition. |
| **if-else**    | $(b → wp(C_1,ψ)) ∧ (¬b → wp(C_2,ψ))$   | Both branches must reach the goal                                                  |
| **while**      | needs invariant $θ$                    | Can't compute automatically                                                        |

**Assignment example:** Goal $x > 5$, statement `x := x+1`  
→ Replace $x$ with $x+1$: $(x+1) > 5$ → $x > 4$

---

### 3. Worked Example

**Verify:** $\{x = 5\}$ `x := x+1; y := x*2` $\{y = 12\}$

| Step | Action | Result |
|------|--------|--------|
| Start | Postcondition | $y = 12$ |
| 1 | Undo `y := x*2`: replace $y$ with $x*2$ | $x = 6$ |
| 2 | Undo `x := x+1`: replace $x$ with $x+1$ | $x = 5$ |

**Check:** $x = 5 → x = 5$? ✓ Valid.

---

### 4. Loops (the tricky part) **Do not make an example**

Loops need a **human-supplied invariant** $θ$ (undecidable in general).

**Three conditions to verify:**

| Condition | Formula | Meaning |
|-----------|---------|---------|
| Initiation | $φ → θ$ | Invariant holds at start |
| Preservation | $\{θ ∧ b\}\,C_{\text{body}}\,\{θ\}$ | Loop body maintains it |
| Exit | $θ ∧ ¬b → ψ$ | Exiting gives postcondition |

---

### 5. Summary

| | |
|---|---|
| **What** | $wp(C,ψ)$ = weakest condition before $C$ to guarantee $ψ$ after |
| **How** | Substitute backwards through each statement |
| **Theorem** | $\{φ\}C\{ψ\}$ valid iff $φ → wp(C,ψ)$ |
| **Loops** | Need invariant; verify 3 conditions |
| **Benefit** | Automates Hoare logic for loop-free code |

---

**Quick answers:**
- *"Weakest"* = accepts the most starting states; any stronger precondition also works
- *"w.r.t."* = "with respect to"