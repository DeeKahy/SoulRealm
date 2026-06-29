### Special-value testing:
Basically manual testing where you put in specific values


### Random testing and fuzzing:
Basically fully random garbeled data, usefull for finding crash states, otherwise not so much

### Boundary-value testing
a little point between the two previous extremes, where you set some bounds (example max int, min int), best/worst of both worlds. you set some bound and randomly test within that bound, semi okay for valid input testing, and validating that you dont crash on something that should be a valid input. Only works on stuff with bounds, so strings are a bit iffy.

Single-fault assumption & worst-case fault assumption = the idea is to always look at the bounderies of the graph beneath. one checks only within/on the boundary, the other tests in and just outside the boundary
![[Pasted image 20250916090818.png]]
![[Pasted image 20250916090830.png]]


### Equivalence-class testing


