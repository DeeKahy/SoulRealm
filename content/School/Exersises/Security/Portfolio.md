# Lecture 1: What is Security?

## Security Definition

### CIA Model for Security Goals (obviously not the end all be all)

**Confidentiality:**
- Keeping sensitive information protected
- Examples: passwords, personal data

**Integrity:**
- Ensuring only authorized entities can access or modify data the correct data
- Examples: 
  - Bank accounts
  - E-boks (compromised by Netcompany)
  - Personal accounts (Steam security incidents)

**Availability:**
- Critical systems must be accessible when needed
- Examples: NemID, medical records
- **Note: This is somewhat debatable in certain contexts**

## Security as an Afterthought

Security is rarely the primary consideration in system design:
- **Houses**: Standard locks are easily compromised; windows prioritize light/views over security
- **Bunkers**: Contrast where security is the primary design concern

## Software Security

Largely follows the same principles as physical security, applying CIA to digital systems.

## Risk Analysis & Management

Risk management involves understanding tradeoffs:
- **Example**: Home design balances aesthetics (windows at eye level) vs. security (higher windows or none)

Most systems initially prioritize functionality over security:
- Development often focuses on demonstrating working prototypes
- Security considerations are frequently deferred, leading to vulnerabilities





# Lecture 2

Reflections on C’s “security” model
• How and where (in the process) should it have been found? **before the function was introduced.**
• How can it be mitigated/solved? **adding a depricated warning**
• Are they C specific? **(these examples are low level specific and exist in the compiler)**
• Can they be found using manual reviews? Static analyis?
• Reflections on the importance of context when defining security
(think microarchitecture attacks and “helpful” compilers)

## STRCPY:
**`strcpy()` in C does not perform bounds checking** [1](https://www.geeksforgeeks.org/strcpy-in-c/)[2](https://www.geeksforgeeks.org/security-issues-in-c-language/). This means that it doesn't verify if the destination buffer is large enough to hold the source string, which can lead to a buffer overflow if the source string is larger than the destination buffer [1](https://www.geeksforgeeks.org/strcpy-in-c/)[2](https://www.geeksforgeeks.org/security-issues-in-c-language/).

`strcpy_s` is considered safer than `strcpy` primarily because it helps prevent buffer overflows. Here's why:
- **Buffer Overflow Protection**: `strcpy_s` requires you to explicitly specify the size of the destination buffer. This allows the function to avoid writing beyond the buffer's boundaries, preventing potential overflows [1](https://cplusplus.com/forum/beginner/118771/). `strcpy`does not perform this check, making it vulnerable to writing past the allocated memory if the source string is larger than the destination buffer [2](https://www.geeksforgeeks.org/why-strcpy-and-strncpy-are-not-safe-to-use/)[3](https://www.reddit.com/r/cprogramming/comments/kucrv6/why_is_strcpy_unsafe/).

**strcpy() violates the following security rules:**

- **CWE-120: Buffer Copy without Checking Size of Input** ('Classic Buffer Overflow') - strcpy performs no bounds checking, allowing buffer overflows when the source string exceeds destination capacity
- **CWE-676: Use of Potentially Dangerous Function** - strcpy is considered inherently dangerous
- **CERT C STR31-C**: "Guarantee that storage for strings has sufficient space for character data and the null terminator"

# sprintf
`sprintf` has potential for buffer overflows because of bad bound checking like in STRCPY above [1](https://stackoverflow.com/questions/7315936/which-of-sprintf-snprintf-is-more-secure)[2](https://softwareengineering.stackexchange.com/questions/418304/since-strcpy-strcat-and-sprintf-are-dangerous-what-shall-we-use-in-stea):

- **Buffer Overflow:** The main issue with `sprintf` is that it doesn't perform bounds checking. If the formatted string exceeds the buffer size, it can lead to a buffer overflow, potentially overwriting adjacent memory and causing crashes or security exploits [2](https://softwareengineering.stackexchange.com/questions/418304/since-strcpy-strcat-and-sprintf-are-dangerous-what-shall-we-use-in-stea).

**sprintf() violates the following security rules:**

- **CWE-120: Buffer Copy without Checking Size of Input** ('Classic Buffer Overflow') - Like strcpy, it performs no bounds checking
- **CWE-676: Use of Potentially Dangerous Function** - It's inherently dangerous due to buffer overflow risks
- **CERT C STR31-C**: "Guarantee that storage for strings has sufficient space for character data and the null terminator"
- **CERT C FIO30-C**: "Exclude user input from format strings" (if user input is used in the format string)


spectre/meltdown are very hard to avoid.

# Lecture 3

# Access Control and Security Models: Portfolio Notes

## Access Control Matrix
**An access control matrix is a formal security model** that represents the permissions of subjects (users, processes) to perform operations on objects (files, resources) in a system. 

### Example of Access Control Matrix:

| Subject/Object | File1.txt | File2.doc | Printer1 | Database |
|----------------|-----------|-----------|----------|----------|
| **Alice**      | Read, Write | Read | Print | Read, Write |
| **Bob**        | Read | Read, Write | Print | No Access |
| **Charlie**    | No Access | Read | No Access | Read |
| **Admin**      | Read, Write, Execute | Read, Write, Execute | Manage | Read, Write, Admin |

- **Each cell contains the access rights** that a subject has on an object
- **Implementation can be row-wise** (capability lists) or **column-wise** (access control lists)

## Lattice-Based Access Control

**A lattice is a mathematical structure** used to model security levels and information flow in a system.

### Example Lattice Diagram:
```
            Top Secret
            /        \
       Secret        TS-A
       /    \        /   \
Confidential  S-A   S-B   TS-B
       \    /        \   /
        Public        C-A
```
**subjects with Top Secret clearance can read everything below them** in the hierarchy
- **In this lattice**:
  - Top Secret (TS) is the highest classification
  - Public is the lowest classification
  - Some classifications are compartmentalized (e.g., S-A represents "Secret with A clearance")
  - Information can only flow from lower to higher levels or to incomparable levels

## Finite State Machine Model

**A finite state machine (FSM) model** formally describes system behavior through states, transitions, and actions.

### Example State Machine for File Access:
```
      ┌───────────┐     authenticate     ┌───────────┐
      │  Locked   │ ─────────────────>   │ Unlocked  │
      └───────────┘                      └───────────┘
           ↑                                   │
           │                                   │
           │          timeout/logout           │
           └───────────────────────────────────┘
```

**States**:
- Locked: File access is prohibited
- Unlocked: File access is permitted based on ACL

**Transitions**:
- authenticate: User provides valid credentials
- timeout/logout: Session expires or user logs out

## Bell-LaPadula (BLP) Model

**The Bell-LaPadula model is a formal state machine security model** focusing on maintaining confidentiality in systems.

### Example BLP Scenario:

| Subject | Clearance | Object | Classification | Operation | Allowed?                          |
| ------- | --------- | ------ | -------------- | --------- | --------------------------------- |
| User1   | Secret    | DocA   | Top Secret     | Read      | **No** (violates Simple Security) |
| User1   | Secret    | DocB   | Confidential   | Write     | **No** (violates *-Property)      |
| User1   | Secret    | DocC   | Secret         | Read      | **Yes** (same level)              |
| User1   | Secret    | DocC   | Secret         | Write     | **Yes** (same level)              |
| User1   | Secret    | DocD   | Unclassified   | Read      | **Yes** (higher clearance)        |

- **Simple Security Property**: User1 cannot read DocA because Top Secret > Secret
- **\*-Property**: User1 cannot write to DocB because Confidential < Secret
- **Both properties allow** operations at the same security level

## Access Control in Code and Taint Analysis

**Taint analysis tracks the flow of untrusted data** through a program to identify potential security vulnerabilities.

### Example of Taint Analysis in Code:

```java
// Tainted input (untrusted)
String userInput = request.getParameter("username");  // TAINTED

// Unsafe operation (SQL Injection vulnerability)
String query1 = "SELECT * FROM users WHERE name = '" + userInput + "'";  // TAINTED

// Safe operation (using parameterized query)
PreparedStatement stmt = connection.prepareStatement("SELECT * FROM users WHERE name = ?");
stmt.setString(1, userInput);  // SANITIZED
```

**In this example**:
- The input from ```request.getParameter()``` is considered tainted
- Direct use of tainted data in SQL creates a vulnerability
- Using parameterized queries sanitizes the input



# Lecture 4

![[Pasted image 20250408195024.png]]
www.example.com and example.com are not the same because www is just a subdomain. 

port 4000 and 5000 are not the same origin since (???)

the part after the domain and port is the same origin, thats literally how websites work.

port 81 and port 80 (http) are not the same.

port 443 (https) and http (80) are not the same.


Security is fun. make sure you do stuff properly
- the user is the enemy
- sanitise your data
- properly protect your routes
- protect your api
- Use a proper cryptographic library
- dont push your auth tokens



# Lecture 5

Access controll
Sanitize your data.
Self-tweeting tweet. tweet deck read text as if it should be executed.


# Lecture 6
A “reminder” / refresher on taint analysis

Lecture 3 at the bottom.


• An example taint analysis of a small program
Lecture 3 at the bottom.


## Uses
- **Tracks untrusted data flow** through applications to detect injection vulnerabilities
- Identifies SQL injection, XSS, and command injection risks
- Operates via static (code analysis) or dynamic (runtime) approaches

## Limitations
- **Misses implicit flows** where tainted data affects control flow indirectly
- **Struggles with custom sanitization** recognition
- **Context insensitivity** issues - same data may be safe or dangerous depending on usage
- **Performance overhead**, especially in dynamic analysis
- **High false positive/negative rates** in complex applications
- **Cannot detect** sophisticated sanitization bypasses or logic-based vulnerabilities

**Best practice**: Use taint analysis as one component of a comprehensive security program rather than relying on it exclusively.

==• Notes on lattices
Lecture 3
• Notes on how to design a (taint-like) analysis
• Notes on how to solve flow equations (even recursive ones)
• Notes on the work list algorithm==


# Lecture 7 and 8 ask teacher

Model checking
* Explicit State Methods
* Abstract Interpretation
![[Pasted image 20250510142307.png]]![[Pasted image 20250510142323.png]]


ask teacher about this one. surely there is a mistake.
![[Pasted image 20250510145151.png]]


