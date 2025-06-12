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


So to get it to work we changed pub to a broadcast channel because it needed to tell the timeout and the machine that it has been shown.


# Exercise 3
![[Pasted image 20250606101103.png]]

A)
![[Pasted image 20250609151120.png]]
Go to the link below to figure out what everything means.
[[Temporal Logic and Set-Builder Notation Reference#Property Classifications]]

Validation Properties:
- All succeed

Safety Properties:
1. Something bad CAN happen. IE they can try to go both at the same time. 
2. Passes

Liveness Properties:
1. It could take infinite time for a train to cross and thats probably bad.
2. same as 1
3. same as 1
4. same as 1

Deadlock:
1. it might deadlock and that is bad



B)
So whats going on here are 2 issues in the gate. in the code it pretends that we are 1 indexed, when in reality it is 0 indexed. So changing it from a 1 to a zero fixed it.

The other issue is that a transition can get stuck in the stop node (see image) if the stop node isnt urgent or committed. Since theoretically it is allowed to stay forever, ie allowing it to just straight up crash into the other train.
![[Pasted image 20250611145441.png]]


# Exercise 4
![[Pasted image 20250606101122.png]]

A)
![[Pasted image 20250609152835.png]]
Essentially we made this prompt and then just brute forced out number to the lowest we possibly could. There is probably a way to find it automatically, but this works.

B)
![[Pasted image 20250609153038.png]]
![[Pasted image 20250609153206.png]]

Same as before just brute force until you get a result that fails and succeeds with a difference of 1.



C)
![[Pasted image 20250609153038.png]]
![[Pasted image 20250609153600.png]]


