- We study the syntax and semantics of the asynchronous model.
- We see the construction of the parallel composition.
- We discuss the challenges with shared processes and mutual exclusion.

## Exercise 1
![[Pasted image 20250605100956.png]]

![[Pasted image 20250605102301.png]]
We have two output channels msg out1 and msg out2, and we have 1 input channel, msg in.

There is a single queue as state variable with the declaration who's initialization given by: `queue(msg) x := null`.

Lets go through it from start to finish.

You get a message in, that is then handled by the input task Ai which stores the messages arriving on the input channel in the queue x when it isnt full: `AI: NOT FULL(x) -> Enqueue(in, x)`

Then the output task is enabled since x is no longer empty. It takes x and removes it from the queue and then sends it to out1


## Exercise 2
![[Pasted image 20250605101506.png]]





## Exercise 3
![[Pasted image 20250605101519.png]]

![[Pasted image 20250609105615.png]]

![[Pasted image 20250609105509.png]]
![[Pasted image 20250609105544.png]]