- Also called **structural** or **code-based** testing.
- Designs test cases based on the program's **internal structure** (the "how"), not just its specification.
- Foundation: **Control-Flow Graph (CFG)** – a graph where nodes are statements/basic blocks and edges represent control flow.
### **2. Basic Coverage Criteria**
Coverage measures what code is executed by a test suite. Criteria form a hierarchy: **Statement ⊂ Branch ⊂ Condition**.

| Criterion              | Goal                                                                                                   | Key Point                                                               |
| :--------------------- | :----------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------- |
| **Statement Coverage** | Execute every statement at least once.                                                             | One test may suffice for straight-line code.                            |
| **Branch Coverage**    | Execute every **true/false branch** of each decision.                                              | Requires ~2 tests per `if`. Stronger than statement coverage.           |
| **Condition Coverage** | Each **atomic Boolean condition** (e.g., `x>0`) evaluates to **true** and **false** at least once. | With short-circuit evaluation, it can be stronger than branch coverage. |
### **3. Illustrative Example**
```c
int example(int x, int y) {
    int z = 0;               // Stmt 1
    if (x > 0 && y > 0) {    // Decision with two conditions
        z = x;               // Stmt 2
    }
    return z;                // Stmt 3
}
```
**Coverage demonstration:**
- **Statement:** `example(1,1)` executes all 3 statements.
- **Branch:** Need `example(1,1)` (true branch) and `example(0,1)` (false branch).
- **Condition:** Need tests for:
    - `x>0=F, y>0=T` → `example(0,1)` (short-circuits)
    - `x>0=T, y>0=T` → `example(1,1)` (Not required if we dont have short circuit)
    - `x>0=T, y>0=F` → `example(1,0)`.
### **1. Advanced Coverage Criteria**
- **MC/DC (Modified Condition/Decision Coverage):** Required for safety-critical software (e.g., DO-178C).
    - Needs **statement**, **branch**, and **condition** coverage.
    - Plus: Each condition must **independently affect** the decision's outcome.
    - Example: For `a AND (b OR c)`, 4 tests suffice (vs. 8 for full condition combination).
- **Path Coverage:** Execute all CFG paths. **Generally impossible with loops** – motivates approximations.
- **Basis-Path Coverage:** Cover a finite set of **linearly independent paths**. Number of basis paths = **cyclomatic complexity**.

### **2. Cyclomatic Complexity**
- **Formula:** $V(G) = E - N + 2$ (where $E$=edges, $N$=nodes in CFG).
- **Interpretation:** Measures the number of basis paths; a higher value indicates more complex control flow.

### **3. Data-Flow Testing Concepts (Brief)**
- **DEF(v, n):** Node `n` defines (writes) variable `v`.
- **USE(v, n):** Node `n` uses (reads) `v`.
- **DU-path:** A path from a DEF to a USE of the same variable.
- **DC-path:** A DU-path with **no intervening DEF** of that variable.
- **Slicing:** Isolating program parts relevant to a specific variable at a point. E.g., a **backward slice** finds all nodes contributing to a variable's value.
### **6. Comparison of Criteria**
| Criterion     | Typical # Tests       | Strength    | Practical Use           |
| :------------ | :-------------------- | :---------- | :---------------------- |
| **Statement** | Minimal               | Weak        | Baseline                |
| **Branch**    | ~2× statement         | Moderate    | Industry standard       |
| **Condition** | $2^n$ (n conditions)  | Strong      | Thorough                |
| **MC/DC**     | $n+1$ (n conditions)  | Very Strong | Safety-critical systems |
| **Path**      | Infinite (with loops) | Strongest   | Theoretical ideal       |
