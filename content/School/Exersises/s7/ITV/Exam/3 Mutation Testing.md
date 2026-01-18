**Mutation Testing**: White-box method to assess test suite quality by creating small syntactic variants (**mutants**) of the program.

**Goal**: Estimate test effectiveness and potential faults. It does **not** verify correctness.

**Key Terms**:
- **Killed Mutant**: Test fails → mutant detected
- **Live Mutant**: All tests pass → weakness or equivalent
- **Equivalent Mutant**: Behaves identically to original (undecidable problem)

---

### 2. Example & Score Calculation

**Original Program:**
```java
int foo(int x, int y) {
    z = x + y;
    w = 0;
    if ((y > 0) && (z > 0)) {   // ← Line 4 (mutation target)
        w = 1;
    }
    return w;
}
```

**Test Suite (MC/DC coverage):**

| Input (x, y) | Expected Output |
|--------------|-----------------|
| (1, 1)       | 1               |
| (-1, 2)      | 1               |
| (-1, 1)      | 0               |
| (1, -1)      | 0               |

**First-Order Mutants for Line 4:**

| #   | Mutated Line 4                | Change Type | Result                      |
| --- | ----------------------------- | ----------- | --------------------------- |
| 1   | `if ((y > 0) `\|\|` (z > 0))` | `&&` → \|\| | **Killed** by test 3 (-1,1) |
| 2   | `if ((y >= 0) && (z > 0))`    | `>` → `>=`  | Live                        |

**Is Mutant 2 equivalent?** No! Counterexample: `(1, 0)` → original returns 0, mutant returns 1.

**Mutation Score:**
$$
\text{Score} = \frac{M_k}{M_t - M_e} = \frac{3}{5 - 0} = 0.6 \text{ (60\%)}
$$

---

### 3. Strengths & Limitations

| ✅ Strengths | ❌ Limitations |
|-------------|---------------|
| Quantitative measure of test quality | High computational cost |
| Based on fault coupling theory | Equivalent mutant problem (undecidable) |
| Reveals test suite weaknesses | Many mutants to generate/run |

```c
// Original
int max(int a, int b) {
    if (a > b) {
        return a;
    }
    return b;
}
```

```c
// Mutant: change ">" to ">="
int max(int a, int b) {
    if (a >= b) {      // ← mutated
        return a;
    }
    return b;
}
```


