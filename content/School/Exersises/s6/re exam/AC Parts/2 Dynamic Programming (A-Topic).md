#### **Key Points**  
1. **Definition**:  
   - DP solves problems by breaking them into **overlapping subproblems**, storing solutions to avoid re-computation.  
   - **Example (Fibonacci)**:  
     - Naive recursion recalculates ```fib(3)``` multiple times for ```fib(5)```.  
     - DP stores ```fib(3)``` after the first computation.  

2. **Properties**:  
   - **Optimal substructure**: Solution depends on solutions to smaller subproblems.  
     - *Example*: ```fib(n) = fib(n-1) + fib(n-2)```.  
   - **Overlapping subproblems**: Identical subproblems recur.  
     - *Example*: ```fib(3)``` is needed for both ```fib(4)``` and ```fib(5)```.  

3. **Methods**:  
   - **Naive Recursion**:  
     - Exponential time ($O(2^n)$), hits recursion limit.  
     ```python
     def fib(n):
         if n == 1 or n == 2:
             return 1
         return fib(n-1) + fib(n-2)
     ```  

   - **Memoization (Top-Down)**:  
     - Cache results to avoid recomputation. Time: $O(n)$.  
     ```python
     def fib(n, memo={1: 1, 2: 1}):
         if n not in memo:
             memo[n] = fib(n-1, memo) + fib(n-2, memo)
         return memo[n]
     ```  

   - **Tabulation (Bottom-Up)**:  
     - Iterative, no recursion. Time: $O(n)$, Space: $O(n)$ (can optimize to $O(1)$).  
     ```python
     def fib(n):
         if n == 1 or n == 2:
             return 1
         bu = [0] * (n+1)
         bu[1], dp[2] = 1, 1
         for i in range(3, n+1):
             bu[i] = bu[i-1] + bu[i-2]
         return bu[n]
     ```  

#### **Example: Fibonacci Sequence**  
- **Recurrence**:  
  $$  
  \text{fib}(n) = \begin{cases}  
  1 & \text{if } n \leq 2, \\  
  \text{fib}(n-1) + \text{fib}(n-2) & \text{otherwise}.  
  \end{cases}  
  $$  
- **Walkthrough (n=5)**:  
  - **Naive**: 9 redundant calls (e.g., ```fib(2)``` computed 3 times).  
  - **DP (Memoization)**: 5 calls (no recomputation).  

#### **Presentation Order**  
1. **Define DP** (2 mins):  
   - *"DP avoids redundant calculations by storing subproblem results. For ```fib(5)```, overlapping calls to ```fib(3)``` are cached."*  
   - Draw recursion tree for ```fib(5)``` and highlight repeated calls.  

2. **Properties & Methods** (1 min):  
   - *"Optimal substructure means ```fib(n)``` builds on ```fib(n-1)``` and ```fib(n-2)```. Overlapping subproblems make caching efficient."*  
   - Show code snippets for all three methods side-by-side.  

3. **Example Walkthrough** (1 min):  
   - Tabulate ```fib(5)``` step-by-step:  
     ```
     dp = [0, 1, 1, 2, 3, 5]  
     ```  
   - *"DP reduces time from exponential ($O(2^n)$) to linear ($O(n)$)."* 