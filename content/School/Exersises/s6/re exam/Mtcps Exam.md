![[Pasted image 20250804100403.png]]

## ***Synchronous model** (Part 1, Chapter 2) 
TLDR:
The synchronous model is a **discrete and synchronous model of reactive computation** where all components execute in a sequence of rounds. In each round, a reactive component:
1. Reads its inputs
2. Based on current state and inputs, computes outputs
3. Updates internal state

![[Pasted image 20250804095200.png]]
![[Pasted image 20250804104704.png]]

Mealie Machine example:
Here is an "algorithm" for making a mealie machine:  
1. Answer the following questions:  
- What is the set of states?  
- What are the inputs?  
- What are the outputs?  
- What is the initial state?  
  
2. With the answers to these questions, you create an automaton like this:  
- Each state gets a node.  
- Mark the initial state.  
- For each state s that can transition to a state t in one step, add an edge s -> t.  
- For each edge, write all possible input/output pairs corresponding to that transition.  
  
Now let's try it.  
  
1.  
- There are two Boolean state variables, so the set of states is {(0,0), (0,1), (1,0), (1,1)}.  
- I presume there is a single input in (not visible).  
- I presume there is a single output out (not visible).  
- The initial state is (0,0).  
  
2.  
- We draw four nodes.  
- Node (0,0) gets marked as initial.  
- I will not go through all edges. In each state, we can have two possible inputs (0 or 1), and the component is deterministic; so there should be two transitions from each state (i.e., 8 in total). The transitions from the initial state are (0,0) --0/0--> (0,1) and (0,0) --1/0--> (1,1).
![[Pasted image 20250806104900.png]]


#### Event triggered Component
![[Pasted image 20250806111251.png]]


Termonology:
- A Component = The entire box seen above.
	- Initialization = Top part of a Component
	- A Reaction ( React ) = A theoretical run scenario. example( 0 -- 1/0 --> 1 ) 
	- Reaction Description = Essentially the code in the bottom box.
		- Assignment Statement = `x := e`
		- Conditional Statement = `if b then stmt1 else stmt2`
		- Auxiliary Variables = Local temporary variables that are NOT states.
- Execution = the picture below
![[Pasted image 20250804130541.png]]
![[Pasted image 20250804124221.png]]
where
![[Pasted image 20250804130407.png]]
- Combinational component = the picture below
![[Pasted image 20250804144807.png]]
![[Pasted image 20250804144736.png]]
- stuttering reaction = If the input is absent in a round, then the componentispassive: theoutputisabsent, andthestatestaysunchanged. Such a reaction is called a stuttering reaction.
- latched = if there exists a state variable x such that in every reaction of the component, the value of the output variable y is the updated value of the state variable.





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


























