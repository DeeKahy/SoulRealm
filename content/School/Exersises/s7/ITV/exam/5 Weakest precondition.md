
**Definition**  
$wp(C,ψ)$ = the most general condition that, if true before $C$, guarantees $ψ$ afterwards.

**Core equivalence**  
$\{φ\}\,C\,\{ψ\}$ is valid $\iff φ → wp(C,ψ)$

---

### Backward rules (compute inside-out)

| construct   | rule                                                                                           |
| ----------- | ---------------------------------------------------------------------------------------------- |
| skip        | $wp(\texttt{skip},ψ) = ψ$                                                                      |
| assignment  | $wp(x:=e,ψ) = ψ[e/x]$                                                                          |
| sequence    | $wp(C_1;C_2,ψ) = wp(C_1, wp(C_2,ψ))$                                                           |
| conditional | $wp(\texttt{if }b\texttt{ then }C_1\texttt{ else }C_2,ψ) = (b → wp(C_1,ψ)) ∧ (¬b → wp(C_2,ψ))$ |
| while       | needs user-given invariant $θ$; check $φ→θ$, $\{θ∧b\}C\{θ\}$, $θ∧¬b→ψ$                         |

---

### Live example (same one every time)

Program: `x:=x+1; y:=x*2`  
Post: $y=12$

1. $wp(y:=x*2,\,y=12) = x*2=12 = x=6$  
2. $wp(x:=x+1,\,x=6) = x+1=6 = x=5$

Hence $\{x=5\}$ code $\{y=12\}$ ✓

Any other precondition stronger than $x=5$ also works; $x=5$ is the *weakest*.