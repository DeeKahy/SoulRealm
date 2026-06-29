

### **Step 1: Prove $HOLIDAY\_PLAN \in NP$**
A problem is in NP if a proposed solution can be verified in polynomial time. For $HOLIDAY\_PLAN$:  
- Given a candidate set $S \subseteq A$ of size $d$, we check:  
  1. **Constraints $C$:** For each $c \in C$, verify $S \cap c \neq \emptyset$.  
  2. **Forbidden pairs $P$:** For each $(a_i, a_j) \in P$, verify $\{a_i, a_j\} \not\subseteq S$.  
- Both checks run in $O(|C| \cdot \max_{c \in C} |c| + |P|)$, polynomial in the input size.  
**Conclusion:** $HOLIDAY\_PLAN \in NP$.

---

### **Step 2: Prove $HOLIDAY\_PLAN$ is NP-hard via 3SAT reduction**
We reduce **3SAT** (NP-complete) to $HOLIDAY\_PLAN$.

#### **Reduction Construction**
Given a 3-CNF formula $\phi$ with $n$ variables $x_1, \dots, x_n$ and $m$ clauses $c_1, \dots, c_m$, construct $(A, C, P, d)$ as:  
1. **Activities $A$:**  
   - For each variable $x_i$, create $\{x_i, \neg x_i\}$.  
   - Total: $|A| = 2n$.  

2. **Constraints $C$:**  
   - **Variable constraints:** Add $\{x_i, \neg x_i\}$ for each $x_i$ (force selection of at least one literal).  
   - **Clause constraints:** For each clause $c_j = (\ell_{j1} \lor \ell_{j2} \lor \ell_{j3})$, add $\{\ell_{j1}, \ell_{j2}, \ell_{j3}\}$.  

3. **Forbidden pairs $P$:**  
   - For each $x_i$, add $(x_i, \neg x_i)$ to $P$.  

4. **Days $d$:** Set $d = n$.  

#### **Correctness**
- **If $\phi$ is satisfiable:**  
  Let $\sigma$ be a satisfying assignment. Select $S = \{x_i \mid \sigma(x_i) = \text{True}\} \cup \{\neg x_i \mid \sigma(x_i) = \text{False}\}$.  
  - $|S| = n$, satisfying $d = n$.  
  - All variable constraints $\{x_i, \neg x_i\}$ are met.  
  - All clause constraints are met (since $\sigma$ satisfies $\phi$).  
  - No forbidden pairs $(x_i, \neg x_i)$ are violated.  

- **If $(A, C, P, d)$ has a solution $S$:**  
  Define $\sigma(x_i) = \text{True}$ if $x_i \in S$, else $\sigma(x_i) = \text{False}$.  
  - $\sigma$ is consistent (no $(x_i, \neg x_i) \in S$).  
  - $\sigma$ satisfies all clauses (since $S$ intersects every clause constraint).  

#### **Runtime**
The reduction constructs $O(n + m)$ constraints and $O(n)$ forbidden pairs, polynomial in $|\phi|$.  

---

### **Conclusion**
- $HOLIDAY\_PLAN$ is **NP-hard** because $3SAT \leq_p HOLIDAY\_PLAN$.  
- Since $HOLIDAY\_PLAN$ is in **NP** and **NP-hard**, it is **NP-complete**.  

