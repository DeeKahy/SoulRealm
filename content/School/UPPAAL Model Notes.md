
### UPPAAL Model Notes  

#### **Queries Explained**  
1. **```E<> (counter >= 70 && hit == 13)```**  
   - Checks if there exists *any path* where eventually:  
     - ```counter``` ≥ 70 (global tick counter)  
     - ```hit``` = 13 (worker's "hit" counter).  

2. **```A[] !(P1.Crit && P2.Crit)```**  
   - Ensures *for all paths*, P1 and P2 are **never simultaneously** in their critical sections (mutual exclusion).  

3. **```A[] not deadlock```**  
   - Verifies the system **never deadlocks** (always has an enabled transition).  

4. **```P1.Try --> P1.Crit```**  
   - Whenever P1 enters ```Try``` state, it **eventually reaches** ```Crit``` (liveness property).  

Also look at [[Temporal Logic and Set-Builder Notation Reference]] it is slightly related.

---

#### **Ticker Template**  
![[Pasted image 20250609131638.png]]  
**Declarations:**  
```c
clock c;        // Local clock  
int x = 0;      // Incremented every tick  
int y = 0;      // Incremented every tick  
int counter = 0; // Global tick counter  
```  
**Behavior:**  
- **Invariant:** ```c <= 1``` (forces transition when ```c=1```).  
- **Transition:** Triggered when ```c >= 1```:  
  - ```x := x + 1```, ```y := y + 1```, ```counter := counter + 1```  
  - **Reset:** ```c := 0``` (ensures continuous ticking).  
**Purpose:** Synchronizes global increments and resets ```c``` to avoid overflow.  (it is probably a stupid solution, but it works)

---

#### **Worker Template**  
![[Pasted image 20250609131842.png]]  
**Key Concepts:**  
- **Invariant:** Condition that **must hold** while in a location (e.g., ```x <= 10``` in ```id2```). Violation forces a transition.  
- **Guard:** Condition enabling a transition (e.g., ```y >= 1```). Acts like an ```if``` statement.  
- **Sync:** Not used here; processes run independently.  ==explain this better==
- **Update:** Code executed during a transition (e.g., ```y := 0, hit := hit + 1```).  

**Locations:**  
- **```id3``` (Initial):**  
  - Invariant: ```x <= 60 && y <= 4``` (limits ```x```/```y```).  
  - Loops if ```y >= 1``` → resets ```y```, increments ```hit```.  
  - Moves to ```id2``` if ```x >= 40``` → resets ```x```.  
- **```id2```:**  
  - Invariant: ```x <= 10```.  
  - Returns to ```id3``` if ```x >= 5``` → resets ```x``` and ```y```.  

---

#### **System Setup**  
```c
W = worker();   // Worker instance  
T = ticker();   // Ticker instance  
system W, T;    // Parallel composition  
```  
**Why:** Runs ```worker``` and ```ticker``` concurrently.  

---

#### **Location Properties**  
![[Pasted image 20250609132113.png]]  
- **Initial:** Starting state (e.g., ```id3``` for worker).  
- **Urgent:** Forces immediate transition if enabled (time cannot pass).  
- **Committed:** Halts time; **no other process** can act until transition is taken.  
*(Not used in this model.)*  
