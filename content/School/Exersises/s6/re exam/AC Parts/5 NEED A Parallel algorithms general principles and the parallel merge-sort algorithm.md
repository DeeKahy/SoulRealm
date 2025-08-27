#### **Key Points**  
1. **Definition**:  
   - Parallel algorithms use multiple processors to solve problems faster by dividing work.  
   - **Model**: Fork-join parallelism (spawn/sync for task parallelism).  

2. **Metrics**:  
   - **Work ($T_1$)**: Total operations done by all processors.  
   - **Span ($T_\infty$)**: Longest path in computation DAG (critical path).  
   - **Parallelism**: $\frac{T_1}{T_\infty}$ (max theoretical speedup).  

3. **Goals**:  
   - Minimize span to maximize parallelism.  
   - Balance load across processors.  

#### **Example: Parallel Fibonacci**  
- **Code**:  
  ```cpp
  parallel_fib(n):
    if n == 1 or n == 2:
        return 1
    else:
        x = spawn parallel_fib(n-1)  // Fork
        y = parallel_fib(n-2)
        sync                          // Join
        return x + y
  ```  
- **Work**: $T_1(n) = T_1(n-1) + T_1(n-2) + O(1) = O(2^n)$ (exponential).  
- **Span**: $T_\infty(n) = \max(T_\infty(n-1), T_\infty(n-2)) + O(1) = O(n)$ (linear).  
- **Parallelism**: $\frac{T_1}{T_\infty} = \frac{O(2^n)}{O(n)}$ (exponential but inefficient in practice).  

![[Pasted image 20250823161852.png]]  
*Computation DAG for ```parallel_fib(4)```. Dashed edges show spawn/sync dependencies.*  

#### **Example: Parallel Merge Sort**  
- **Strategy**:  
  - Recursively split array into subarrays (parallel).  
  - Merge sorted subarrays in parallel.  
- **Span**:  
  - $T_\infty(n) = T_\infty(n/2) + O(\log n)$ (for parallel merge) $= O(\log^2 n)$.  
- **Work**: $T_1(n) = O(n \log n)$ (same as sequential).  
- **Parallelism**: $\frac{O(n \log n)}{O(\log^2 n)} = O(\frac{n}{\log n})$.  

![[Pasted image 20250823162042.png]]  
*Parallel merge sort structure. Red arrows indicate parallel splits/spawns.*  

#### **Presentation Order**  
1. **Define Parallel Algorithms** (1 min):  
   - Show image ![[Pasted image 20250528101759.png]] to explain work/span/parallelism.  
   - *"Parallelism measures how much speedup we can achieve by using multiple cores."*  

2. **Example: Parallel Fibonacci** (1.5 mins):  
   - Use image ![[Pasted image 20250823161852.png]] to illustrate spawn/sync and DAG.  
   - *"Though work is exponential, span is linear, so parallelism is high but impractical for large n due to overhead."*  

3. **Example: Parallel Merge Sort** (1.5 mins):  
   - Use image ![[Pasted image 20250823162042.png]] to show divide/merge structure.  
   - *"Span is $O(\log^2 n)$, so parallelism is $O(n/\log n)$—efficient for large n."*  

4. **Conclusion** (0.5 mins):  
   - *"Parallel algorithms reduce span to leverage multiple cores, but overheads (e.g., task spawning) must be managed."*  

---

Let me know if you'd like this adapted for other topics!

