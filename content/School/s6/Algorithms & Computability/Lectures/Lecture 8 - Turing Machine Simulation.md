![[Pasted image 20250528135006.png]]

In some cases you need to add a state to make sure it behaves the way you want it to do. essentially if you want to simulate stay just make sure the next state ALWAYS goes back to the previous one.

In other cases you wouldnt need another state, for example if you want to "stay" before hitting a blank. Here you can just make it go -1 (or +1 depending) when it hits the blank, to go back.





![[Pasted image 20250528135016.png]]



![[Pasted image 20250528135027.png]]
1. Wrong
2. Wrong
3. Correct
4. Wrong
5. Wrong



![[Pasted image 20250528135041.png]]

if it reads 1 check for another 1, if thats also true check for a zero if its also hit then accept. in every other case go back to start until we read blank where we reject
```
Q = {s, t, r, q1, q11}

Σ = {0, 1},
Γ = {0, 1, }, and
δ is given by the following table:


```

![[Pasted image 20250528142554.png]]







![[Pasted image 20250528135054.png]]







