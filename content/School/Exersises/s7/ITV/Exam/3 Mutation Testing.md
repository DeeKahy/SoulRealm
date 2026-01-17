
# Whitebox Testing: Mutation Testing
## Two-Sided A4 Cheat Sheet

---

### **Side 1: Core Concepts & Theory**

#### **1. Definition & Goal**
- **Mutation Testing**: A form of white-box testing where you test your test suite by creating syntactically modified versions of the program (mutants)[^1].
- **Primary Goal**: Estimate the quality of your test suite and how many faults might still be present; it does not directly verify implementation correctness[^1].

#### **2. Key Terminology**
- **Mutant**: A syntactically modified version of the original program[^1].
- **Killed Mutant**: A mutant that causes at least one previously passing test to fail[^1].
- **Live Mutant**: A mutant that does not cause any test to fail[^1].
- **Equivalent Mutant**: A live mutant that behaves identically to the original program for all possible inputs (a fundamental problem)[^1].

#### **3. Typical Mutations (First-Order)**
Small syntactic changes of established categories[^1]:
- **Operator Mutation**:
    - Logical connectors: `∧`, `∨`, `¬`
    - Relational operators: `=`, `≠`, `<`, `>`
    - Arithmetic operators: `+`, `-`, `*`
    - Replace numeric expression `e` by `abs(e)`
- **Constant Mutation**:
    - Replace by `0` or `null`
    - Add or subtract `1`
- **Variable Mutation**: Replace variable `x` by `y`
- **Statement Mutation**: Flip two statements

#### **4. Mutation Score**
Measures the effectiveness of your test suite[^1]:
- $M_k$ = number of killed mutants
- $M_t$ = total number of mutants
- $M_e$ = number of equivalent mutants
- **Formula**: $\text{Mutation Score} = \frac{M_k}{M_t - M_e}$ (assuming $M_t - M_e \neq 0$)

#### **5. The Equivalent Mutant Problem**
- A mutant can be live because: 1) the test suite is too weak, or 2) it is equivalent to the original program[^1].
- Detecting equivalent mutants is **undecidable** (fundamental problem of mutation testing)[^1].
- In practice, equivalence between mutants is often ignored as too difficult to compute[^1].

#### **6. Theoretical Foundations**
- **Competent Programmer Hypothesis**: Assumes the program is almost correct initially, so small syntactic deviations should produce different behavior[^1].
- **Coupling Effect**: Test data that detects all simple faults will also implicitly detect more complex faults[^1].

#### **7. Strong vs. Weak Mutation Testing**
- **Conditions to kill a mutant (RIP model)**[^1]:
    1. **R**each the mutated code.
    2. **I**nfect the program state (cause an incorrect intermediate state).
    3. **P**ropagate the infection to the output (cause observable failure).
- **Strong Mutation**: Requires demonstrating all three conditions (R, I, P)[^1].
- **Weak Mutation**: Only requires demonstrating reach and infect (R, I) – easier and cheaper to check[^1].

---

### **Side 2: Practical Application & Examples**

#### **1. Concrete Example: Program & Test Suite**
Consider the following program `foo` and its passing test suite that provides maximal MC/DC coverage[^2]:

```java
int foo(int x, int y) {
    z = x + y;
    w = 0;
    if ((y > 0) && (z > 0)) { // Line 4
        w = 1;
    }
    if (x > 0) {
        z = 0;
    }
    return w;
}
```

**Test Suite (Input `(x, y)`, Expected Output)**:
- `[(1, 1), 1]`
- `[(-1, 2), 1]`
- `[(-1, 1), 0]`
- `[(1, -1), 0]`

#### **2. First-Order Mutants for Line 4**
Consider these syntactic modifications to the condition in line 4[^2]:
1. `if ((y > 0) || (z > 0)) {` (Operator: `&&` → `||`)
2. `if ((y >= 0) && (z > 0)) {` (Relational: `>` → `>=`)
3. `if ((y > 0) && (z >= 0)) {` (Relational: `>` → `>=`)
4. `if ((y > 0) && (z < 0)) {` (Relational: `>` → `<`)
5. `if ((y > -1) && (z > 0)) {` (Constant: `0` → `-1`)

#### **3. Analysis: Which Mutants Are Killed?**
Using the given test suite[^2]:
- **Mutant (1)**: Killed by test `[(-1, 1), 0]` (fails).
- **Mutant (2)**: Live (all tests pass).
- **Mutant (3)**: Killed by test `[(-1, 1), 0]` (fails).
- **Mutant (4)**: Killed by tests `[(1, 1), 1]` and `[(-1, 2), 1]` (both fail).
- **Mutant (5)**: Live (all tests pass).

#### **4. Mutation Score Calculation**
- $M_k = 3$ (mutants 1, 3, 4 killed)
- $M_t = 5$ (total mutants)
- $M_e = 0$ (no equivalent mutants – see below)
- **Mutation Score** = $\frac{3}{5 - 0} = 0.6$ (60%)[^2]

**Checking for Equivalent Mutants**:
- Mutant (2) is **not equivalent**. Counterexample: `[(1, 0), 0]` passes original but fails mutant[^2].
- Mutant (5) is equivalent to mutant (2) (`y ≥ 0` ↔ `y > -1` for integers), but this inter-mutant equivalence is ignored in practice[^2].

#### **5. Connection to Other Approaches**
- **Model-Based Testing**: A hybrid of black-box and white-box testing using abstract models. It enables automatic test generation and can reason about deep faults, but requires modeling expertise and is expensive to set up[^3].
- **White-Box Context**: Mutation testing evaluates test suite adequacy after structural criteria (e.g., MC/DC) are met.

#### **6. Cost & Practical Considerations**
- **High Cost**: Many mutants to generate and test; typically applied automatically to units overnight[^1].
- **Use Case**: Not for every test run, but for assessing and improving test suite quality.
- **Tool Support**: Requires automation for mutant generation and execution.

#### **7. Quick Reference for Presentation**
1. **Definition & Goal (1 min)**: "Mutation testing evaluates test suite quality by creating small syntactic variants (mutants)."
2. **Core Method with Example (2 min)**: Show the `foo` program, mutants, and calculate mutation score on whiteboard.
3. **Strengths & Limitations (1 min)**:
    - *Strength*: Provides a quantitative measure of test effectiveness; based on fault coupling theory.
    - *Limitation*: Computationally expensive; equivalent mutant problem is undecidable.
    - *Context*: Often used after achieving structural coverage; relates to model-based testing for automation.

---
**Formatting Note**: This markdown is designed for clear two-sided A4 printing. Use `###` headings for major sections, `-` for bullet points, and `$` for LaTeX formulas. The concrete example provides material for whiteboard demonstration during your presentation.

[^1]: [Mutation testing](document-19.pdf) (70%)
[^2]: [Exercise sheet 6 with solution proposals](document-20.pdf) (20%)
[^3]: [Model-based testing](document-16.pdf) (10%)
