HP = The HaltingProblem


**HP ≤ somelang** (HP reduces to somelang)
- somelang is **at least as hard as HP**
- somelang **must be undecidable** (cannot be computable)


**HP ⇒ somelang** (somelang reduces to HP)  
- somelang is **at most as hard as HP**
- somelang **can be**: computable OR recursively enumerable (but undecidable)
- somelang **cannot be**: harder than HP (i.e., not recursively enumerable)

**computable ≤ somelang** (decidable languages reduce to somelang)
- somelang is **at least as hard as decidable languages**
- somelang **can be**: computable OR recursively enumerable OR not recursively enumerable
- No restrictions on somelang's computability class

**computable ⇒ somelang** (somelang reduces to decidable languages)
- somelang is **at most as hard as decidable languages**  
- somelang **must be computable/decidable**
- This is the strongest constraint - forces computability

## Key Principle
**If A ≤ B, then B is at least as hard as A**
- If B is solvable, then A is solvable
- If A is unsolvable, then B is unsolvable



![[Pasted image 20250410112603.png]]

![[Pasted image 20250602133426.png]]



If still confused look at [[selfstudy 3]]