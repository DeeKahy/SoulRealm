### **1. What are Parallel Algorithms? (1 min)**
- Parallel algorithms use **multiple processors** to solve a problem faster.
- Idea: **split the work into independent tasks** that can run at the same time.
- We can use the **fork–join model**:
    - **spawn** = create a parallel task
    - **sync** = wait for tasks to finish
_Key challenge: more processors doesn’t always mean faster — depends on how tasks are divided._
### **2. How Do We Measure Efficiency? (1 min)**
- **Work ($T_1$):** total number of operations (like runtime on one core).
- **Span ($T_\infty$):** longest chain of dependent tasks — the “critical path.”
- **Parallelism:** $\dfrac{T_1}{T_\infty}$ = maximum possible speedup.
 _Goal kinda: keep span small and balance work across processors._
### **3. Example: Parallel Fibonacci (1.5 min)**
```cpp
parallel_fib(n):
  if n <= 2: return 1
  else:
    x = spawn parallel_fib(n-1)
    y = parallel_fib(n-2)
    sync
    return x + y
```

- **Work:** $T_1(n) = O(2^n)$ (huge, exponential).
- **Span:** $T_\infty(n) = O(n)$ (linear).
- **Parallelism:** $\dfrac{2^n}{n}$ — looks amazing on paper.
But in practice: too much redundant work, so it’s inefficient.  (it prevents Memoization instead)
_This example just shows how span vs work can differ dramatically._
### **4. Example: Parallel Merge Sort (1.5–2 min)**
- **Idea:**    
    - Split the array into halves **in parallel**.
    - Recursively sort each half **in parallel**.
    - Merge results **in parallel**.
- **Work:** $O(n \log n)$ (same as regular merge sort).
- **Span:** $O(\log^2 n)$ (because merging takes $O(\log n)$ and happens at $\log n$ levels).
- **Parallelism:** $O!\left(\dfrac{n}{\log n}\right)$ → excellent for large inputs.
 Unlike Fibonacci, this one **actually scales well in practice**.
(Draw recursion tree splitting arrays, with arrows showing parallel merges.)
### **5. Wrap-Up (30 sec)**
- Parallel algorithms are about **reducing the span** so many processors can work together.
- Work is like _total effort_, span is like _bottleneck time_.
- Fibonacci shows _theory vs practice_; merge sort shows _the right balance_.
- In real systems, overhead from spawning too many tiny tasks must be managed — that’s where scheduling strategies come in.
