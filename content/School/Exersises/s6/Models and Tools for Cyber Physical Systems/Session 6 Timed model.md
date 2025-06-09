- Timed processes
- Buffers with bounded delays
- Multiple clocks
- Composition
- Timed-based protocols
- Timed automata
- Zone-based symbolic analysis


# Exercise 1
![[Pasted image 20250606100617.png]]
A)
At a minimum it is 11 hits because it can stay in rest for 10 before getting kicked off, and then work once every 4 minutes (y kicks it into hit), afterwhich it rests for another 10 minutes, and then works for the remanining 10 minutes (every 4 minutes it does a hit)

At a maximum it can be 60 if starting at rest. Because after 5 minutes before it jumps into work, and then can stay at work for a maximum of 60 minutes (because y resets) and then is forced into rest again for the remaining 5 minutes.

B)

At a minmum it will be 13 hits, because it works for 40 minutes (40/4=10) but instead of hitting on the last transition it goes to rest instead (10-1=9) then it rests for 10 minutes, and works for the remaning 20 (20/4 -1 = 4) so 13



at a maximum 65 because it works for 60 minutes, rests for 5, and then works for the remaining 5 minutes which is 65



# Exercise 2
![[Pasted image 20250606100746.png]]

![[Pasted image 20250609112658.png]]

remember that x goes up by 1 every minute (like in the last task)

# Exercise 3
![[Pasted image 20250606100757.png]]

![[Pasted image 20250609114659.png]]
(remember to have an arrow be this `-->`instead of this `->`)


# Exercise 4
![[Pasted image 20250606100814.png]]


![[Pasted image 20250609131638.png]]

![[Pasted image 20250609131842.png]]


More information on [[UPPAAL Model Notes]]


# Exercise 5
![[Pasted image 20250606100827.png]]

A: 
0 <= x <= 5
0 <= y <= 5

B:
3 <= x <= 7
3 <= y <= 7


c:
5 <= x <= 8
4 <= y <= 8