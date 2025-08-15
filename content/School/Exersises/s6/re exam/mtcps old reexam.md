


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



# Safety requirements 

(Part 1, Chapter 3)  related too maybe [[Temporal Logic and Set-Builder Notation Reference]]

# Asynchronous model (Part 1, Chapter 4) 

# ***Timed model** (Part 2, Chapter 7)  
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
A Continues model is basically where it uses the previous output as its own input to approximate a closer/better result.


# Hybrid model (Part 3, Chapter 9)  




