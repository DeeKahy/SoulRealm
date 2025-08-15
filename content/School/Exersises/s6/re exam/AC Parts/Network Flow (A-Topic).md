
#### **Key Definitions**  
1. **Flow Network**:  
   - Directed graph $G = (V, E)$ with:  
     - **Source ($s$)** and **sink ($t$)** nodes.  
     - **Capacity** $c(u,v) \geq 0$ for each edge $(u,v)$.  
     - **Flow** $f(u,v)$ satisfies:  
       - **Capacity constraint**: $0 \leq f(u,v) \leq c(u,v)$.  
       - **Flow conservation**: $\sum_{v \in V} f(v,u) = \sum_{v \in V} f(u,v)$ (except for $s$ and $t$).  

2. **Residual Graph ($G_f$)**:  
   - Graph with **residual capacities** $c_f(u,v) = c(u,v) - f(u,v)$.  
   - **Backward edges** allow "undoing" flow (critical for correctness).  

3. **Augmenting Path**:  
   - Path from $s$ to $t$ in $G_f$ with $c_f(u,v) > 0$ for all edges.  

4. **Max-Flow Min-Cut Theorem**:  
   - **Max flow** = **Min cut** (sum of capacities of edges leaving a cut $(S, T)$ where $s \in S$, $t \in T$).  

---

#### **Ford-Fulkerson Method**  
1. **Steps**:  
   - Initialize flow $f(u,v) = 0$ for all edges.  
   - While an augmenting path $p$ exists in $G_f$:  
     - Push flow equal to the **bottleneck capacity** of $p$.  
     - Update $G_f$ (forward edges decrease capacity, backward edges increase).  

2. **Example**:  
   - **Graph**:  
     ```
     s → A (3) → t (2)  
     s → B (2) → A (1) → t (1)  
     ```  
   - **Augmenting Path 1**: $s \rightarrow A \rightarrow t$ (flow = 2).  
   - **Augmenting Path 2**: $s \rightarrow B \rightarrow A \rightarrow t$ (flow = 1).  
   - **Max Flow**: 3.  

3. **Limitations**:  
   - **Non-polynomial time** if capacities are irrational.  
   - **Inefficient** with poor path choices (e.g., always picks longest path).  

---

#### **Edmonds-Karp Algorithm**  
1. **Optimization**:  
   - Uses **BFS** to find the **shortest** augmenting path in $G_f$.  
   - Guarantees $O(VE^2)$ time.  

2. **Why BFS?**  
   - Ensures each augmentation increases flow by at least 1 unit per edge.  
   - Limits the number of augmentations to $O(VE)$.  

3. **Example**:  
   - Same graph as above, but BFS picks shortest paths first:  
     - Path 1: $s \rightarrow A \rightarrow t$ (flow = 2).  
     - Path 2: $s \rightarrow B \rightarrow t$ (flow = 1).  

4. **Key Improvement**:  
   - No need to handle backward edges explicitly—BFS naturally explores them.  

---

#### **Presentation Order**  
1. **Definitions (1.5 mins)**:  
   - Draw a small flow network (e.g., 4 nodes).  
   - Highlight source, sink, capacities, and flow conservation.  

2. **Ford-Fulkerson (1.5 mins)**:  
   - Show residual graph updates on the board.  
   - *"Like pouring water through pipes, backtracking allows redistributing flow."*  

3. **Edmonds-Karp (1 min)**:  
   - Contrast with Ford-Fulkerson: *"BFS avoids inefficiency by always picking the shortest path."*  

4. **Max-Flow Min-Cut (1 min)**:  
   - Draw a cut and compute its capacity.  
   - *"Max flow equals min cut—this duality proves correctness."*  

---

### **Blackboard Example**  
1. **Graph**:  
   ```
   s → A (10) → t (7)  
   s → B (5) → A (3) → t (8)  
   ```  
2. **Ford-Fulkerson Steps**:  
   - Augmenting path: $s \rightarrow A \rightarrow t$ (flow = 7).  
   - Residual edge $A \rightarrow t$ disappears; $t \rightarrow A$ appears.  
   - Next path: $s \rightarrow B \rightarrow A \rightarrow t$ (flow = 3).  
3. **Edmonds-Karp**:  
   - BFS picks $s \rightarrow B \rightarrow t$ first (flow = 5), then $s \rightarrow A \rightarrow t$ (flow = 7).  

---

### **Why This Works for the Exam**  
- **Visual Proofs**: Drawing residual graphs and cuts clarifies abstract concepts.  
- **Critical Contrast**: Ford-Fulkerson vs. Edmonds-Karp highlights algorithmic trade-offs.  
- **Theoretical Guarantee**: Max-flow min-cut theorem ties it all together.  

Let me know if you’d like to emphasize specific parts!

