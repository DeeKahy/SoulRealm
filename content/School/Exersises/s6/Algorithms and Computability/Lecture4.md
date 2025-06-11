#### Preparation  

- Read the beginning of CLRS Chapter 18 until 18.2. I assume you know how the search, insert, and delete algorithms of the B-tree work. If not, read the rest of the chapter.  When reading, think about the following question:   
    - _What are the key differences between binary search trees and B-trees?_
-  Read these [lecture notes](https://www.moodle.aau.dk/pluginfile.php/3639537/mod_page/content/3/esort.pdf?time=1740823271171 "lecture notes"). When reading, make sure at least that you find answers to the following questions: 
	- Which parameters are important when analyzing the running time of external-memory algorithms?  
    - What is the main difference between the main-memory merge sort and external-memory merge sort?  
    - How much memory does the external-memory merge sort require?  
    - Why two-phase, multiway merge sort can only sort files of limited size?_
- Watch [this video](https://panopto.aau.dk/Panopto/Pages/Viewer.aspx?id=a9793cc3-047e-40f9-b39b-afab00a0cb66):  
    - _The outputs of the external-memory duplicate-removal algorithms in the video may have one slight problem. What is the problem and how can it be fixed?_



### Key Differences Betwaeen Binary Search Trees (BSTs) and B-trees

#### 1. **Node Capacity**
- **BST:** Each node holds **one key** and has at most **two children** (left/right subtrees).  
- **B-tree:** Each node holds **multiple keys** (order ```m``` defines min/max keys/children). For example:  
  - Minimum keys per node: ```⌈m/2⌉ - 1``` (except root).  
  - Maximum keys per node: ```m - 1```.  
  - Children per node: ```⌈m/2⌉``` to ```m```.

#### 2. **Balancing**
- **BST:** Not inherently balanced. Can degenerate into a linked list (height ```O(n)```).  
- **B-tree:** **Always balanced** by design. Insertions/deletions use **splitting/merging** to maintain uniform height (```O(\log n)```).

#### 3. **Height**
- **BST:** Worst-case height = ```O(n)``` (unbalanced). Best-case = ```O(\log n)``` (balanced).  
- **B-tree:** Height is **strictly logarithmic** (```O(\log_m n)```), where ```m``` is the order.  
  - Example: For ```m=100```, a B-tree with 1 billion keys has height ≤ 4.

#### 4. **Use Cases**
- **BST:** Optimal for **in-memory** operations (e.g., language libraries, small datasets).  
- **B-tree:** Optimized for **disk-based storage** (e.g., databases, file systems):  
  - Minimizes disk I/O by packing nodes into blocks (e.g., 4KB disk pages).  
  - Handles large datasets efficiently.

#### 5. **Operations**
- **Search:**  
  - BST: ```O(h)``` (h = height, worst ```O(n)```).  
  - B-tree: ```O(\log_m n)``` (consistent).  
- **Insert/Delete:**  
  - BST: May require rebalancing (e.g., AVL/Red-Black rotations).  
  - B-tree: Uses **split/merge** to preserve balance without rotations.

#### 6. **Structural Comparison**
| Feature          | BST                          | B-tree                                     |
|------------------|------------------------------|---------------------------------------------|
| **Keys per node** | 1                            | Multiple (```m-1``` max)                       |
| **Children**     | ≤2                           | ```⌈m/2⌉``` to ```m```                             |
| **Balance**      | Manual (e.g., AVL/RB trees)  | Automatic via split/merge                   |
| **Height**       | Variable (```O(n)``` worst)      | Fixed (```O(\log_m n)```)                      |
| **I/O Cost**     | High for disk access         | Optimized (fewer disk seeks)               |

#### Summary
- **BSTs** are simpler for small, in-memory data.  
- **B-trees** excel in disk-intensive systems (e.g., databases) due to **balanced height**, **high fanout**, and **efficient I/O**.  

> 💡 **Note**: B-trees are the backbone of modern databases (e.g., MySQL, PostgreSQL). BST variants (AVL, Red-Black) are used where in-memory speed is critical.



## Important Parameters for External-Memory Algorithm Analysis

When analyzing the running time of external-memory algorithms, **three key parameters are crucial**: [^1]

- **B** - Block size (typically the disk page size)
- **N (n)** - Total size of the input data
- **M (m)** - Available main memory size

These parameters determine the I/O complexity, which is the primary bottleneck in external memory algorithms.

## Main Difference Between Main-Memory and External-Memory Merge Sort

The **fundamental difference lies in data access patterns and memory constraints**: [^2]

- **Main-memory merge sort**: All data fits in RAM, allowing random access to any element
- **External-memory merge sort**: **Data is too large to fit in main memory** and must reside in slower external storage (typically disk drives), requiring careful management of data movement between memory and disk [^2]

External sorting becomes necessary when **the data being sorted cannot fit into the main memory** of the computing device. [^3]

## Memory Requirements for External-Memory Merge Sort

The external-memory merge sort has **modest memory requirements** compared to the data size being sorted. The algorithm is designed to work with **limited available memory (M)**, where M is much smaller than the total data size N. [^4]

The key insight is that **external memory algorithms must be efficient in terms of I/O operations** rather than just computational complexity, since disk access is significantly slower than memory access. [^5]

## Why Two-Phase Multiway Merge Sort Has Limited File Size

The **two-phase multiway merge sort can only handle files of limited size** due to a fundamental constraint in its second phase: [^6][^7]

- **Phase 1** uses all available memory efficiently for internal sorting
- **Phase 2** can only merge a limited number of runs simultaneously - specifically, it **uses just 3 pages out of m available memory** [^6]

This limitation occurs because the second phase needs to keep **one input buffer for each run being merged plus one output buffer**. The number of runs that can be merged simultaneously is constrained by the available memory, which limits the maximum file size that can be sorted in just two phases. [^8][^4]

To sort larger files, **multiple iterations in phase 2 are needed**, extending beyond the basic two-phase approach. [^4]

The algorithm works by **merging all runs at once in phase 2**, but this approach is only feasible when the number of runs created in phase 1 doesn't exceed the memory's capacity to handle simultaneous merging. [^6]
