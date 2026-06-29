## 1. Computability vs. Complexity (30s)
- First, the difference:
    - **Computability** asks: _Can this problem be solved at all?_
    - **Complexity** asks: _If it can be solved, how much time or memory does it take?_
- Example: The halting problem isn’t even computable. But graph connectivity is computable — and we can ask how efficient the solution is.
## 2. Class **P** (40s)
- **P** is the class of problems that can be solved efficiently — in **polynomial time**.
- That just means the number of steps is at most some power of the input size, like _n²_ or _n³_, not something crazy like _2ⁿ_.
- Examples:
    - Graph connectivity (via BFS/DFS).
    - Regular languages, context-free languages.
- **Closure property:**  
    If problem A reduces to problem B in polynomial time, and B is in P, then A is also in P.  
    → This means P is stable under reductions.
## 3. Class **NP** (40s)
- **NP** problems may not be easy to _solve_, but solutions are easy to _check_.
- Another view: a “lucky guess” can be verified quickly.
- Examples:
    - 3-coloring a graph (guess the colors, then check all edges).
    - SAT (Boolean satisfiability): given a truth assignment, you can check it in linear time.
- Big point: **P ⊆ NP** (if you can solve it fast, you can also check it fast).
## 4. The **P vs NP** Question (40s)
- The million-dollar question: Is P = NP?
- If yes: everything that’s checkable fast is also solvable fast.  
    → This would break most modern encryption.
- If no: then there really are problems that are checkable fast but not solvable fast.
- We don’t know which is true.
## 5. Polynomial-Time Reductions (50s)
- Key tool in complexity theory.
- A **reduction** means: if I can solve problem B, then I can also solve problem A, just by transforming A into B in polynomial time.
- Think of it as a translator: solving one hard problem would automatically solve many others.
- Example idea: SAT reduces to Vertex Cover. So if Vertex Cover were easy, SAT would be easy too.
- Reductions let us **compare problem difficulty**.
## 6. NP-hardness and NP-completeness (50s)
- **NP-hard**: At least as hard as everything in NP. Doesn’t even have to be in NP itself.
- **NP-complete**: In NP _and_ NP-hard.  
    → These are the “hardest” problems in NP.
- **Key theorem**: If we ever find a polynomial-time algorithm for _one_ NP-complete problem, we prove P = NP, because all NP problems reduce to it.
## 7. Wrap-up (30s)
- **P**: efficiently solvable.
- **NP**: efficiently checkable.
- **Reductions**: our way of comparing difficulty.
- **NP-complete** problems: the front line of the P vs NP question.
- This is one of the biggest open questions in computer science, and why complexity theory matters.
