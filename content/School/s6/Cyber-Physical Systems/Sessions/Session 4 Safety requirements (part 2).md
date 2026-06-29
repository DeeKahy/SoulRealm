- We study requirements-based controller design.  
- We define safety monitors to express general safety properties.
- We analyze the computational complexity of the invariant verification problem.
- We study a symbolic search algorithm for the invariant verification problem.





## Exercise 1
![[Pasted image 20250604170524.png]]
![[Pasted image 20250608103322.png]]
![[Pasted image 20250608103910.png]]
![[Pasted image 20250608104452.png]]




Signal West = g
Signal East = g
Train West = a
Train East = a

---

Signal West = r
Signal East = g
Train West = a
Train East = b

-------------------

Signal West = r
Signal East = r
Train West = w
Train East = b

----


Signal West = r
Signal East = r
Train West = w
Train East = b

---

Signal West = g
Signal East = r
Train West = w
Train East = a


---

Signal West = g
Signal East = r
Train West = b
Train East = a



![[Pasted image 20250608111618.png]]



## Exercise 2
![[Pasted image 20250604170553.png]]
![[Pasted image 20250608115612.png]]


## Exercise 3
![[Pasted image 20250604170612.png]]



Init x = m ∧ y = 0 mode = Loop

   (mode = Loop ∧ x > 0 ∧ x' = x - 1 ∧ y' = y + n ∧ mode' = loop)
∨ (mode = Loop ∧ x = 0 ∧ x' = x ∧ y' = y ∧ mode' = stop)

So what's going on here is actually pretty simple.
![[Pasted image 20250608122750.png]]

more to be found at [[State machine to Symbolic language]]


## Exercise 4
![[Pasted image 20250604170650.png]]

A)



B)


