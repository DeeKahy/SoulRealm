This report presents experiments on binary sentiment classification using the IMDB movie review dataset with Word2Vec embeddings. All experiments were conducted across 5 runs with different random seeds, reporting mean accuracy ± standard deviation.

# Architectural Choices

**Fixed parameters:** Learning rate 1e-3, batch size 64, epochs 10, min_df=0.0005, max_df=0.5

## Hidden Layers

| Architecture                 | Accuracy (mean ± std) |
| ---------------------------- | --------------------- |
| Linear: 300→2                | 0.8309 ± 0.0005       |
| 1 layer: 300→(128)→2         | 0.8598 ± 0.0009       |
| 2 layers: 300→(256→128)→2    | 0.8611 ± 0.0007       |
| 3 layers: 300→(256→128→64)→2 | 0.8613 ± 0.0005       |
| Bottleneck: 300→(10)→2       | 0.8545 ± 0.0010       |

Adding the first hidden layer provides a 2.9% improvement, but additional layers offer fewer and fewer returns (<0.2% difference). Even a bottleneck with only 10 neurons achieves 85.45%, suggesting the task requires only a compact internal representation.

## Activation Functions

| Activation | Accuracy (mean ± std) |
| ---------- | --------------------- |
| ReLU       | 0.8598 ± 0.0009       |
| Tanh       | 0.8595 ± 0.0005       |
| LeakyReLU  | 0.8607 ± 0.0009       |

Activation function choice has negligible impact (0.12% difference), within standard deviation.

---

# Learning Configurations

**Fixed parameters:** Architecture 300→128→2 (ReLU), min_df=0.0005, max_df=0.5

## Learning Rate

| Learning Rate | Accuracy (mean ± std) |
| ------------- | --------------------- |
| 0.0001        | 0.8437 ± 0.0006       |
| 0.0005        | 0.8577 ± 0.0012       |
| 0.001         | 0.8598 ± 0.0009       |
| 0.01          | 0.8609 ± 0.0010       |

Learning rate shows the clearest impact: 0.0001 underperforms by 1.7% due to insufficient convergence in 10 epochs. The 0.001–0.01 range works well.

## Batch Size

| Batch Size | Accuracy (mean ± std) |
| ---------- | --------------------- |
| 16         | 0.8613 ± 0.0005       |
| 32         | 0.8611 ± 0.0011       |
| 64         | 0.8598 ± 0.0009       |
| 128        | 0.8587 ± 0.0012       |
| 256        | 0.8566 ± 0.0005       |

Smaller batches perform slightly better (~0.5% difference) due to more gradient updates per epoch, but the effect is minor.

## Epochs

| Epochs | Accuracy (mean ± std) |
| ------ | --------------------- |
| 5      | 0.8566 ± 0.0008       |
| 10     | 0.8598 ± 0.0009       |
| 15     | 0.8618 ± 0.0003       |
| 20     | 0.8623 ± 0.0004       |

Accuracy improves steadily up to 20 epochs with no overfitting observed for this simple architecture.

---

# Dictionary Cutoff Frequencies

**Fixed parameters:** Architecture 300→128→2 (ReLU), lr=1e-3, batch size 64, epochs 10

## Minimum Document Frequency

| min_df | Vocab Size | Missing Embeddings | Accuracy (mean ± std) |
| ------ | ---------- | ------------------ | --------------------- |
| 0.0001 | 35,827     | 5,624              | 0.8598 ± 0.0008       |
| 0.0005 | 15,862     | 1,145              | 0.8598 ± 0.0009       |
| 0.001  | 10,430     | 502                | 0.8587 ± 0.0007       |
| 0.002  | 6,441      | 186                | 0.8572 ± 0.0008       |

Despite 6× vocabulary size difference, accuracy varies only 0.26%. Lower min_df includes more words without Word2Vec coverage, but the averaged embedding approach is robust to this noise.

## Maximum Document Frequency

| max_df | Vocab Size | Accuracy (mean ± std) |
| ------ | ---------- | --------------------- |
| 0.3    | 15,827     | 0.8589 ± 0.0007       |
| 0.5    | 15,862     | 0.8598 ± 0.0009       |
| 0.7    | 15,877     | 0.8588 ± 0.0003       |
| 0.9    | 15,883     | 0.8588 ± 0.0011       |

max_df has negligible effect (~0.1% difference, ~56 words removed). Common words contribute little to averaged embeddings.

---

# Additional Experiments

## Word2Vec vs Random Embeddings

| Embedding Type | Accuracy (mean ± std) |
| -------------- | --------------------- |
| Word2Vec       | 0.8582 ± 0.0027       |
| Random         | 0.7425 ± 0.0006       |

Word2Vec outperforms random embeddings by **11.6 percentage points**—the largest effect observed. This explains why architectural choices matter little: the pretrained embeddings already encode rich semantic information, making the neural network's task straightforward.

## Overfitting Detection

| Model       | Epochs | Best Accuracy   | Best Epoch  | Final Accuracy  |
| ----------- | ------ | --------------- | ----------- | --------------- |
| Simple      | 50     | 0.8639 ± 0.0004 | 40.2 ± 8.8  | 0.8600 ± 0.0035 |
| Simple      | 100    | 0.8639 ± 0.0004 | 40.2 ± 8.8  | 0.8543 ± 0.0029 |
| Deep/Wide   | 30     | 0.8622 ± 0.0007 | 11.4 ± 4.4  | 0.8506 ± 0.0038 |
| Deep/Wide   | 50     | 0.8622 ± 0.0007 | 11.4 ± 4.4  | 0.8412 ± 0.0029 |

Simple model (300→128→2) peaks at epoch 40, declining ~1% by epoch 100. Deep model (300→512→256→128→2) peaks at epoch 11, declining ~2% by epoch 50. Simpler models overfit slower and achieve higher peak accuracy.

---

# Conclusion

**Key findings:**
1. **Pretrained embeddings dominate** — Word2Vec provides 11.6% improvement over random embeddings, explaining why architecture matters little.
2. **Complexity provides minimal benefit** — Single hidden layer achieves nearly identical accuracy to deeper networks while resisting overfitting.
3. **Learning rate is most sensitive** — Too low (0.0001) causes 1.7% drop; other hyperparameters show <0.6% effects.
4. **Dictionary cutoffs negligible** — Vocabulary size varies 6× with only 0.26% accuracy change.

**Recommended configuration:** Single hidden layer (128 neurons), ReLU, learning rate 0.001, batch size 32–64, 30–50 epochs with early stopping → ~86% accuracy.
