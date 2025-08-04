## ***Synchronous model** (Part 1, Chapter 2) 
TLDR:
The synchronous model is a **discrete and synchronous model of reactive computation** where all components execute in a sequence of rounds. In each round, a reactive component:
1. Reads its inputs
2. Based on current state and inputs, computes outputs
3. Updates internal state

![[Pasted image 20250804095200.png]]

### Notes from reading
A functional component produces outputs when supplied with inputs, and its behavior can be mathematically described using a mapping between input and output values. A reactive component, in contrast, maintains an internal state and interacts with other components via inputs and outputs in an ongoing manner.

![[Pasted image 20250804091027.png]]
This model basically returns 0 on the first run, and then on each subsiquent run it returns what the previous run put in.

![[Pasted image 20250804091816.png]]

#### Initialization
![[Pasted image 20250804092035.png]]
In this modified version, choose may return either 0 or 1; as a result, the initial value of the variable x may be either 0 or 1. Another example of initialization using the choose construct is the declaration.
![[Pasted image 20250804092150.png]]
This means that the variable x is real-valued, and its initial value can be any real number between 0 and 2.




#### Extended state machines and Mealy machines




## Safety requirements (Part 1, Chapter 3)  



## Asynchronous model (Part 1, Chapter 4)  



## ***Timed model** (Part 2, Chapter 7)  



## Real-time scheduling (Part 2, Chapter 8)  



## ***Continuous model** (Part 3, Chapter 6)  



## Hybrid model (Part 3, Chapter 9)


























