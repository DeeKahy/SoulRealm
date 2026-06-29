
![[Pasted image 20250602213516.png]]

## q8

The formula you should use to determine **how many iterations (merge passes) are necessary** in a multiway merge sort with limited memory is:

---

### **Formula:**

$$
\text{Number of merge passes} = \log_{(M-1)}(R)
$$

---

### Where:

* $M$ = Number of pages in memory.
* $M - 1$ = Number of runs you can merge in one pass (because 1 page is reserved for output).
* $R$ = Initial number of runs (after the first pass of reading and sorting blocks).

---

### Example from the image:

* Memory pages: $M = 9$
* Sorted runs: $R = 576 / 9 = 64$
* Runs merged at a time: $M - 1 = 8$
* Passes:

  $$
  \log_8(64) = \frac{\log(64)}{\log(8)} = \frac{6}{3} = 2
  $$

---

### Final Answer:

Use:

$$
\boxed{\log_{(M - 1)}(R)}
$$

to calculate the number of **merge iterations** needed.


# q9


$$
\text{Total I/Os} = 2 \times N \times \left(1 + \left\lceil \log_{B-1} \left\lceil \frac{N}{B} \right\rceil \right\rceil \right)
$$





## q 10
Number of runs =ceiling(576/M) Number of runs <= M−1




