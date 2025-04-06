#Exercises

1. First do the exercises in the slides ==todo==
2. Take a look at the list of [banned C functions](https://github.com/git/git/blob/master/banned.h) in the git project.
	1.  For at least three of the functions, determine why they are banned and develop (small snippets of) example C code that illustrates the problem.
	2. Find secure/better alternatives for the functions you chose; illustrate them and explain why they are better  
	3. Determine what rules of the CERT CC and/or which CWEs are violated by using these functions

## STRCPY:
**`strcpy()` in C does not perform bounds checking** [1](https://www.geeksforgeeks.org/strcpy-in-c/)[2](https://www.geeksforgeeks.org/security-issues-in-c-language/). This means that it doesn't verify if the destination buffer is large enough to hold the source string, which can lead to a buffer overflow if the source string is larger than the destination buffer [1](https://www.geeksforgeeks.org/strcpy-in-c/)[2](https://www.geeksforgeeks.org/security-issues-in-c-language/).

`strcpy_s` is considered safer than `strcpy` primarily because it helps prevent buffer overflows. Here's why:
- **Buffer Overflow Protection**: `strcpy_s` requires you to explicitly specify the size of the destination buffer. This allows the function to avoid writing beyond the buffer's boundaries, preventing potential overflows [1](https://cplusplus.com/forum/beginner/118771/). `strcpy`does not perform this check, making it vulnerable to writing past the allocated memory if the source string is larger than the destination buffer [2](https://www.geeksforgeeks.org/why-strcpy-and-strncpy-are-not-safe-to-use/)[3](https://www.reddit.com/r/cprogramming/comments/kucrv6/why_is_strcpy_unsafe/).


# localtime
localtime is not thread-safe because it uses a static buffer shared between threads.
There is no proper cross platform alternative. posix has an alternative that doest work everywhere, and windows has its own thing that is potentially correct. ==(maybe? this one fucking sucks)==


# sprintf
`sprintf` has potential for buffer overflows because of bad bound checking like in STRCPY above [1](https://stackoverflow.com/questions/7315936/which-of-sprintf-snprintf-is-more-secure)[2](https://softwareengineering.stackexchange.com/questions/418304/since-strcpy-strcat-and-sprintf-are-dangerous-what-shall-we-use-in-stea):

- **Buffer Overflow:** The main issue with `sprintf` is that it doesn't perform bounds checking. If the formatted string exceeds the buffer size, it can lead to a buffer overflow, potentially overwriting adjacent memory and causing crashes or security exploits [2](https://softwareengineering.stackexchange.com/questions/418304/since-strcpy-strcat-and-sprintf-are-dangerous-what-shall-we-use-in-stea).

