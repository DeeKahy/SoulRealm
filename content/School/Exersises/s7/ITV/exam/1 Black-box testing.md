Based on the lecture content and the exam format, here's how I would structure your **Black-box Testing (Chapter 2)** note sheet:

---

## **SIDE 1 (Front): Presentation Flow**

### **Header**

**Black-box testing (Ch. 2)** | Test based on specification only, no code access  
**Key terms:** test oracle, input domain, equivalence class, boundary value

### **Three Columns:**

#### **Column 1: CORE CONCEPTS**

- **Definition**: Testing without access to implementation
- **Test case** = (input, expected output)
- **Test oracle**: determines expected output
- **Input domain**: all possible inputs
- **4 main methods**:
    1. Special-value
    2. Random/Fuzzing
    3. Boundary-value
    4. Equivalence-class

#### **Column 2: KEY TECHNIQUES**

**Special-value testing:**

- Manual selection using domain knowledge
- Pick "interesting" inputs

**Random testing:**

- Generate random inputs
- Pro: automatic, unbiased
- Con: expensive, needs test oracle

**Boundary-value:**

- Test: min, min+1, nominal, max-1, max
- Robust: add min-1, max+1
- Single-fault (4n+1) vs worst-case (5ⁿ)

**Equivalence-class:**

- Partition inputs into classes
- Test one representative per class
- Weak vs strong (Cartesian product)

#### **Column 3: EXAMPLE - NextDate**

```
NextDate(d, m, y) → next day's date

Special-value test:
[(28,2,2023) → (1,3,2023)]  // non-leap
[(28,2,2020) → (29,2,2020)] // leap
[(31,12,2023) → (1,1,2024)] // year wrap

Equivalence classes:
D: {1-27}, {28}, {29}, {30}, {31}
M: {30-day}, {31-day}, {Dec}, {Feb}
Y: {leap}, {common}, {1900}, {2000}

Weak: 5 test cases
Strong: 5×4×4 = 80 test cases
```

### **Bottom Strip:**

**When to use:** Special-value (always) | Random (supplement) | Boundary (systematic) | Equiv-class (completeness)  
**Connects to:** Ch. 3-4 (white-box), Ch. 1 (test basics)

---

## **SIDE 2 (Back): Deep Reference**

### **Top-Left: FORMAL DEFINITIONS**

**Equivalence relation R:**

- Reflexive: ∀x: (x,x) ∈ R
- Symmetric: (x,y) ∈ R → (y,x) ∈ R
- Transitive: (x,y),(y,z) ∈ R → (x,z) ∈ R

**Equivalence class:** {y | (x,y) ∈ R}

**Test case counts:**

- Boundary single-fault: 4n+1
- Boundary worst-case: 5ⁿ
- Robust: 6n+1 / 7ⁿ

### **Top-Right: ADVANCED EXAMPLE**

**NextDate - Leap year rule:**

```julia
IsLeapYear(y) = 
  y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)
```

**Edge cases to test:**

- 2000: divisible by 400 → leap
- 1900: divisible by 100, not 400 → common
- 2020: divisible by 4, not 100 → leap
- 2023: not divisible by 4 → common

### **Bottom-Left: COMPARISON TABLE**

|Method|Writing|Execution|Automatic|Coverage|
|---|---|---|---|---|
|Special-value|Manual|Cheap|✗|Targeted|
|Random|Cheap|Expensive|✓|Broad|
|Boundary|Cheap|Moderate|✓|Systematic|
|Equiv-class|Moderate|Moderate|Partial|Complete|

**Combinations:**

- Boundary + Random: random nominal values
- Equiv-class + Random: sample from classes
- Edge testing = Boundary + Equiv-class

### **Bottom-Right: DISCUSSION POINTS**

**Common questions:**

- "Why not just test everything?" → infinite inputs
- "How choose equivalence classes?" → domain knowledge + spec
- "Test oracle problem?" → metamorphic testing (relationships)

**Pros:** Almost always applicable, finds typical faults  
**Cons:** Misses code-specific bugs, needs specification

**Metamorphic testing:** Test relationships between inputs  
Example: f(x) ≥ f(y) if x ≥ y (monotonic)

**Real-world tip:** Combine methods! Use special-value + random + one systematic method

**Limitations:**

- No guarantee to find all bugs
- Quality depends on specification quality
- Cannot test what spec doesn't specify

---

## **Tips for using this sheet:**

1. **During 4-min presentation:** Focus on SIDE 1, use the example to illustrate
2. **During discussion:** Flip to SIDE 2 for definitions and comparison table
3. **Practice path:** Start with definition → show 4 methods → NextDate example → when to use each
4. **If asked about theory:** Use formal definitions (top-left, back)
5. **If asked to compare:** Use comparison table (bottom-left, back)

The structure follows your exam format: concise presentation material on front, detailed reference material on back. Good luck!