#Exercises 
1. Define **security**. Discuss the following topics in your group:  
	1. What does security mean? ==That a system cannot (probably) be abused.==
	2. What does it mean for a system to be secure? ==Can a bad actor/the user do something that we would define as bad.==
	3. What is needed/must be known in order to define security (for a system)?
	4. What is needed/must be known in order to determine if a system is secure? ==We can never know if a system is secure.==
	5. ... what is a system? ==good fucking question==
2. Security properties
	1. What properties of a system characterises security (i.e., what properties should a system have/how should it behave in order to be secure)? ==proper authentication, proper access conatroll, ==
	2. Are those properties both _necessary_ and _sufficient_ for security? 
	3. How difficult is it to examine if/prove that a system has (some of) these properties? ==You can never be 100% sure, so basically impossible==
	4. Is it possible/feasible to _automate_ the process of verifying that a system is secure? ==somewhat by making proper tests==
3. Discuss the pros/cons of the alternative definitions of **security** mentioned in the slides  
4. SolarWinds
	1. Read up on the recent SolarWinds attack and describe it in your own words; make a small illustration showing the systems involved in the attack  ==a security firm got attacked and an update (a dll) was the virus so the virus itself was never run. since the file was larger than x mb most antivirus didnt scan it, and even if they did it was encrypted, but even if that wasnt enough it never an by itself, but instead a trusted application ran this code.==
	2. The attack is an example of a  sophisticated _supply-chain_ attack that involve several different systems and system owners (e.g., attackers systems, SolarWinds systems, victim systems). Discuss what security means/should mean for each of these systems. ==see above==  
	3. Discuss: were any of the security properties you came up with (in question 2) broken in the attacked system(s)?
	4. Discuss: How/where/when could/should the attack have been prevented/stopped? ==everywhere?, the cyber firm couldve been more on point with what they are doing, anti virus could scan bigger files, windows could update the security of dll files==
5. Log4Shell: repeat Exercise 4 but for the **log4shell** vulnerability. ==apache couldve silently roled out a fix, the developers of log4j couldve been competent and realize that downloading everything isnt a smart idea, proper data type handeling, software can keep track of what fucking libraries they use==
6. Investigate the security of one of your own projects (for example a previous semester project or an open source project you contributed to)
	1. Use the course definition of security on your chosen project. In particular  
		1. Define the system  
		2. Define the system context
		3. Define the potential threats
	2. Formulate specific security goals/properties for your system
	3. Discuss how to attack your system (if possible (and legal), try it out!)