![[Pasted image 20250528105813.png]]

1. Yes it is denoted by the weird underscore _
2. No because Gamma can be the empty symbol where sigma cannot be the empty symbol.
3. It must always move, except when it is on a finite tape and it is at the very beginning or end of that finite tape and tries to move past it. Since it cant it will stay at the same one. (and probably loop forever)
4. No because there MUST always be a rejecting and acceptng state. It might be tempting to say that since we can have machines that ALWAYS accept we can do 1 state, but in reality it still has 2 but just never goes over to the rejecting state.
5. according to [[DTM NTM]] a DTM will always HALT, so it must END on an accepting or rejecting state. So if it wants to stop it will move to either reject or accept.
6. Yes, every computable language is also computably-enumerable. This follows directly from the definitions. Computable languages are accepted by halting DTMs, which are a special case of DTMs.




![[Pasted image 20250528105829.png]]

1. Wrong. A language does not halt.
2. Correct.
3. Wrong. A  DTM cannot be a member of L, as L is a language and therefore contains words and not DTMs. Also, having an accepting state (t) does not imply anything (every DTM is required to have an accepting state).
4. Correct.
5. Wrong. Not every DTM, but there should exist at least one such a DTM.



![[Pasted image 20250528105847.png]]
![[Pasted image 20250528105904.png]]

1. `[s, aaa . . . , 1]    s, aab . . . , 1]` 

2. 
```
s "aaa_" i = 1
h "_aa_" i = 2
h "_aa_" i = 3
h "_aa_" i = 4
e "_aa_" i = 3
r "_aa_" i = 4
```

```
s "aab_" i = 1
h "_ab_" i = 2
h "_ab_" i = 3
h "_ab_" i = 4
e "_ab_" i = 3
g "_a__" i = 2
g "_a__" i = 1
s "_a__" i = 2
h "_a__" i = 3
e "____" i = 2
r "____" i = 3
```


3. w0 is rejected and w1 is rejected



![[Pasted image 20250528105917.png]]

1)
![[Pasted image 20250528121532.png]]

2)

|     | 0         | 1         | _          |
| --- | --------- | --------- | ---------- |
| s   | q0, 0, +1 | q1, 1, +1 | r, _, +1   |
| q0  | q0, 0, +1 | q0, 1, +1 | ck0, _, -1 |
| q1  | q1, 0, +1 | q1, 1, +1 | ck1, _, -1 |
| ck0 | t, 0, +1  | r, 1, +1  | r, _, +1   |
| ck1 | r, 0, +1  | t, 1, +1  | r, _, +1   |
|     |           |           |            |





![[Pasted image 20250528105929.png]]

Hello#Hello

We start by locating the hashtag by doing +1 until it finds it. If it doesnt find one before encountering an empty it fails.
if it finds it it compares the left side and right side until the empty symbol. if they dont match it rejects, if they match it accepts.

How does it compare?
Check the first letter and delete it, move to the letter right after the # and check if they match. If they dont match reject, otherwise delete it, and go back to the beginning of the word (now without the first letter.)  **And repeat** so it just goes back and forth until it encounters empties on both sides.


