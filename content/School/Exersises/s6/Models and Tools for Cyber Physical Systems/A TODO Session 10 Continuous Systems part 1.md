#Exercises 

- We study the syntax and semantics of the continuous-time model
- We show how to model continuous systems using differential equations.
- We study how to solve differential equations numerically.
- We define the notion of stability.

## Exercise 1
![[Pasted image 20250407095907.png]]
a)

```python
def euler_method (f , x0 , h , N ):
	x[0] = x0
	for i in range(N):
		print(x[i])
		x[i + 1] = x[i] + h * f(x[i])
	return x
```


b)
![[Pasted image 20250407100627.png]]

```python

def euler_method(f, x0, t0, h, N):
    # Initialize arrays to store results
    x = [0] * (N + 2)
    t = [0] * (N + 2)

    # Set initial conditions
    x[0] = x0
    t[0] = t0

    # Perform Euler method iterations
    for i in range(N + 1):
        print(x[i])  # Print current value of x
        t[i + 1] = t[i] + h  # Update time
        x[i + 1] = x[i] + h * f(x[i], t[i])  # Update x using Euler formula

    return t, x

def f(x, t):
    return t  # The function dx/dt = t

# Example call
t, x = euler_method(f, 0, 0, 1, 5)

```



[[What is an ODE (ODEs)]]
c)
![[Pasted image 20250407102034.png]]

So this is correct because our x0 variable is just whatever input variables we can give it, it is not the order of anything, it is just the input variables. Example 1,3,5 where 1 is the speed, 3 is the drag, and 5 is acceleration.

```python

def euler_method(f, x0, t0, h, N):
    # Initialize arrays to store results
    x = [0] * (N + 2)
    t = [0] * (N + 2)

    # Set initial conditions
    x[0] = x0[0]
    t[0] = t0

    # Perform Euler method iterations
    for i in range(N + 1):
        print(x[i])  # Print current value of x
        t[i + 1] = t[i] + h  # Update time
        x[i + 1] = x[i] + h * f(x[i], t[i])  # Update x using Euler formula

    return t, x

def f(x, t):
    return t  # The function dx/dt = t

# Example call
t, x = euler_method(f, [1], 0, 1, 8)

```

D)
![[Pasted image 20250610133155.png]]



## Exercise 2

![[Pasted image 20250610125047.png]]
![[Pasted image 20250610125059.png]]


## Exercise 3

![[Pasted image 20250610125129.png]]


## Exercise 4
![[Pasted image 20250610125149.png]]
![[Pasted image 20250610125203.png]]


## Exercise 5
![[Pasted image 20250610125231.png]]















