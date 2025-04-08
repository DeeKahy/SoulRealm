#### Exercises

1. Run the edit distance algorithm from the slides on s="GO", t="LOG":   
    - What is the edit distance? What edit operations does the algorithm suggest?   
    - Draw the recursion tree for a memoized version of the algorithm.   
    - Count and compare how many recursive calls are made by the memoized algorithm and how many by a recursive algorithm without memoization.
2. Answer questions 2 and 3 below the videos (see above).  
    
3. Based on the slides, write a pseudocode of a dynamic programming algorithm for the activity selection problem (using the first recurrence, see slide 31). First, write an algorithm to return the maximum number of activities. Then, augment it to print out the selected activities.
4. Solve CLRS4 14-2 (CLRS3 15-2), _if you have time_.  Follow the roadmap presented today. First, write a recurrence, then an algorithm to find the length of the longest palindrome. Finally, augment the algorithm to return the longest palindrome itself.



|     |     |     | G   | H   | O   | S   | T   |
| --- | --- | --- | --- | --- | --- | --- | --- |
|     | j/i | 0   | 1   | 2   | 3   | 4   | 5   |
|     | 0   | 0   | 1D  | 2D  | 3D  | 4D  | 5D  |
| H   | 1   | 1l  | 1R  | 1C  | 3D  |     |     |
| O   | 2   | 2l  |     |     |     |     |     |
| U   | 3   | 3l  |     |     |     |     |     |
| S   | 4   | 4l  |     |     |     |     |     |
| E   | 5   | 5l  |     |     |     |     |     |



![[Pasted image 20250408170823.png]]

