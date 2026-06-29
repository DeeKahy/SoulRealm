**(0) Hook (10 seconds)**  
*Draw a simple graph with nodes ```s```, ```a```, ```b```, ```t``` and edges:*
- ```s → a``` (capacity 3)
- ```a → b``` (capacity 2)
- ```a → t``` (capacity 1)
- ```b → t``` (capacity 2)

"How much flow can we send from ```s``` to ```t``` without exceeding pipe capacities?"

---

**(1) First Greedy Attempt (25 seconds)**  
"Try path ```s → a → b → t```. Bottleneck capacity is 2. Push 2 units:  
- ```s→a = 2```  ```a→b = 2```  ```b→t = 2```  
Total flow = 2. But ```s→a``` has unused capacity (1 left), and ```a→t``` is unused. Can we improve?"

---

**(2) Residual Graph: The "Undo" Mechanism (30 seconds)**  
"For every unit of flow ```f``` sent along an edge, we create:  
- A **forward residual edge** with capacity ```cap - f```  
- A **backward residual edge** with capacity ```f``` (to reverse flow)"

*Draw residual graph for current flow (2 units along ```s→a→b→t```):*
- ```s→a```: cap 1 (3 - 2)
- ```a→b```: cap 0 (2 - 2) → add backward edge ```b→a``` with cap 2
- ```a→t```: cap 1 (1 - 0)
- ```b→t```: cap 0 (2 - 2) → add backward edge ```t→b``` with cap 2

"Backward edges let us 'undo' flow and redirect it."

---

**(3) Finding an Augmenting Path (30 seconds)**  
"Find a new path in the residual graph: ```s → b → a → t```.  
- Bottleneck: min(```s→b``` cap, ```b→a``` cap, ```a→t``` cap) = 1  
- Push 1 unit along this path:  
  - Reverse 1 unit from ```a→b``` (using ```b→a```)  
  - Send that unit directly ```a→t```"

*Update flow:* - ```s→a = 2 + 1 = 3```   - ```a→b = 2 - 1 = 1```  - ```a→t = 0 + 1 = 1```  - ```b→t = 2 + 0 = 2```  "New total flow = 3."

---

**(4) Proving Optimality with Min-Cut (15 seconds)**  
"Define a cut: partition nodes into ```S = {s, a}``` and ```T = {b, t}```.  
Edges crossing cut: ```a→t``` (cap 1) and ```b→t``` (cap 2).  
Cut capacity = 3. Since flow = cut capacity, it is optimal."

---

**(5) Algorithm Summary (10 seconds)**  
"Ford-Fulkerson repeatedly:  
1. Builds residual graph  
2. Finds augmenting path (e.g., with BFS → Edmonds-Karp, ```O(VE²)```)  
3. Pushes flow until no path exists"

---

#### **1-Page Summary (For Notes)**
- **Problem**: Max flow in capacitated directed graph.
- **Residual Graph**: Key to correcting flow. Contains:
  - Forward edges: remaining capacity
  - Backward edges: capacity to reverse flow
- **Augmenting Path**: Any ```s```-```t``` path in residual graph.
- **Algorithm**:
  - Start with zero flow.
  - While augmenting path exists:
    - Push flow equal to min residual capacity on path.
    - Update residual graph.
- **Termination**: Flow is maximal when no augmenting path exists.
- **Edmonds-Karp**: Uses BFS to find shortest augmenting path. Time: ```O(VE²)```.
- **Max-Flow Min-Cut**: Proof of correctness.
