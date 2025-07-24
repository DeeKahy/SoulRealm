
# MTCPS
The re-exam will be **oral** and across **all topics of the course**. You do not have to prepare a presentation.  
  
In the course we discussed different types of models. A central learning goal is that you are able to **explain how these models work** (i.e., describe a given model with the correct terminology, basic definitions, and explain the model's working and semantics in terms of executions). This should be the **main** priority for your preparations.  
  
Below we recall the topics of the course (together with the corresponding chapters in the book). The course consisted of three main parts. For each part, the first topic introduced the basic model for this part. We advise you to focus on these three topics in your preparations (marked with a star (*) below).  
  
# Synchronous Model

The synchronous model is a **discrete and synchronous model of reactive computation** where all components execute in a sequence of rounds. In each round, a reactive component:
1. Reads its inputs
2. Based on current state and inputs, computes outputs
3. Updates internal state


### Reactive vs Functional Components (both are part of the Synchronous model)
- **Functional component**: Produces outputs when supplied with inputs (stateless mapping)
- **Reactive component**: Maintains internal state and interacts continuously via inputs/outputs

### Component Structure
A synchronous reactive component C consists of:
- **I**: Finite set of typed input variables (defines input space Q^I)
- **O**: Finite set of typed output variables (defines output space Q^O) 
- **S**: Finite set of typed state variables (defines state space Q^S)
- **Init**: Initialization specifying initial values for state variables
- **React**: Reaction description defining component behavior

### Data Types allowed
- ```nat```: Natural numbers
- ```int```: Integers  
- ```real```: Real numbers
- ```bool```: Boolean values {0,1}
- Enumerated types: Finite symbolic constants (e.g., {on, off})

### Valuations and Expressions
- **Valuation**: Type-consistent assignment to all variables in a set
- **Expressions**: Constructed using variables, constants, and operations
  - Arithmetic: +, *, =, ≤
  - Logical: ¬ (negation), ∧ (conjunction), ∨ (disjunction), → (implication)

## Component Behavior

### Initialization
- Uses assignments: ```x := 0```
- Can use ```choose``` for non-deterministic initialization:
  - ```x := choose {0,1}``` (discrete choice)
  - ```x := choose {z | 0 ≤ z ≤ 2}``` (continuous range)
- **[Init]**: Set of all initial states consistent with initialization

### Reactions
- Notation: ```s --i/o--> t``` means "from state s, with input i, produce output o and transition to state t"
- **[React]**: Set of all possible reactions
- Reaction description uses:
  - Assignment statements: ```x := e```
  - Conditional statements: ```if b then stmt1 else stmt2```
  - Local variables for intermediate computation

### Executions
An execution of length k is a sequence:
```
s₀ --i₁/o₁--> s₁ --i₂/o₂--> s₂ --i₃/o₃--> s₃ ... sₖ₋₁ --iₖ/oₖ--> sₖ
```

Where:
- s₀ is an initial state
- Each transition is a valid reaction
- Sequence represents k rounds of execution

## Extended-State Machines

### Structure
- **Mode variable**: Implicit state variable over enumerated type
- **Additional state variables**: Augment the mode-based description
- **Mode-switches**: Edges between modes with guard conditions and updates

### Notation
- Circles represent modes
- Sourceless arrow indicates initial mode
- Edge annotations: ```Guard → Update``` or ```Guard?``` (no update) or just ```Update``` (always true guard)

### Example: Switch Component
- Modes: {off, on}
- Additional state: ```int x := 0```
- Behavior: Light switch with 10-round timeout in 'on' mode

## Key Properties

### Determinism vs Non-determinism
- **Deterministic**: Each state-input pair has exactly one reaction
- **Non-deterministic**: Multiple possible reactions from same state-input pair (using ```choose```)

### Completeness
- **Complete**: Every state-input pair has at least one reaction
- **Incomplete**: Some state-input pairs have no valid reactions (component "rejects" input)

### Synchronous Execution Model
- All components execute simultaneously in lock-step
- Global notion of time (rounds)
- Instantaneous reactions within each round
- Suitable for modeling digital circuits, embedded control systems

## Example: Delay Component
```
Input: bool in
Output: bool out  
State: bool x := 0

React: out := x; x := in
```

**Behavior**: Output current state value, then store input for next round
**Reactions**: 
- ```0 --0/0--> 0```
- ```0 --1/0--> 1``` 
- ```1 --0/1--> 0```
- ```1 --1/1--> 1```



- Safety requirements (Part 1, Chapter 3)  related too maybe [[Temporal Logic and Set-Builder Notation Reference]]

- Asynchronous model (Part 1, Chapter 4) 

- ***Timed model** (Part 2, Chapter 7)  
- Timed processes
- Buffers with bounded delays
- Multiple clocks
- Composition
- Timed-based protocols
- Timed automata
- Zone-based symbolic analysis




timed model of computation where processes are not tightly synchronized to execute in a sequence of rounds but rely on the global physical time to achieve a loose form of synchronization
![[Pasted image 20250723192034.png]]








- Real-time scheduling (Part 2, Chapter 8)  
- ***Continuous model** (Part 3, Chapter 6)  [[Session 10 Continuous Systems part 1]] and part 2
- Hybrid model (Part 3, Chapter 9)  




# AC

The re-exam will be oral.  
  

There are 9 exam topics, which approximately correspond to the 13 lectures.

    A: Greedy algorithms: general principles and an example algorithm.

Greedy algorithms do not always yield optimal solutions, but for many problems they do.



- _- What is the general structure of a greedy optimization algorithm?   
    - Which two properties have to be proven to prove that a greedy algorithm finds an optimal solution?   
    - What is the greedy-choice property?   
    
    - What is the greedy choice in the Huffman algorithm? **At each step, always select and merge the two nodes with the lowest frequencies.**
![[Pasted image 20250428091721.png]]



    A: Dynamic programming: general principles and an example algorithm.

    A: Network flow: definitions, Ford-Fulkerson method, and Edmonds-Karp algorithm.

    A: External-memory algorithms: general principles and the multiway merge-sort algorithm.

    A: Parallel algorithms: general principles and the parallel merge-sort algorithm.

    A: Amortized analysis: general principles, different methods, and the analysis of the dynamic table.

  

    C: Formal languages; deterministic, multi-tape, and nondeterministic Turing machines; Church-Turing thesis; halting problem and why it is not computable; closure properties.

    C: Computable and computably-enumerable languages; (mapping) reductions and how to use them to prove computability properties about languages; example reduction between halting problem and acceptance problem; Rice's theorem.

    C: Classes P and NP; closure properties; "P vs. NP" problem; polynomial-time reductions and how to use them to prove complexity properties about languages; NP-hardness and NP-completeness.   (Note that this list does **not** include the proof that SAT is NP-complete.)

  

First, you randomly select 2 (one A topic and one C topic) out of the exam topics. Then, you choose one topic as the primary topic and the other one as the secondary topic.

For the primary topic, you may give a 4-minute presentation to cover **basic concepts** (e.g., definitions) and **general principles** (e.g., algorithms) of the topic, and also a **concrete example** that explains how the general principles are used in the example.  You are expected to have prepared for all the topics before the exam, and there will be no separate preparation time once a topic has been selected. The presentation will be supplemented by questions from the examiners (ca. another 4 minutes). The presentation will not have slides, but you are allowed to use the blackboard/whiteboard. As material for the presentation, you are allowed to have a sheet with notes (maximum 1 page per topic). It is recommended that you have a list of items that you want to talk about, but be aware to not only read from your notes.

Then, the examiners will ask questions from the secondary topic (another 6 minutes).

Note that both topics are weighted equally and that there will be more questions about the secondary topic. So make sure to prepare well for both parts of the course.

  

To prepare yourself for the re-exam, we suggest that you:

Prepare a presentation for each topic that uses a **concrete example** to explain both **basic concepts** (e.g., definitions) and **general principles** (e.g., algorithms). Rehearse all presentation topics before the exam.

Go through the lecture slides (some of the questions will relate to the basic concepts presented in the slides).

Go through the exercises (some of the questions will relate to how you would address some of those exercises).