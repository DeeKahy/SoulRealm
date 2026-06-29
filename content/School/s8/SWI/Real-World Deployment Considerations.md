# Additional Real-World Considerations Beyond the Report

Here are factors that would significantly impact deployment but aren't typically covered in academic/project documentation:

## Organisational & Cultural Barriers

| Factor | Impact |
|--------|--------|
| **Formal methods expertise** | Most developers aren't trained in timed automata or model-based testing—steep learning curve |
| **Adoption resistance** | Engineers often prefer familiar tools; formal methods can feel "academic" |
| **Knowledge silos** | If only 1–2 people understand the UPPAAL models, it becomes a liability when they leave |

## CI/CD Integration Challenges

- **Pipeline integration**: How does this slot into Jenkins, GitHub Actions, GitLab CI, etc.?
- **Execution time**: Real-time test execution doesn't scale well for fast feedback loops
- **Containerisation**: Running UPPAAL/TRON in Docker/Kubernetes isn't straightforward
- **Parallelisation**: No mention of running tests concurrently across nodes

## Model Maintenance Burden

- **Model drift**: As code evolves, keeping UPPAAL models synchronised is manual and error-prone
- **Versioning**: How do you track model changes alongside code changes?
- **Code reviews**: Who reviews model correctness if few understand it?

## Alternative Approaches Companies Actually Use

Most companies testing distributed systems use:

- **Jepsen** (industry standard for database/consensus testing)
- **Chaos engineering** (Netflix's Chaos Monkey, Gremlin)
- **Property-based testing** (QuickCheck-style tools)
- **Simulation testing** (FoundationDB's approach)

These are often simpler to adopt and have larger communities.

## ROI Justification

- How many bugs does this catch vs. simpler methods?
- Does the setup time justify the coverage gained?
- Hard to measure "bugs prevented" for management buy-in

## Missing Practical Details

- **Alerting/reporting**: How are failures communicated to the team?
- **Debugging workflow**: When a test fails, how do you trace back to root cause?
- **Documentation**: Onboarding materials for new team members?

---

**Bottom line**: The report focuses on technical feasibility. Real-world adoption fails more often on **people, process, and tooling integration** than on technical limitations.