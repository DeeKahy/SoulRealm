### **Side 1: Presentation Core (4 Minutes) – White-Box Testing**

**1. Definition & Goal**
- **White-box (structural) testing:** Designs test cases based on the program's *internal structure* (the "how").
- **Goal:** Achieve specific **coverage criteria** by exercising code elements (statements, branches, conditions).

**2. Foundation: Control-Flow Graph (CFG)**
- Visual model of all execution paths.
- **Nodes:** Basic blocks (statements/decisions).
- **Edges:** Control flow between nodes.
- **Key principle:** Coverage measures executed code, not test quality. High coverage ≠ bug-free, but low coverage indicates untested code.

**3. Basic Coverage Criteria Hierarchy**
Strength increases: **Statement ⊂ Branch ⊂ Condition**.

| Criterion | Definition | Example Requirement |
| :--- | :--- | :--- |
| **Statement** | Execute every statement at least once. | 1 test for straight-line code. |
| **Branch** | Execute every branch (true/false) of each decision. | 2 tests per `if`. |
| **Condition** | Each atomic condition evaluates to true and false. | 2 tests per condition (e.g., `x>0`). |

**4. Illustrated Example**
```c
int example(int x, int y) {
    int z = 0;               // Stmt 1
    if (x > 0 && y > 0) {    // Decision
        z = x;               // Stmt 2
    }
    return z;                // Stmt 3
}
```
**Coverage Demonstration:**
- **Statement:** `example(1,1)` covers all 3 statements.
- **Branch:** Need `example(1,1)` (true) and `example(0,1)` (false).
- **Condition:** Need tests for:
    - `x>0=T, y>0=T` → `example(1,1)`
    - `x>0=F, y>0=T` → `example(0,1)` (short-circuit)
    - `x>0=T, y>0=F` → `example(1,0)`.

**Conclusion:** White-box tests the implementation; use with black-box for comprehensive testing.

---

### **Side 2: Advanced Topics & Discussion Points**

**Advanced Coverage Criteria**
- **MC/DC (Modified Condition/Decision Coverage):** For critical systems. Each condition must **independently affect** the decision outcome. *Example:* `a AND (b OR c)` needs 4 tests (vs. 8 for full condition coverage).
- **Path Coverage:** Execute all paths; **infeasible** with loops.
- **Basis-Path Coverage:** Cover linearly independent paths. Number of paths = **cyclomatic complexity**.

**Cyclomatic Complexity**
- **Formula:** $V(G) = E - N + 2$ ($E$=edges, $N$=nodes in CFG).
- **Interpretation:** Number of basis paths; a complexity metric.

**Comparison of Criteria**
| Criterion | Test Cases | Strength | Practical Use |
| :--- | :--- | :--- | :--- |
| **Statement** | Minimal | Weak | Baseline |
| **Branch** | ~2× statement | Moderate | Industry standard |
| **Condition** | $2^n$ ($n$ conditions) | Strong | Thorough |
| **MC/DC** | $n+1$ ($n$ conditions) | Very Strong | Critical systems |
| **Path** | Infinite (with loops) | Strongest | Theoretical |

**Critical Insights**
- **Coverage ≠ Quality:** 100% coverage only shows executed code, not thorough testing.
- **Empirical Finding:** High coverage doesn’t guarantee low fault rate.
- **Goodhart’s Law:** “When a metric becomes a target, it ceases to be a good metric.”
- **Why Remove Dead Code?**
    1. Reduces complexity and maintenance cost.
    2. Eliminates potential security vulnerabilities.
- **Best Practices:**
    1. Use coverage to **find untested code**, not as a sole target.
    2. **Combine white-box with black-box** testing.
    3. Focus on **meaningful test cases**.

**Prepared Example for Discussion**
```c
int foo(int x, int y) {
    z = x + y;
    w = 0;
    if ((y > 0) && (z > 0)) { w = 1; }
    if (x > 0) { z = 0; }
    return w;
}
```
**Test Suites:**
- **Statement:** `[(1, 1), 1]`
- **Branch:** `[(1, 1), 1]; [(-1, 1), 0]`
- **Condition:** `[(1, 1), 1]; [(-1, 1), 0]; [(1, -1), 0]`
- **MC/DC:** `[(1, 1), 1]; [(-1, 2), 1]; [(-1, 1), 0]; [(1, -1), 0]`

**Discussion Preparation:**
- **Compare with Black-box:** White-box tests *implementation*, black-box tests *specification*.
- **Explain MC/DC:** Demonstrate "independent effect" with a truth table.
- **Discuss Complexity:** Explain $V(G)=E-N+2$ and its meaning.
- **Effectiveness:** Coverage correlates with fault detection only up to a point; beyond that, test case quality matters more.