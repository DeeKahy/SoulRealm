- We define scheduling problems.
- We define schedulability.
- We study cyclic schedules.
- We study earliest first scheduling and fixed priority scheduling.
- We perform schedulability analysis in UPPAAL.



**Cyclic Scheduling**

1. For the following systems, construct a cyclic executive, if possible(!), to shedule all tasks:
    
    1. P (period 3ms, cost 1ms), Q (period 6ms, cost 2ms), S (perioed 18ms, cost 5ms)
    2. P (period 100ms, cost 30ms), Q (period 5ms, cost 1ms), S (period 25ms, cost 5ms)
    3. P (period 50ms, cost 10ms), Q (period 40ms, cost 10ms), Q (period 30ms, cost 9ms)
    
2. Use UPPAAL for computing cyclic executives for the 3 task sets above.  You may want to use the following example UPPAAL model ([CyclicTasks.xml](https://www.moodle.aau.dk/pluginfile.php/3607925/mod_folder/intro/CyclicTasks.xml "CyclicTasks.xml")) and UPPAAL query ([CyclicTasks.q](https://www.moodle.aau.dk/pluginfile.php/3607925/mod_folder/intro/CyclicTasks.q "CyclicTasks.q")).
3. For each of the tasksets above, calculate the processor _utilisation_, i.e., how much the processor is used, for each task (P, Q, S) and the total utilisation of the taskset.
4. For each of the tasksets above, add a new task, R, with period 50ms but with variable execution time from 5ms to 25ms, construct (if possible) cyclic executives for each taskset.  Again, consult UPPAAL.

**Utilization Analysis & Response Time Analysis **

- For the following systems, perform schedulability analysis through utilisation test under the assumption of Fixed-Priority Scheduling:  
    1. P (period 3ms, cost 1ms),  
        Q (period 6ms, cost 2ms),  
        S (perioed 18ms, cost 5ms)
    2. P (period 100ms, cost 30ms),  
        Q (period 5ms, cost 1ms),  
        S (period 25ms, cost 5ms)
    3. P (period 50ms, cost 10ms),  
        Q (period 40ms, cost 10ms),  
        S (period 30ms, cost 9ms)
    4. For any of the above tasksets that _fails_ the utilisation test, determine (by example/brute force) if the system can be scheduled using FPS.
    5. Use utilisation test to determine which, if any, of the above tasksets can be scheduled using Earliest Deadline First scheduling.
    6. For each of the tasksets above, add a new task, R, with period 50ms but with variable execution time from 5ms to 25ms,  
        and perform utilisation test. For any taskset that fails, determine if the taskset can be scheduled using FPS anyway. Argue why/why not.

- For the following systems, perform _response time analysis_ under the assumptions of the Simple Process Model and Fixed-Priority Scheduling:  
    1. P (period 3ms, cost 1ms),  
        Q (period 6ms, cost 2ms),  
        S (period 18ms, cost 5ms)
    2. P (period 100ms, cost 30ms),  
        Q (period 5ms, cost 1ms),  
        S (period 25ms, cost 5ms)
    3. P (period 50ms, cost 10ms),  
        Q (period 40ms, cost 10ms),  
        S (period 30ms, cost 9ms)
- For the systems above use UPPAAL to check schedulability as well as response time analysis using FPS.  You may want to use the following models ([fps.xml](https://www.moodle.aau.dk/pluginfile.php/3607925/mod_folder/intro/FPS2.xml "fps.xml")) and queries ([fps.q](https://www.moodle.aau.dk/pluginfile.php/3607925/mod_folder/intro/FPS2.q "fps.q")).