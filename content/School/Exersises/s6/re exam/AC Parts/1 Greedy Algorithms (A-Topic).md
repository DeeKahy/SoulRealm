
#### **Key Points**  
1. **Definition**:  
   - Makes **locally optimal choices** at each step to reach a global optimum.  
   - *"Pick the largest coin ≤ remaining amount, repeat."*  

2. **Properties**:  
   - **Greedy-choice property**: A global optimum can be reached by selecting local optima.  
   - **Optimal substructure**: Optimal solution contains optimal solutions to subproblems.  

3. **When It Works**:  
   - Canonical coin systems (e.g., EUR/USD: [1, 5, 10, 25]).  
   - *Example*: For amount **37¢**, greedy gives ```25 + 10 + 1 + 1``` (4 coins).  

4. **When It Fails**:  
   - Non-canonical systems (e.g., [1, 3, 4] for **6¢**):  
     - Greedy: ```4 + 1 + 1``` (3 coins).  
     - Optimal: ```3 + 3``` (2 coins).  

#### **Example: Coin Change Problem**  
- **Greedy Approach**:  
  ```python
  def greedy_coin_change(coins, amount):
      coins.sort(reverse=True)  # Sort descending
      result = []
      for coin in coins:
          while amount >= coin:
              result.append(coin)
              amount -= coin
      return result if amount == 0 else None  # No solution
  ```  
  - **Time**: $O(n \log n)$ (sorting dominates).  

- **Walkthrough**:  
  - **Input**: ```coins = [25, 10, 5, 1]```, ```amount = 37```.  
    - Steps:  
      1. Pick 25 → remaining = 12.  
      2. Pick 10 → remaining = 2.  
      3. Pick 1 → remaining = 1.  
      4. Pick 1 → remaining = 0.  
    - **Output**: ```[25, 10, 1, 1]``` (4 coins).  

  - **Non-Optimal Case**: ```coins = [4, 3, 1]```, ```amount = 6```.  
    - Greedy: ```[4, 1, 1]``` (3 coins).  
    - Optimal: ```[3, 3]``` (2 coins).  

#### **Why It Fails**  
- **Lack of "greedy-choice property"**: Largest coin (```4```) prevents reaching the optimal solution (```3+3```).  
- **Proof**: Show that no combination of ```4``` and ```1``` can match ```3+3```’s efficiency.  

#### **Presentation Order**  
1. **Define Greedy Algorithms** (1 min):  
   - *"Greedy algorithms make the best immediate choice. For coins, always pick the largest possible denomination first."*  
   - Show the EUR/USD example (```37¢```).  

2. **Algorithm & Example** (1.5 mins):  
   - Write the ```greedy_coin_change``` pseudocode.  
   - Walk through ```37¢``` step-by-step on the board.  

3. **Non-Optimal Case** (1.5 mins):  
   - Contrast ```[4, 3, 1]``` for ```6¢```:  
     - Draw the greedy vs. optimal solutions.  
   - *"Greedy fails here because the system isn’t ‘canonical’—it lacks the greedy-choice property."*  

4. **Key Takeaway** (1 min):  
   - *"Greedy is fast and works for many problems, but always verify if it’s optimal for your input space!"*  

---

### **Blackboard Example**  
1. Draw the coin systems:  
   - **Canonical**: ```[25, 10, 5, 1]``` → ```37¢ = 25 + 10 + 1 + 1```.  
   - **Non-Canonical**: ```[4, 3, 1]``` → ```6¢ = 4 + 1 + 1``` (greedy) vs ```3 + 3``` (optimal).  

2. Highlight the **greedy-choice property** with arrows:  
   - For ```[25,10,5,1]```, choosing 25 doesn’t block later optimal choices.  
   - For ```[4,3,1]```, choosing 4 forces suboptimal steps.  
