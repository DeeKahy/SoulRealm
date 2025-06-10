
- You are asked to provide a very brief report about how you solved the tasks below. There is no need to write any introduction or any additional text, just answer all the tasks below and copy and paste your implementations directly into the report. The report should be delivered as a PDF document.
- You will work in your designated group (same as exercise sessions). Write the names, email addresses at aau.cs.dk and _student numbers_ of all members of your group on the front page of your report. 
- The solutions of different groups must be independent and sharing parts of the code or the text of the report is strictly forbidden.
- Time allocated for the mini-project: Exercise part of Session 8 (Wednesday March 7) and whole Session 9 (Wednesday April 3), altogether 5½ supervised hours.

Before you start working on this mini-project, it is assumed that

- you read the tutorial notes on UPPAAL by Vandraager, David and Larsen.
- you have installed an can run the UPPAAL tool on your lap-top. UPPAAL may be downloaded from [www.uppaal.org.](http://www.uppaal.com/ "Opens external link in new window")

#### **Buzzing Boys Protocol**

In this mini-project you are asked to model and analyze the following buzzing boys problem in UPPAAL. A number of boys initially know one distinct secret each. Each boy has access to a phone which can be used to call another boy to share their secrets. Each time two boys talk to each other they always exchange all secrets with each other (thus after the phone call they both know all secrets they knew together before the phone call). The boys can communicate only in pairs (no conference calls) but it is possible that different pairs of boys talk concurrently. For all of the tasks below you should consider the following two scenarios:

1. Scenario 1: the boys are organized in a _linear chain (with a first and last person)_ restricting calls to be made between neighboring boys.
2. Scenario 2: all boys may directly call any other person, thus the telephone network is a total graph.

As optional scenarios you may also consider the following two alternative topologies of the telephone net between the boys:

1. Optional Scenario 3: the boys are organized in a _circular chain._
2. Optional Scenario 4: only a single call in the entire net can take place at a time.

**Here is what your tasks are:**

1. Model the problem as a network of UPPAAL timed automata. Describe the idea behind your model (variables, channels, clocks, timed automata, C-code, ..), especially how the behaviour of a person is modelled and how the topology (Scenario 1 and 2, possibly Scenarios 3 and 4) is modelled.
2. Use UPPAAL to find the **minimal number** of phone calls needed for four boys to know all secrets for both Scenario 1 and Scenario 2 (and possibly Scenario 3 and 4).
3. Refine your model so that each phone call lasts exactly 60 seconds (for simplicity this time duration is irrelevant of the number of exchanged secrets). Find the **minimum time** needed to solve the buzzing boys problem for four boys for both Scenario 1 and Scenario 2 (and possibly Scenario 3 and 4).
4. Experiment with the UPPAAL search options breath-first search, depth-first search, random-depth-first search, upper and lower approximations, and with the diagnostic trace settings fastest and shortest. Try to solve the problem for five boys.
5. Use (and report on) UPPAAL's message sequence chart for illustrating the solutions.  
    
6. Finish your report by briefly commenting on what was your experience working with UPPAAL. You should all submit a solution. So if you are in a group with 3 members, all of you submit the solutions.

**HINTS:**

- Download UPPAAL from www.uppaal.com.
- Design a single template for all boys.
- For each boy, you may choose to remember the currently known secrets either in a local array of Booleans or using an integer variable (use a binary encoding such that if a boy knows the secrets of e.g. boy 1 and boy 3 but does not know the secrets of boy 2 and boy 4, the value in the integer variable will be (0101) binary = 5; you might find the operation **|** for a bitwise OR useful).
- In order to model value passing when two boys make a phone call, you may use a shared variable and utilize that in a synchronization, the update of the outputting component precedes the update of the inputting component.  Alternatively you can use channel-arrays as in the Train Gate model that comes with the down load of UPPAAL.





# Start


![[Pasted image 20250610122251.png]]



































