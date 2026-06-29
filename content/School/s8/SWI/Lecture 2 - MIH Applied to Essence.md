# Exercise 1 – MIH Applied to Essence

## What problem are you working on?

Tenants in Denmark lack a structured, tamper-proof method for documenting the condition of a rental apartment upon move-in. This leaves them vulnerable to wrongful deposit deductions at the end of a tenancy. With approximately 1,000 court cases annually and deposits reaching up to 32,000 DKK, the problem has significant financial and emotional consequences. The asymmetry of information between landlords and tenants - landlords often provide incomplete or vague inspection reports - is the core of the problem.

---

## Type of Innovation (Table 1.1)
![[Pasted image 20260430224112.png]]
MIH is primarily a **Product innovation** - it is a new mobile application that did not exist before in this form. It also contains elements of **Position innovation**: existing technologies (floor plan scanning, cloud storage, image capture) are recombined into a new context - tenant move-in documentation - where they previously weren't applied together. There is no paradigm shift involved; the market and users are already defined.

---

## Keystones — What Will Make the Design Stand Out?

The design's distinguishing elements are:

- **Spatially-anchored documentation** — images are pinned to specific locations on a floor plan, not just stored in a gallery. This provides structural clarity that generic photo apps do not.
- **Server-side tamper-proof timestamping** — the server generates all timestamps, meaning tenants cannot alter them after the fact. This provides a form of third-party verification.
- **ARCore-based floor plan creation** — tenants who receive no floor plan from their landlord can generate one themselves using SLAM. This removes a key barrier to structured documentation.
- **Cross-platform availability** — unlike MagicPlan and CamPlan (iOS only), MIH targets a broader user base.
- **Tenant focus** — unlike MagicPlan, which is built for professional property managers, MIH is designed around the needs and workflow of a first-time renter.

---

## Who Benefits — What Value Is Created?

**Primary beneficiaries**: Tenants, who gain a little bit of financial protection (at most 32,000 DKK), reduced anxiety, a backup of all their data on a server, so no matter what they use they will always be able to find it again, and a structured process during a stressful life event.

**Secondary beneficiaries**: Landlords with good intent, who now have a shared and organized record of the apartment's condition, reducing ambiguity and preventing disputes from arising in the first place.

**Tertiary beneficiaries**: Courts and housing dispute boards, which receive better-quality evidence when cases do reach them.

The value created is both financial (protecting the deposit) and psychological (reducing the uncertainty and anxiety of the move-in process through structure and clarity).

---

## Where Will It Be Used — How Will It Create Change?

MIH is used **at the moment of move-in**, physically inside the apartment, by the tenant. The change it creates is a shift in the power balance: tenants — traditionally the weaker party in landlord disputes — gain a credible, structured, and timestamped record that discourages wrongful deductions. At scale, MIH could normalize tenant-led documentation as a standard step in the Danish rental process, reducing the 1,000+ annual court cases and making the rental market more transparent.

---

## VUCA Characterization (Section 1.2)

**Volatility**: Rental laws (e.g., Denmark's _Lejeloven_) can be updated; smartphone APIs like ARCore evolve and may introduce breaking changes; camera capabilities improve, changing quality expectations.

**Uncertainty**: It is unclear whether the app's server-side timestamping will be accepted as credible evidence in court. It is also uncertain whether tenants will actually use the app consistently or abandon it mid-inspection.

**Complexity**: The system involves multiple interacting parts — mobile client, backend server, ARCore SLAM, image metadata, floor plan state management, and blur detection — each introducing failure points. Beyond technical complexity, the problem also involves legal, organizational, and behavioral dimensions.

**Ambiguity**: What counts as "damage"? What level of blur is too blurry? Is a tenant-operated floor plan accurate enough to be meaningful? These are questions where causes and effects are not clearly separable, and the answers depend on context and interpretation.

---

## Demand-Pull or Technology-Push?

MIH is primarily **demand-pull**. The driving force is a real, documented problem: deposit disputes harm tenants financially, and no accessible tool exists to address this. The 1,000 court cases and the deposit amounts quantify the demand.

However, there is also a **technology-push** component. ARCore's SLAM capabilities — which allow ordinary smartphones to create spatial maps — make it technically feasible for tenants to build floor plans without professional equipment. Without this technology maturing, the floor plan creation feature would be impractical for MIH's target users. In other words: the demand existed before the technology, but the technology is what makes the specific solution viable.

---

## Roles — Relevance, When, Pros and Cons

The four Essence roles are relevant to MIH, though the team's background (primarily backend developers) creates some natural tensions:

**Responder**: The natural fit for the development team. Takes a technological perspective — proposes ARCore for floor plans, designs the server-side tamper-proofing, implements blur detection. Responsible for exploring what is technically feasible.

**Challenger**: Should represent the tenant's perspective — does a tenant actually want to create a floor plan? Is blur detection helpful or frustrating? Is the dual control scheme in the floor plan view adding value or confusion? The challenger is critical for keeping the scope aligned with real tenant needs, not technical possibilities. _Problem in your project_: since the whole team is technically oriented, the challenger perspective may be systematically underrepresented.

**Anchor**: Coordinates evaluation efforts — the user test described in your paper falls under the anchor's responsibility. Decides when features are sufficient, manages the relationship with supervisors and external feedback. Ensures that hypotheses about the design's value are actually tested.

**Child**: The creative, unconstrained explorer. Could question whether ARCore is the right approach to floor plans (what about a manual sketch tool?), suggest that landlords be invited into the app too, or propose that AI be used to automatically detect damage from photos. The child role is valuable for preventing early fixation on ARCore or the current architecture.

**Pros of using roles:**

- Forces diverse thinking within a technically homogeneous team
- The challenger role prevents over-engineering by anchoring decisions to user value
- The anchor role structures evaluation (which your user test currently lacks rigor in)
- The child role could have questioned the dual control scheme before it confused the test user

**Cons:**

- Small teams struggle to hold roles consistently — developers slip into responder mode by default
- The challenger requires deep problem-domain knowledge (tenant law, renter behavior) that the team may not have
- Roles can feel performative in a student context if they are not genuinely embedded in the team dynamic
---

## Mini-Project Relevance

So relevance is mostly from leons deal, and it is literally all the things i just talked about


---

# Chapter 3 & 4 — Relevant Terms and Mini-Project Relevance

## Key Terms

**Problem–Solution Canvas (PSC)**: A 12-block visual inquiry tool that structures the overall design concept across rationale, strategy, and tactics. Applied to MIH, it would look like this in outline:
![[Pasted image 20260430225440.png]]

| Block                                   | MIH Content                                                                                                                                                                                                                                         |
| --------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Problem**                             | Tenants lack structured, tamper-proof move-in documentation                                                                                                                                                                                         |
| **Outer Environment**                   | Rental housing market, Danish _Lejeloven_, smartphones (iOS + Android), landlords, housing dispute boards                                                                                                                                           |
| **Manifestations**                      | Missing or vague inspection reports, undocumented pre-existing damage, photos with no spatial context, easily disputed image timestamps                                                                                                             |
| **Capabilities**                        | Floor plan creation (ARCore), image capture with metadata, spatial pinning of images, blur detection, server-side timestamping                                                                                                                      |
| **Inner Environment**                   | Client-server architecture; ARCore module; image storage backend; blur detection module                                                                                                                                                             |
| **Leverage**                            | ARCore/SLAM (crafted interface, not trivially available); server-side timestamping; cross-platform development framework                                                                                                                            |
| **Solution (Prospect/Warrant/Backing)** | _Prospect_: MIH helps tenants document move-in condition in a structured and verifiable way. _Warrant_: Deposit disputes are financially significant and widespread. _Backing_: The app is accessible, free, and requires no professional expertise |
| **Evolvability**                        | Low diffusibility into radically new markets; moderate adoptability within the rental market; potential expansion to European rental markets or commercial tenancy                                                                                  |
| **Merit (Value/Reservation/Rebuttal)**  | _Value_: Protection of deposits, reduced disputes. _Reservation_: No formal legal recognition of the timestamping mechanism. _Rebuttal_: Informal documentation still deters bad-faith landlords and strengthens tenants' negotiating position      |
| **Mission**                             | Attract and retain tenants by demonstrably reducing their risk of wrongful deposit loss                                                                                                                                                             |
| **Potential**                           | Modular architecture allows new capabilities (e.g., landlord side, AI damage detection); scalable backend                                                                                                                                           |
| **Horizon**                             | A rental market in Denmark where tenant-led move-in documentation is standard practice; the team develops expertise in AR-based spatial documentation and tamper-proof mobile systems                                                               |

---

**Manifestation Fulcrum**: This is MIH's starting point. The project began from the perceived problem — tenants losing deposits — and its visible manifestations (missing reports, undocumented damage). This is the most appropriate Fulcrum category for your project, as described in Section 4.2.


**Capability Fulcrum** — Start from what your team _can build_ (your leverage/tech), then find a problem worth solving with it. _"We have ARCore, where can we apply it usefully?"_

**Merit Fulcrum** — Start from a bold value claim about what would be _significantly better_ than existing solutions, then check if it's actually buildable and adoptable. _"What if tenants could prove apartment condition as credibly as a notarized document, using only their phone?"_

**Mission Fulcrum** — Start from a concrete, measurable performance goal, then work backward to what capabilities and design you'd need to hit it. _"Can a tenant fully document an apartment in under 20 minutes with no prior instruction?"_



**Leverage**: ARCore is a leverage point in the Essence sense because it requires a crafted interface and provides an edge over generic photo apps. Not everyone can build a functional SLAM-based floor plan tool — this is what distinguishes MIH technically from simpler competitors. The server-side timestamping is also leverage: it is an architectural decision that adds verifiability that generic cloud storage does not.

**Evolvability**: MIH has low diffusibility toward radically new markets (it is specialized for residential rental move-in), but moderate adoptability in adjacent contexts: commercial tenancies, student housing, short-term rentals, or other countries with similar deposit dispute cultures. The modular architecture supports adding a landlord-facing view or integrating with existing rental platforms.

**Merit**: The key reservation is that MIH's tamper-proofing relies on a server operated by the development team — a landlord or court could challenge the independence of this verification. The rebuttal is that even informal, well-organized documentation changes the negotiating dynamic and deters bad-faith deductions before disputes reach court.

