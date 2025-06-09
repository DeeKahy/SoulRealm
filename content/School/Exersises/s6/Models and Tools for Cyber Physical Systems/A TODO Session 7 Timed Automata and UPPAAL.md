- We will formally define Timed Automata. 
- We will give a detailed presentation of the modelling and specification formalism of UPPAAL  
                    - We will see example of a Train Gate covering
- We will detail the UPPAAL verification engine. 
- We will detail  the UPPAAL verification options.

# Exercise 1
![[Pasted image 20250606101032.png]]


Essentially we just use uppaal to check if any of those states are reachable.
![[Pasted image 20250609141237.png]]



you can also look at the last part of [[Session 6 Timed model]]




# Exercise 2
![[Pasted image 20250606101049.png]]


there must be a mistake in this somewhere. Either the human doesnt simulate properly or whatever they are asking is literally impossible, because it can take the bad transition whenever.


# Exercise 3
![[Pasted image 20250606101103.png]]

A)
![[Pasted image 20250609151120.png]]
Go to the link below to figure out what everything means.
[[Temporal Logic and Set-Builder Notation Reference#Property Classifications]]

Validation Properties:
- All succeed

Safety Properties:
1. idk
2. Passes

Liveness Properties:
1. It could take infinite time for a train to cross and thats probably bad.
2. same as 1
3. same as 1
4. same as 1

Deadlock:
1. it might deadlock and that is bad
# Exercise 4
![[Pasted image 20250606101122.png]]
