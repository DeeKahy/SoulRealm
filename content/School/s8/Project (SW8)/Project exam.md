**Blur Detection — the algorithm (slide 48)**
"Blurry photos are a real problem here: they can be uploaded without the user noticing, but they're useless as evidence in a deposit dispute. So we detect blur automatically using the _variance of Laplacian_. For every pixel we take a weighted greyscale value, compute the Laplacian — the centre pixel minus its four neighbours — and then take the variance across the whole image. That variance is our blur score: high contrast between neighbouring pixels means sharp edges and a high score; a low score means the image is likely blurry. One practical detail: on a full 12-megapixel image this took up to 45 seconds, so we resize every image to 250 by 250 first, which brings it down to about half a second. On our 29-image test set you can see the separation clearly — sharp images average around 800, blurry ones around 100 — and that gap is what lets us pick a threshold."

---

**Blur Detection — conclusion (slide 49)**

"From that data we set the threshold at 250. We deliberately tuned it to catch _every_ blurry image — zero false negatives across all ten blurry photos — because a missed blurry photo is worse than an extra warning. The trade-off is five false positives: brightly lit scenes with very few hard edges score low and get flagged even though they're sharp. And that trade-off is unavoidable — because the highest-scoring blurry image actually scored higher than the lowest sharp one, no single threshold can perfectly separate the two. So our conclusion is that blur detection works reliably for its purpose: the occasional false alarm on a high-contrast scene is acceptable, since we never let a genuinely blurry image through, and at half a second per image it's fast enough to run on every upload."

---

**AR Accuracy — experiments (slide 50)**

"To trust the floor plans, we had to test how accurately the AR measures distance. Two experiments. First, a fixed-distance test: we measured a known 300-centimetre reference ten times on a Samsung Galaxy S20+. The average came out at 299.19 centimetres — an average error of just 2.14 centimetres, or 0.8 percent, with all readings falling in a 7.5-centimetre spread. Second, a full-room scan: a room of 480 by 405 centimetres, measuring all four walls across several attempts. We _expected_ error to accumulate as we added more hit points and scanned longer — but the per-wall errors stayed low and consistent, between about 2.3 and 2.8 centimetres each, for a total room deviation of around 10 centimetres."

---

**AR Accuracy — conclusion (slide 51)**

"So what does that mean? The measurements are well within the margin we need for floor-plan documentation. 2.14 centimetres of error on a single wall is 0.8 percent; the 10-centimetre deviation across a room is only about 0.6 percent of nearly 18 metres of total wall length. The interesting finding is that multi-point scanning was no worse than the single-distance test — tracking drift didn't accumulate the way we predicted. The main caveat is environmental sensitivity: clutter and featureless walls degrade tracking, and one user even placed a hit point against an upper window that landed metres below the floor. The plan can look slightly crooked up close, but for the task — knowing roughly where damage is in the room — it's more than accurate enough."

---

**Usability Test — setup and procedure (slide 52, first user-test slide)**

"To validate usability we ran a test with six participants — fellow students. We set up a room with sticky notes labelled 'damage' to simulate the real condition of a property at move-in. Crucially, we gave them _no_ prior instruction on how the app works, and a realistic framing: 'You're moving into this place — document its condition.' Each person worked through the same sequence of tasks: first create a floor plan, either by uploading an existing one or scanning the room with AR; then capture a photo of each 'damage' sticky note; and finally pin each image to its location on the plan with metadata. We only stepped in to help if a participant genuinely couldn't proceed — so that we could see where the app explains itself and where it doesn't."