![[Pasted image 20250903085624.png]]

Synchronize without external source. Same but large number of computers.
One computer could be the domenant one and the other one/ones use that as their gospel.
or you could average it out (and also take transit time into account though some pinging magic)


Limits of accuracy
hopes and prayers, since youd need to take at least round trip travel time into account.

![[Pasted image 20250903085808.png]]
Laptop (many moving parts different languages different protocols bla bla bla)
Local area network (different devices/operating systems, but mostly the same method of communication)
Forskernet (mosty standardized ish modems communicating with each other and the exit point, all on the same (mostly) operating system running simalar software)


#### What is the main disadvantage of distributed systems which exploit the infrastructure offered by the Internet? How can this be overcome?

Syncronozation
google serivce shutdown issue
Setup error




![[Pasted image 20250903085820.png]]

Not secure, one bad actor gets direct access to every given pc in that local area net. 
For p2p solutions it is hard to properly secure them, you can sandbox the p2p part somewhat, but that is where all meaningful protections end.

consensus



![[Pasted image 20250903085838.png]]
first of all they can both drift wrongly.
variable message delays between the wired/wireless communication.



### Speedup Calculation  
A program spends 60% of its execution time in a part that can be parallelized. The rest (40%) must remain sequential.  

According to Amdahl's Law, what is the maximum theoretical speedup if the parallel part is executed on:  
Use [[Amdahl’s law]] and plug in the numbers.
a) 2 processors  = 1.25
b) 4 processors = 1.43
c) An infinite number of processors   = 1.67
  
### Finding the Parallel Fraction  
An application achieves a speedup of 5 when running on 8 processors. Use Amdahl's Law to determine the fraction of the program that was parallelized.
The paralellization factor is 0.91% ![[Pasted image 20250903105040.png]]
