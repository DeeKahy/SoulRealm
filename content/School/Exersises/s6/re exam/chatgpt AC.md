Here’s a structured **exam preparation guide** for your oral re-exam, covering all 9 topics (6 A-topics and 3 C-topics) with key points, example algorithms, and suggested order of presentation.  

---

Here’s a refined **Dynamic Programming (DP)** breakdown using the **Fibonacci sequence** as the central example, with clear definitions, properties, and methods:

---

### **1. Dynamic Programming (A-Topic)**  
#### **Key Points**  
1. **Definition**:  
   - DP solves problems by breaking them into **overlapping subproblems**, storing solutions to avoid recomputation.  
   - **Example (Fibonacci)**:  
     - Naive recursion recalculates ```fib(2)``` multiple times for ```fib(5)```.  
     - DP stores ```fib(2)``` in a table after the first computation.  

2. **Properties**:  
   - **Optimal substructure**: Solution to a problem depends on solutions to subproblems.  
     - *Example*: ```fib(n) = fib(n-1) + fib(n-2)```.  
   - **Overlapping subproblems**: Subproblems recur many times.  
     - *Example*: ```fib(3)``` is needed for both ```fib(4)``` and ```fib(5)```.  

3. **Methods**:  
   - **Memoization (top-down)**:  
     - Recursive + cache (e.g., store ```fib(n)``` in a hash table).  
     ```python  
     memo = {}  
     def fib(n):  
         if n in memo: return memo[n]  
         if n <= 1: return n  
         memo[n] = fib(n-1) + fib(n-2)  
         return memo[n]  
     ```  
   - **Tabulation (bottom-up)**:  
     - Iterative + table (e.g., fill array from ```fib(0)``` to ```fib(n)```).  
     ```python  
     def fib(n):  
         dp = [0, 1] + [0]*(n-1)  
         for i in range(2, n+1):  
             dp[i] = dp[i-1] + dp[i-2]  
         return dp[n]  
     ```  

#### **Example: Fibonacci Sequence**  
- **Recurrence**:  
  $$  
  \text{fib}(n) = \begin{cases}  
  n & \text{if } n \leq 1, \\  
  \text{fib}(n-1) + \text{fib}(n-2) & \text{otherwise}.  
  \end{cases}  
  $$  
- **Walkthrough (n=5)**:  
  - **Naive recursion**: 15 calls (e.g., ```fib(2)``` computed 3 times).  
  - **DP (memoization)**: 9 calls (reuses cached results).  

#### **Presentation Order**  
1. **Define DP** (2 mins):  
   - "DP optimizes recursion by storing subproblem results. For Fibonacci, ```fib(5)``` needs ```fib(3)``` and ```fib(4)```, which in turn need ```fib(2)```—this is overlapping subproblems."  
   - Draw recursion tree for ```fib(5)``` to show redundancy.  

2. **Properties & Methods** (1 min):  
   - "Optimal substructure means ```fib(n)``` depends on ```fib(n-1)``` and ```fib(n-2)```. Overlapping subproblems let us cache results."  
   - Compare memoization (top-down) vs. tabulation (bottom-up) code snippets.  

3. **Example Walkthrough** (1 min):  
   - Compute ```fib(5)``` step-by-step using a table:  
     ```  
     dp = [0, 1, 1, 2, 3, 5]  
     ```  
   - Highlight how DP reduces time from $O(2^n)$ to $O(n)$.  

---

### **Why This Works for Exams**  
- **Simple Example**: Fibonacci is intuitive and shows DP’s core ideas.  
- **Visuals**: Draw recursion tree and table to explain redundancy and optimization.  
- **Code Snippets**: Demonstrate both methods (memorization/tabulation).  

Need adjustments? Let me know!



---

### **2. Greedy Algorithms (A-Topic)**  
**Key Points**:  
- **Definition**: Make locally optimal choices to reach global optimum.  
- **Properties**: Greedy-choice property, optimal substructure.  

**Example**:  
- **Activity Selection**:  
  - Sort by finish time, select non-overlapping activities.  
  - Time: $O(n \log n)$.  

**Presentation Order**:  
1. Define greedy algorithms and properties.  
2. Explain activity selection algorithm.  
3. Prove correctness (greedy stays ahead).  

---

### **3. Network Flow (A-Topic)**  
**Key Points**:  
- **Definitions**: Flow network, residual graph, augmenting path.  
- **Algorithms**:  
  - **Ford-Fulkerson**: Find augmenting paths in residual graph.  
  - **Edmonds-Karp**: BFS for shortest augmenting paths ($O(VE^2)$).  

**Example**:  
- Max-flow min-cut theorem: Value of max flow = capacity of min cut.  

**Presentation Order**:  
1. Define flow networks and key terms.  
2. Explain Ford-Fulkerson/Edmonds-Karp.  
3. Illustrate with a small graph (e.g., slide 21 example).  

---

### **4. External-Memory Algorithms (A-Topic)**  
**Key Points**:  
- **Goal**: Minimize I/O operations (block transfers).  
- **Example**:  
  - **Multiway Merge-Sort**:  
    - Divide into chunks, merge in passes.  
    - I/O complexity: $O(\frac{N}{B} \log_{\frac{M}{B}} \frac{N}{B})$.  

**Presentation Order**:  
1. Explain external-memory model (B, M parameters).  
2. Describe multiway merge-sort steps.  
3. Compare with main-memory merge-sort.  

---

### **5. Parallel Algorithms (A-Topic)**  
**Key Points**:  
- **Model**: PRAM or fork-join parallelism.  
- **Metrics**: Work ($T_1$), span ($T_\infty$), parallelism ($\frac{T_1}{T_\infty}$).  

**Example**:  
- **Parallel Merge-Sort**:  
  - Span: $O(\log^2 n)$.  

**Presentation Order**:  
1. Define work, span, parallelism.  
2. Explain parallel merge-sort.  
3. Analyze span vs. sequential merge-sort.  

---

### **6. Amortized Analysis (A-Topic)**  
**Key Points**:  
- **Goal**: Average cost per operation in worst-case sequences.  
- **Methods**: Aggregate, accounting, potential.  

**Example**:  
- **Dynamic Table**:  
  - Doubling strategy: $O(1)$ amortized insertion.  

**Presentation Order**:  
1. Define amortized analysis vs. average-case.  
2. Explain dynamic table resizing.  
3. Show accounting/potential method proofs.  

---

### **7. Formal Languages & Turing Machines (C-Topic)**  
**Key Points**:  
- **Turing Machines (TM)**: Deterministic/non-deterministic, multi-tape.  
- **Undecidability**: Halting problem (proof by contradiction).  

**Presentation Order**:  
1. Define TMs and variants.  
2. Explain Church-Turing thesis.  
3. Prove halting problem is undecidable.  

---

### **8. Computability & Reductions (C-Topic)**  
**Key Points**:  
- **Reductions**: Mapping reductions (e.g., Halting ≤ Acceptance).  
- **Rice’s Theorem**: Non-trivial semantic properties are undecidable.  

**Presentation Order**:  
1. Define computable vs. computably-enumerable.  
2. Explain reduction steps (Halting → Acceptance).  
3. State Rice’s theorem and implications.  

---

### **9. P vs. NP & NP-Completeness (C-Topic)**  
**Key Points**:  
- **Classes**: P (polynomial time), NP (verifiable in polynomial time).  
- **Reductions**: Polynomial-time reductions (e.g., 3-SAT ≤ Clique).  

**Presentation Order**:  
1. Define P, NP, NP-hard, NP-complete.  
2. Explain polynomial-time reductions.  
3. Example: Prove Clique is NP-complete.  

---

### **Exam Strategy**  
- **Primary Topic (4 mins)**:  
  - Start with definitions/principles (1 min).  
  - Present example algorithm (2 mins).  
  - Summarize key takeaways (1 min).  
- **Secondary Topic (6 mins Q&A)**:  
  - Answer concisely; link to definitions.  
  - Use blackboard for proofs/examples if needed.  

**Preparation Tips**:  
- Create 1-page cheat sheets per topic (bullet points only).  
- Rehearse timing (4 mins/presentation).  
- Practice proofs (e.g., greedy correctness, NP-completeness).  

Let me know if you’d like refined details for any topic!

