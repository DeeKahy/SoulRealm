## **Your Understanding/Definition of Security**

**Core Definition**: "The ability of a system to satisfy its goals in the presence of an adversary" 

**Three Critical Questions**:
- What is the **system**? (Define boundaries, scope, context)
- What are the **goals**? (System goals vs. security goals)
- Who is the **adversary**? (Threat modeling)

**Key Insight**: Security is **context-dependent** - secure for whom, against what, for how long, and why 

## **Your Understanding/Definition of Software Security**

**Software Security** applies the same definition but focuses on:
- **System**: The software application and its operational environment
- **Goals**: Functional goals plus security properties (CIA model)
- **Adversary**: Those who can exploit software vulnerabilities

**Security Components** :
- **Security Policies**: High-level business-driven requirements
- **Security Goals**: _What_ you want to achieve (confidentiality, integrity, availability)
- **Security Mechanisms**: _How_ you achieve it (encryption, access control, backups)

Security as an afterthought.
## **CIA Model for Security Goals** 

- **Confidentiality**: Keeping secrets secret (passwords, personal data)
- **Integrity**: Ensuring only authorized changes (bank accounts, medical records)
- **Availability**: Timely access when needed (emergency systems, google (azure))

## **Your Take on Risk Analysis/Management**

**Simple Risk Assessment Framework** :
```
Attack Difficulty vs Impact Matrix:
         Low    Medium   High
Easy     ✓      !!!      !!!
Modest   ✓      ✓        !!!
Difficult ✓     ✓        ✓
```

**Risk Management Process** :
1. Understand business context
2. Identify business and technical risks
3. Synthesize and prioritize risks
4. Define risk mitigation strategy
5. Carry out fixes and validate

**Key Principle**: **Start with high-risk threats** (easy attacks with high impact) 

## **Building Security In - Three Pillars** 

1. **Risk Management**: Foundation for all security decisions
2. **Seven Touchpoints**: 
   - Code review, Architectural review
   - Penetration testing, Risk-based security testing
   - Abuse cases, Security requirements, Security operations
3. **Knowledge**: Stay informed about vulnerabilities, advisories, and best practices

## **Threat Modeling Manifesto** 
1. What are we working on?
2. What can go wrong?
3. What are we going to do about it?
4. Did we do a good enough job?

**Remember**: Security isn't binary - it's about **managing risk within acceptable levels** for your specific context and adversary model .

