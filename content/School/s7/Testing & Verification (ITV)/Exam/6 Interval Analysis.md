**Problem:** Track what values variables can take at each program point—but exact tracking is impossible.  
**Solution:** Use **intervals** $[a,b]$ to over-approximate. Always contains all real values, maybe more.  
**Trade-off:** Sound (no false negatives), but imprecise (may have false positives).

---

**Interval Arithmetic**

| Operation | Rule | Example |
|-----------|------|---------|
| Add | $[a,b] + [c,d] = [a+c, b+d]$ | $[1,3]+[2,5]=[3,8]$ |
| Subtract | $[a,b] - [c,d] = [a-d, b-c]$ | $[5,10]-[1,3]=[2,9]$ |
| Scalar | $p \cdot [c,d] = [pc, pd]$ (if $p≥0$) | $2·[3,5]=[6,10]$ |
| Multiply | $[\min,\max]$ of $\{ac,ad,bc,bd\}$ | $[1,2]·[3,4]=[3,8]$ |

**Fundamental theorem:** $\hat{f}(X_1,\ldots,X_n) \supseteq f(X_1,\ldots,X_n)$ — computed interval always contains true range.

---

**The Dependency Problem**

Interval arithmetic forgets that the same variable appears twice.

Example: $x ∈ [-1,1]$, compute $x - x$.  
- Real answer: always $0$  
- Interval: $[-1,1]-[-1,1] = [-2,2]$ ← over-approximation!

Rule: if each variable appears **once**, result is exact.

---

**Worked Example**

```
x := [2,5]; 
y := x+3; 
z := 2*y;
```
→ $x∈[2,5]$ → 
$y∈[5,8]$ → 
$z∈[10,16]$

---

**Conditionals** — analyse both branches, then **join** (union).

`if (x>0) then y:=x else y:=-x` with $x∈[-3,5]$:
- Then ($x>0$): $y∈[1,5]$
- Else ($x≤0$): $y∈[0,3]$
- Join: $y∈[0,5]$

---

**Loops & Widening** — loops can grow intervals forever. **Widening** forces convergence by jumping bounds to $±∞$ after a few iterations. Guarantees termination, loses precision.

---

**Summary** -- Possibly skip

| | |
|--|--|
| What | Track $[lo,hi]$ ranges through program |
| Why | Prove properties (no overflow, etc.) |
| Core | Sound (over-approximates), may be imprecise |
| Dependency | Same var twice → precision loss |
| Conditionals | Both branches → join |
| Loops | Widening → termination |

---

**Talking points**

- *"Why over-approximate?"* — Safety. May get false alarms, never miss real bugs.
- *"Downside?"* — Precision loss (dependency problem, wide loops).
- *"Where used?"* — Static analysers, compilers, safety-critical systems.