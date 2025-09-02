## 1. Computable vs. Computably Enumerable

Let's start with two fundamental concepts that define what we can and cannot solve algorithmically.
**Computable Problems** (also called "decidable"):
- There exists a Turing machine that _always_ halts and gives the correct answer (YES or NO)
- No matter what input you give it, the machine will eventually stop and tell you the answer
- Example: "Is this number even?" - We can always determine this in finite time
**Computably Enumerable (c.e.) Problems**:
- There exists a Turing machine that halts with YES when the answer is YES
- But when the answer is NO, the machine might run forever - we never get a definitive "NO"
- Example: "Does this Turing machine halt on this input?" - If it halts, we'll eventually see it stop. But if it doesn't halt, our simulation will run forever waiting
**Key insight**: A language is decidable if and only if both the language AND its complement are computably enumerable. Think of it this way - we need to be able to recognize both when something IS in the language and when it ISN'T.
## 2. Two Classic Undecidable Problems
**The Halting Problem**: Given a machine M and input w, does M halt on w?
**The Acceptance Problem**: Given a machine M and input w, does M accept w?
These might seem similar, but there's a subtle difference. The Acceptance Problem asks not just whether the machine stops, but whether it stops in an _accepting_ state.
Both problems are computably enumerable but not decidable. Their complements are not computably enumerable, which is why they're undecidable. These serve as our "benchmark" hard problems - we prove other problems are undecidable by showing they're at least as hard as these.
## 3. How Reductions Work
Here's the key strategy for proving undecidability:
To prove Problem B is undecidable, we show that _if we could solve B, then we could solve Problem A_ - where A is already known to be undecidable.
Since A is impossible, B must be impossible too. It's like saying "if you could do the impossible thing B, then you could do this other impossible thing A that we already know is impossible."
**Example**: Proving the Acceptance Problem is undecidable using the Halting Problem.
1. Start with an instance of the Halting Problem: "Does machine M halt on input w?"
2. Construct a new machine M' that works as follows:
    - M' completely ignores whatever input it receives
    - Instead, M' internally simulates M running on w     _(w is hardcoded)_
    - If M halts on w, then M' accepts (regardless of its input)
    - If M doesn't halt on w, then M' runs forever
3. Now we ask the Acceptance Problem: "Does M' accept the empty string?"
4. The answer is YES if and only if M halts on w
    
So we've transformed any Halting Problem instance into an Acceptance Problem instance. If we could solve the Acceptance Problem, we could solve the Halting Problem - but we know that's impossible. Therefore, the Acceptance Problem is also undecidable.
## 4. Rice's Theorem - The Ultimate Shortcut
Rice's Theorem is incredibly powerful because it eliminates entire families of problems at once:
**Statement**: Every non-trivial property of the language recognized by a Turing machine is undecidable.
- If you ask _any meaningful question_ about a program’s **behavior** (its accepted language), and
- That question isn’t universally true or universally false,
- Then there is **no algorithm that always decides it correctly**.
**What this means**:
- "Non-trivial" = some machines have the property, others don't (not all machines have it, not all machines lack it)
- "Property of the language" = the property depends only on what strings the machine accepts, not on how the machine is constructed
**Why these examples are undecidable**:
- "Does this machine accept nothing?" - Some machines accept nothing, others accept something → undecidable by Rice's theorem
- "Does this machine accept only finitely many strings?" - Some machines accept finite languages, others infinite → undecidable by Rice's theorem
**Why this example doesn't apply**:
- "Does this machine have exactly 5 states?" - This is about the machine's _construction/description_, not about what language it recognizes. Two different machines with different numbers of states could recognize the same language.