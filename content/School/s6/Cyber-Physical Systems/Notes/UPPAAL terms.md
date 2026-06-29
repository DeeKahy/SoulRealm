
# Timed Automata in Uppaal

The Uppaal modelling language extends timed automata with the following additional features:

• **Templates** - automata are defined with a set of parameters that can be of any type (e.g., int, chan). These parameters are substituted for a given argument in the process declaration.

• **Constants** - are declared as ```const name value```. Constants by definition cannot be modified and must have an integer value.

• **Bounded integer variables** - are declared as ```int[min,max] name```, where min and max are the lower and upper bound, respectively. Guards, invariants, and assignments may contain expressions ranging over bounded integer variables. The bounds are checked upon verification and violating a bound leads to an invalid state that is discarded (at run-time). If the bounds are omitted, the default range of -32768 to 32768 is used.

• **Binary synchronisation channels** - are declared as ```chan c```. An edge labelled with ```c!``` synchronises with another labelled ```c?```. A synchronisation pair is chosen non-deterministically if several combinations are enabled.

• **Broadcast channels** - are declared as ```broadcast chan c```. In a broadcast synchronisation one sender ```c!``` can synchronise with an arbitrary number of receivers ```c?```. Any receiver than can synchronise in the current state must do so. If there are no receivers, then the sender can still execute the ```c!``` action, i.e. broadcast sending is never blocking.

• **Urgent synchronisation channels** - are declared by prefixing the channel declaration with the keyword ```urgent```. Delays must not occur if a synchronisation transition on an urgent channel is enabled. Edges using urgent channels for synchronisation cannot have time constraints, i.e., no clock guards.

• **Urgent locations** - are semantically equivalent to adding an extra clock x, that is reset on all incoming edges, and having an invariant x<=0 on the location. Hence, time is not allowed to pass when the system is in an urgent location.

• **Committed locations** - are even more restrictive on the execution than urgent locations. A state is committed if any of the locations in the state is committed. A committed state cannot delay and the next transition must involve an outgoing edge of at least one of the committed locations.

• **Arrays** - are allowed for clocks, channels, constants and integer variables. They are defined by appending a size to the variable name, e.g. ```chan c[4]; clock a[2]; int[3,5] u[7];```.

• **Initialisers** - are used to initialise integer variables and arrays of integer variables. For instance, ```int i := 2;``` or ```int i[3] := {1, 2, 3};```.

## Expressions in Uppaal

Expressions in Uppaal range over clocks and integer variables. The BNF is given in Fig. 2. Expressions are used with the following labels:

• **Guard** - A guard is a particular expression satisfying the following conditions: it is side-effect free; it evaluates to a boolean; only clocks, integer variables, and constants are referenced (or arrays of these types); clocks and clock differences are only compared to integer expressions; guards over clocks are essentially conjunctions (disjunctions are allowed over integer conditions).

• **Synchronisation** - A synchronisation label is either on the form Expression! or Expression? or is an empty label. The expression must be side-effect free, evaluate to a channel, and only refer to integers, constants and channels.

• **Assignment** - An assignment label is a comma separated list of expressions with a side-effect; expressions must only refer to clocks, integer variables, and constants and only assign integer values to clocks.

• **Invariant** - An invariant is an expression that satisfies the following conditions: it is side-effect free; only clock, integer variables, and constants are referenced; it is a conjunction of conditions of the form x<e or x<=e where x is a clock reference and e evaluates to an integer.

