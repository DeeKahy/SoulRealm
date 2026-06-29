**Black-box testing** evaluates a system based only on its specification, without access to the internal implementation (the "black box"). The goal is to find discrepancies between the specification and the actual behavior.
**Key Concepts:** **Test Case:** An (input, expected output) pair. **Test Oracle:** The mechanism that determines the expected output for a test. **Input Domain:** The set of all possible inputs to the program.
### **2. The Four Main Methods**
Systematically explore the input domain using these strategies:
1.  **Special-Value Testing:** Manual selection of "interesting" inputs using domain knowledge.
    - *Example:* Testing the last day of February for leap years.
2.  **Random Testing / Fuzzing:** Automatic generation of random inputs.
    - *Pro:* Automatic, unbiased. *Con:* Needs an oracle, can be expensive.

3.  **Boundary-Value Analysis:** Tests at the edges of input domains (min, min+1, nominal, max-1, max).
    - *Systematic:* Catches typical "off-by-one" faults.
    - *Single-Fault Assumption:* 4n+1 test cases for n inputs.

4.  **Equivalence-Class Testing:** Partition the input domain into classes where inputs are expected to be treated identically; test one representative per class.
    - *Weak Testing:* One value per class.
    - *Strong Testing:* Cartesian product of all classes.

### **3. Illustrated Example: `NextDate` Function**
Function: `NextDate(day, month, year)` → next calendar date.

**Applying the methods:**
- **Special-Value:** `[(28,2,2023) → (1,3,2023)]` (non-leap year roll).
- **Equivalence Classes:**
    - Day (D): {1-27}, {28}, {29}, {30}, {31}
    - Month (M): {30-day}, {31-day}, {December}, {February}
    - Year (Y): {leap}, {common}, {1900}, {2000}
- **Test Counts:**
    - **Weak:** 5 test cases (one per day class).
    - **Strong:** 5 × 4 × 4 = **80** test cases (exhaustive combination).
    - This is far fewer than exhaustive input testing (31 * 12 * years).

**Presentation Flow:** Define → List 4 methods → Use `NextDate` to show Equivalence-Class → Conclude with test count efficiency.

### **Formal Definitions & Formulas** Side 2 (BACK)
- **Equivalence Relation `R`** (partitions input domain `S`):
    - Reflexive: ∀x∈S: (x,x)∈R
    - Symmetric: (x,y)∈R → (y,x)∈R
    - Transitive: (x,y)∈R ∧ (y,z)∈R → (x,z)∈R
- **Equivalence Class of x:** {y | (x,y) ∈ R}.

- **Boundary-Value Test Case Counts** for `n` inputs:
    - **Single-Fault (4n+1):** Assumes a fault relates to only one variable at a time.
    - **Worst-Case (5ⁿ):** Tests all combinations of min, min+1, nom, max-1, max.
    - **Robust:** Adds out-of-boundary values (min-1, max+1) → 6n+1 or 7ⁿ cases.
### **Method Comparison & When to Apply**
| Method | Effort to Write | Effort to Execute | Automatic? | Best For... |
| :--- | :--- | :--- | :--- | :--- |
| **Special-Value** | Moderate (needs knowledge) | Cheap | ✗ | **Always useful;** targeted, relevant tests. |
| **Random** | Cheap | Expensive (many runs) | ✓ | **Supplement;** broad, unbiased exploration. |
| **Boundary-Value** | Cheap | Moderate | ✓ (if boundaries known) | **Systematic** finding of "off-by-one" faults. |
| **Equivalence-Class** | Moderate (needs good relation) | Moderate | Partial | **Completeness;** avoiding redundancy. |
### **Discussion Points & Connections**
- **The Test Oracle Problem:** Automatic testing requires an oracle. A common compromise is "no crash" testing. **Metamorphic Testing** is a solution: test known *relationships* between outputs (e.g., `sin(x) ≈ sin(x + 2π)`).
==- **Why not test everything?** The input domain is often infinite or impractically large. These methods provide systematic, finite coverage.==
- **Pros of Black-Box:** Almost always applicable, helps understand the specification, finds typical specification-implementation mismatches.
- **Cons:** Cannot find code-specific bugs (e.g., missing logic paths), effectiveness depends on specification quality.
- **Real-World Tip:** **Combine methods.** Use special-value for critical cases, then one systematic method (boundary or equivalence-class) for coverage.
- **Connects to White-Box (Ch. 3-4):** Black-box tests are derived from specs; white-box tests are derived from code structure. They are complementary.


