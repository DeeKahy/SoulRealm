
https://www.youtube.com/watch?v=-Bs2Uy3zGsw

watch this video again


Example of a tripple:
`{P}S{Q}`
`{x = 0} x = x + 1 {x > 0}`

You DO NOT validate this statement by doing P and then S and check if we end up in Q. what you actually do is this: We take the assignment statement (S) and the post condition (Q), and apply the assignment statement to the post condition, and then we check if we get something that satisfies the precondition (P).




Hoare tripple in english :"the execution ==S== beginning in a state where ==P== is satisfied will terminate in a state where Q is satisfied". If we start in a state where ==P== is true, and do ==S== to ==P==, we will end in a state where ==Q== is true

![[Pasted image 20260105142700.png]]



precondition strengthening & post condition weakening (dont mix them up)


precondition weakening causes nonsense

same for post condition strengthening
