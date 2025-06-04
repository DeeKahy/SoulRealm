
## Question 8: Merge Pass Iterations

### Formula
The number of **merge passes (iterations)** required in a multiway merge sort with limited memory:

$$\text{Number of merge passes} = \log_{(M-1)}(R)$$

### Variables
- $M$ = Number of pages in memory
- $M - 1$ = Number of runs you can merge in one pass (1 page reserved for output)
- $R$ = Initial number of runs (after first pass of reading and sorting blocks)

### Python Implementation

```python
import math

def calculate_merge_passes(memory_pages, initial_runs):
    """
    Calculate the number of merge passes needed for multiway merge sort
    
    Args:
        memory_pages (int): Number of pages available in memory (M)
        initial_runs (int): Number of initial sorted runs (R)
    
    Returns:
        float: Number of merge passes required
    """
    M = memory_pages
    R = initial_runs
    
    # Number of runs that can be merged in one pass
    merge_capacity = M - 1
    
    # Calculate merge passes using logarithm
    merge_passes = math.log(R) / math.log(merge_capacity)
    
    return merge_passes

# Example calculation
M = 11  # Memory pages
total_pages = 11000
R = total_pages // M  # Initial runs: 576/9 = 64

print(f"Memory pages (M): {M}")
print(f"Initial runs (R): {R}")
print(f"Merge capacity (M-1): {M-1}")
print(f"Merge passes needed: {calculate_merge_passes(M, R)}")
```

### Example Calculation
With $M = 9$ memory pages and $R = 64$ initial runs:

$$\log_8(64) = \frac{\log(64)}{\log(8)} = \frac{6}{3} = 2$$

---

## Question 9: Total I/O Operations

### Formula
Total I/O operations for external merge sort:

$$\text{Total I/Os} = 2 \times N \times \left(1 + \left\lceil \log_{B-1} \left\lceil \frac{N}{B} \right\rceil \right\rceil \right)$$

### Variables
- $N$ = Total number of pages in the file
- $B$ = Number of buffer pages available in memory

### Python Implementation

```python
import math

def calculate_total_ios(total_pages, buffer_pages):
    """
    Calculate total I/O operations for external merge sort
    
    Args:
        total_pages (int): Total number of pages in file (N)
        buffer_pages (int): Number of buffer pages in memory (B)
    
    Returns:
        int: Total I/O operations required
    """
    N = total_pages
    B = buffer_pages
    
    # Calculate number of initial runs
    initial_runs = math.ceil(N / B)
    
    # Calculate number of merge passes
    if initial_runs <= 1:
        merge_passes = 0
    else:
        merge_passes = math.ceil(math.log(initial_runs) / math.log(B - 1))
    
    # Total I/Os formula
    total_ios = 2 * N * (1 + merge_passes)
    
    return total_ios

# Example usage
N = 11000  # Total pages
B = 11    # Buffer pages

total_ios = calculate_total_ios(N, B)
print(f"Total pages (N): {N}")
print(f"Buffer pages (B): {B}")
print(f"Total I/O operations: {total_ios}")

# Breakdown of calculation
initial_runs = math.ceil(N / B)
merge_passes = math.ceil(math.log(initial_runs) / math.log(B - 1)) if initial_runs > 1 else 0
print(f"Initial runs: {initial_runs}")
print(f"Merge passes: {merge_passes}")
```

---

## Question 10: Number of Runs Constraint

### Formula
For the sorting phase to work properly:

$$\text{Number of runs} = \left\lceil \frac{576}{M} \right\rceil$$

### Constraint
$$\text{Number of runs} \leq M - 1$$

This ensures that all runs can be merged in the available memory.

### Python Implementation

```python
import math

def validate_run_constraint(total_pages, memory_pages):
    """
    Check if the number of runs satisfies the memory constraint
    
    Args:
        total_pages (int): Total pages to sort
        memory_pages (int): Available memory pages (M)
    
    Returns:
        dict: Validation results and calculations
    """
    M = memory_pages
    
    # Calculate number of runs
    num_runs = math.ceil(total_pages / M)
    
    # Maximum runs that can be handled
    max_runs = M - 1
    
    # Check constraint
    constraint_satisfied = num_runs <= max_runs
    
    return {
        'total_pages': total_pages,
        'memory_pages': M,
        'number_of_runs': num_runs,
        'max_runs_allowed': max_runs,
        'constraint_satisfied': constraint_satisfied,
        'formula': f"ceil({total_pages}/{M}) = {num_runs} <= {max_runs}"
    }

# Example validation
result = validate_run_constraint(576, 9)
print(f"Total pages: {result['total_pages']}")
print(f"Memory pages: {result['memory_pages']}")
print(f"Number of runs: {result['number_of_runs']}")
print(f"Max runs allowed: {result['max_runs_allowed']}")
print(f"Constraint satisfied: {result['constraint_satisfied']}")
print(f"Calculation: {result['formula']}")
```

### Quick Reference

| Parameter | Symbol | Description |
|-----------|--------|-------------|
| Memory Pages | $M$ | Total pages available in memory |
| Total Pages | $N$ | Total pages in the file to sort |
| Buffer Pages | $B$ | Buffer pages (often same as $M$) |
| Initial Runs | $R$ | Number of sorted runs after first pass |
| Merge Capacity | $M-1$ | Runs that can be merged simultaneously |

