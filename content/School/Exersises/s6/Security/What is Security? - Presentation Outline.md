## **Definition of Security**
- **Core Definition**: "The ability of a system to satisfy its goals in the presence of an adversary"
- **Key Questions**: What is the system? What are the goals? Who is the adversary?

## **Defining the System**
Before securing anything, establish clear boundaries:
- **System Scope**: What's included vs. excluded (network perimeter, physical access, human elements)
- **Critical Assets**: Data, services, reputation, physical infrastructure that need protection
- **Stakeholders**: Users, administrators, business owners, regulators - each with different security needs
- **Example**: Banking app system = mobile app + backend servers + user devices; excludes bank's internal HR systems

## **Identifying the Adversary**
Understanding your threat actors shapes your entire security strategy:
- **Adversary Types**: Script kiddies (automated tools), organized criminals (financial motivation), nation-states (espionage/disruption), insider threats (privileged access), competitors, users
- **Motivations**: Financial gain (ransomware), espionage (state actors), disruption (hacktivists), personal grudges (disgruntled employees)
- **Capability Levels**: Ranges from basic automated attacks to sophisticated APT groups with unlimited time and resources

## **CIA Model - Security Goals**
Your security policies define what matters, mechanisms implement protection:
- **Confidentiality**: Keeping secrets... secret - *policies* define what's classified, *encryption mechanisms* protect it (passwords, personal data)
- **Integrity**: Ensuring only authorized changes - *access control policies* define permissions, *digital signatures* verify authenticity (bank accounts, medical records)
- **Availability**: Timely access when needed - *SLA policies* define uptime requirements, *redundancy mechanisms* ensure service (MitID, emergency systems, google)

## **Threat Modeling Process** (Manifesto)
Systematic approach to security decision-making:
1. **What are we working on?** → Define system boundaries and assets
2. **What can go wrong?** → Identify threats based on adversary capabilities
3. **What are we going to do about it?** → Select appropriate security mechanisms
4. **Did we do a good enough job?** → Measure against security goals (Admiration for the Problem)

## **Risk Management & Investment Decisions**
Security mechanisms are investments - cost must match risk level:

```
Impact →     Low    |   Med   |  High
Easy         ✓      |   !!!   |  !!!
Modest       ✓      |    ✓    |  !!!  
Difficult    ✓      |    ✓    |   ✓
↑ Attack Difficulty
```

- **Tradeoff Example**: Home design balances aesthetics (windows at eye level) vs. security (higher windows or bars)
- **Development Reality**: Most systems initially prioritize functionality over security - prototypes focus on "does it work?" not "is it secure?"
- **Investment Questions**: Is it worth spending on fuzzing, taint analysis, penetration testing? Depends on your adversary model and asset value.

## **Security as an afterthought**
-  Security has always been a lower priority.
- if you are trying to get something out of the door you often forgetti about the security aspects



## **Context is Everything**
Security is **context-dependent** - what's secure for a coffee machine differs drastically from hospital life-support systems. Always define: secure **for whom** (stakeholders), **against what** (specific threats), **for how long** (threat evolution), and **why** (business justification).

*Remember: Security isn't binary - it's about managing risk within acceptable levels for your specific context and adversary model.*

