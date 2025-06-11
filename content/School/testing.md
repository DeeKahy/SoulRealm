

Here's the enhanced Python script that dynamically handles all your questions for any input parameters. Just set ```TOTAL_PAGES``` and ```MEMORY_PAGES``` at the bottom:

```python
import math

def external_sort_analysis(total_pages, memory_pages):
    """
    Comprehensive analysis of external merge sort for given parameters.

    Args:
        total_pages (int): Total pages in file (N)
        memory_pages (int): Available memory pages (M)

    Returns:
        dict: All calculated metrics
    """
    # Calculate initial runs
    initial_runs = math.ceil(total_pages / memory_pages)

    # Calculate merge passes iteratively
    merge_passes = 0
    current_runs = initial_runs
    merge_capacity = memory_pages - 1

    while current_runs > 1:
        current_runs = math.ceil(current_runs / merge_capacity)
        merge_passes += 1

    # Calculate I/O operations
    first_phase_ios = 2 * total_pages
    total_ios = first_phase_ios + 2 * total_pages * merge_passes

    # Check constraint
    constraint_satisfied = initial_runs <= (memory_pages - 1)

    # Calculate minimum memory for one-pass merge
    min_memory = find_min_memory(total_pages)

    # Calculate maximum buffer size for single merge pass
    if initial_runs <= memory_pages - 1:
        # Can merge in one pass
        total_buffers_needed = initial_runs + 1  # input buffers + output buffer
        max_buffer_size = memory_pages // total_buffers_needed
        can_merge_one_pass = True
    else:
        # Cannot merge in one pass with any buffer size
        max_buffer_size = 1  # Default to 1 page per buffer
        can_merge_one_pass = False

    return {
        'total_pages': total_pages,
        'memory_pages': memory_pages,
        'sorted_runs': initial_runs,
        'merge_iterations': merge_passes,
        'total_ios_new': total_ios,
        'initial_runs': initial_runs,
        'merge_passes': merge_passes,
        'first_phase_ios': first_phase_ios,
        'total_ios': total_ios,
        'constraint_satisfied': constraint_satisfied,
        'min_memory_one_pass': min_memory,
        'merge_capacity': memory_pages - 1,
        'max_buffer_size': max_buffer_size,
        'can_merge_one_pass': can_merge_one_pass,
        'total_buffers_needed': initial_runs + 1 if can_merge_one_pass else None
    }

def find_min_memory(total_pages):
    """Efficiently find minimum memory for exactly one merge pass"""
    if total_pages <= 1:
        return 1

    # Solve quadratic: M_min = ceil((1 + sqrt(1 + 4N))/2)
    M0 = math.ceil((1 + math.sqrt(1 + 4 * total_pages)) / 2)
    M = int(M0)

    while True:
        runs = math.ceil(total_pages / M)
        if runs <= M - 1:
            return M
        M += 1

def print_full_analysis(total_pages, memory_pages):
    """Print complete analysis for given parameters"""
    results = external_sort_analysis(total_pages, memory_pages)

    print(f"\n{'='*70}")
    print(f"COMPLETE ANALYSIS FOR {total_pages} PAGES WITH {memory_pages} MEMORY PAGES")
    print(f"{'='*70}")

    # New questions analysis
    print("\n[ANSWERS TO NEW QUESTIONS]")
    print(f"1. Sorted runs produced in first phase: {results['sorted_runs']}")
    print(f"2. Merge iterations needed: {results['merge_iterations']}")
    print(f"3. Total I/O operations: {results['total_ios_new']}")
    print(f"4. Maximum buffer size (pages per buffer): {results['max_buffer_size']}")

    # Buffer allocation details
    if results['can_merge_one_pass']:
        print(f"\n[BUFFER ALLOCATION BREAKDOWN]")
        print(f"- Input buffers needed: {results['initial_runs']} (one per sorted run)")
        print(f"- Output buffers needed: 1")
        print(f"- Total buffers: {results['total_buffers_needed']}")
        print(f"- Memory available: {memory_pages} pages")
        print(f"- Max pages per buffer: {memory_pages} ÷ {results['total_buffers_needed']} = {results['max_buffer_size']}")
        print(f"- Can merge all runs in one pass: YES")
    else:
        print(f"\n[BUFFER ALLOCATION BREAKDOWN]")
        print(f"- Initial runs: {results['initial_runs']}")
        print(f"- Memory capacity for input buffers: {results['merge_capacity']}")
        print(f"- Can merge all runs in one pass: NO")
        print(f"- Multiple merge iterations required: {results['merge_iterations']}")

    # Mathematical breakdown
    print("\n[MATHEMATICAL COMPUTATION BREAKDOWN]")
    print("## How we computed the four answers:")
    print()

    # Question 1: Sorted runs
    print("### 1. Sorted runs produced in first phase:")
    print(f"$\\text{{Sorted runs}} = \\left\\lceil \\frac{{N}}{{M}} \\right\\rceil = \\left\\lceil \\frac{{{total_pages}}}{{{memory_pages}}} \\right\\rceil = \\left\\lceil {total_pages/memory_pages:.3f} \\right\\rceil = {results['sorted_runs']}$")
    print()

    # Question 2: Merge iterations
    print("### 2. Merge iterations needed:")
    print(f"- Merge capacity: $M - 1 = {memory_pages} - 1 = {results['merge_capacity']}$")
    print(f"- Initial runs: $R_0 = {results['initial_runs']}$")

    # Show iterative calculation
    current_runs = results['initial_runs']
    iteration = 0
    while current_runs > 1:
        next_runs = math.ceil(current_runs / results['merge_capacity'])
        print(f"- Pass {iteration + 1}: $R_{{{iteration + 1}}} = \\left\\lceil \\frac{{R_{{{iteration}}}}}{{{results['merge_capacity']}}} \\right\\rceil = \\left\\lceil \\frac{{{current_runs}}}{{{results['merge_capacity']}}} \\right\\rceil = {next_runs}$")
        current_runs = next_runs
        iteration += 1

    print(f"- **Total merge iterations: {results['merge_iterations']}**")
    print()

    # Question 3: Total I/O operations
    print("### 3. Total I/O operations:")
    print(f"- First phase I/Os: $2 \\times N = 2 \\times {total_pages} = {results['first_phase_ios']}$")
    print(f"- Each merge pass I/Os: $2 \\times N = 2 \\times {total_pages} = {2 * total_pages}$")
    print(f"- Number of merge passes: ${results['merge_passes']}$")
    print(f"- **Total I/Os**: $2N \\times (1 + \\text{{merge passes}}) = 2 \\times {total_pages} \\times (1 + {results['merge_passes']}) = {results['total_ios']}$")
    print()

    # Question 4: Maximum buffer size
    print("### 4. Maximum buffer size:")
    if results['can_merge_one_pass']:
        print(f"- Total buffers needed: $\\text{{Input buffers}} + \\text{{Output buffer}} = {results['initial_runs']} + 1 = {results['total_buffers_needed']}$")
        print(f"- Available memory: $M = {memory_pages}$ pages")
        print(f"- **Max buffer size**: $\\left\\lfloor \\frac{{M}}{{\\text{{Total buffers}}}} \\right\\rfloor = \\left\\lfloor \\frac{{{memory_pages}}}{{{results['total_buffers_needed']}}} \\right\\rfloor = {results['max_buffer_size']}$ pages")
        print(f"- Constraint check: ${results['initial_runs']} \\leq {results['merge_capacity']}$ → **{results['constraint_satisfied']}**")
    else:
        print(f"- Initial runs: ${results['initial_runs']}$")
        print(f"- Memory constraint: $\\text{{runs}} \\leq M - 1 = {results['merge_capacity']}$")
        print(f"- Constraint violated: ${results['initial_runs']} > {results['merge_capacity']}$")
        print(f"- **Cannot merge in single pass** → Multiple iterations required")
        print(f"- **Max buffer size limited to 1 page** (or use available memory / merge capacity)")

    print("=" * 70)

# ===== INPUT YOUR VALUES HERE =====
TOTAL_PAGES = 576   # Change to your file size
MEMORY_PAGES = 9   # Change to your available memory
# ==================================

print_full_analysis(TOTAL_PAGES, MEMORY_PAGES)

# Test with the other examples too
print("\n" + "="*50)
print("TESTING OTHER EXAMPLES:")
print("="*50)


```



- [ANSWERS TO NEW QUESTIONS]
- 1. Sorted runs produced in first phase: 64
- 2. Merge iterations needed: 2
- 3. Total I/O operations: 3456
- 4. Maximum buffer size (pages per buffer): 1

- [BUFFER ALLOCATION BREAKDOWN]
- - Initial runs: 64
- - Memory capacity for input buffers: 8
- - Can merge all runs in one pass: NO
- - Multiple merge iterations required: 2

- [MATHEMATICAL COMPUTATION BREAKDOWN]
- ## How we computed the four answers:

- ### 1. Sorted runs produced in first phase:
- $\text{Sorted runs} = \left\lceil \frac{N}{M} \right\rceil = \left\lceil \frac{576}{9} \right\rceil = \left\lceil 64.000 \right\rceil = 64$

- ### 2. Merge iterations needed:
- - Merge capacity: $M - 1 = 9 - 1 = 8$
- - Initial runs: $R_0 = 64$
- - Pass 1: $R_{1} = \left\lceil \frac{R_{0}}{8} \right\rceil = \left\lceil \frac{64}{8} \right\rceil = 8$
- - Pass 2: $R_{2} = \left\lceil \frac{R_{1}}{8} \right\rceil = \left\lceil \frac{8}{8} \right\rceil = 1$
- - **Total merge iterations: 2**

- ### 3. Total I/O operations:
- - First phase I/Os: $2 \times N = 2 \times 576 = 1152$
- - Each merge pass I/Os: $2 \times N = 2 \times 576 = 1152$
- - Number of merge passes: $2$
- - **Total I/Os**: $2N \times (1 + \text{merge passes}) = 2 \times 576 \times (1 + 2) = 3456$

- ### 4. Maximum buffer size:
- - Initial runs: $64$
- - Memory constraint: $\text{runs} \leq M - 1 = 8$
- - Constraint violated: $64 > 8$
- - **Cannot merge in single pass** → Multiple iterations required
- - **Max buffer size limited to 1 page** (or use available memory / merge capacity)
- ======================================================================

- ==================================================
- TESTING OTHER EXAMPLES:
- ==================================================