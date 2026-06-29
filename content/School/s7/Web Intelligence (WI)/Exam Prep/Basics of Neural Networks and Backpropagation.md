This report presents experiments on binary sentiment classification using the IMDB movie review dataset. Neural network models were trained using document representations constructed from pre-trained Word2Vec embeddings. The experiments examine the impact of architectural choices, learning configurations, and vocabulary cutoff parameters on classification accuracy. All experiments were conducted across 5 runs with different random seeds, reporting mean accuracy ± standard deviation.

# How Accuracy is Affected by Architectural Choices

This section examines how different neural network architectural choices affect sentiment classification performance on the IMDB dataset.

**Variables tested:**
- Number of hidden layers: 0, 1, 2, 3 layers
- Neurons per layer: 10 (bottleneck), 128, 256→128, 256→128→64
- Activation functions: ReLU, Tanh, LeakyReLU

The hypothesis is that deeper networks might capture more complex patterns, but too many layers could lead to overfitting or vanishing gradients.

**Fixed hyperparameters for fair comparison:**
- Learning rate: 1e-3
- Batch size: 64
- Epochs: 10
- Dictionary: min_df=0.0005, max_df=0.5

## Number of Hidden Layers

| Architecture                       | Accuracy (mean ± std) |
| ---------------------------------- | --------------------- |
| Linear (0 hidden): 300→2           | 0.8309 ± 0.0005       |
| 1 hidden layer: 300→128→2          | 0.8598 ± 0.0009       |
| 2 hidden layers: 300→256→128→2     | 0.8611 ± 0.0007       |
| 3 hidden layers: 300→256→128→64→2  | 0.8613 ± 0.0005       |
| Bottleneck: 300→10→2               | 0.8545 ± 0.0010       |

The results show a clear pattern: adding the first hidden layer provides a significant boost (from 83.09% to 85.98%, approximately 2.9%), but additional layers offer diminishing returns. The difference between 1, 2, and 3 hidden layers is less than 0.2%, which is comparable to the standard deviation between runs.

The linear model (no hidden layers) performs noticeably worse because it cannot learn non-linear decision boundaries. However, even this simple model achieves 83% accuracy, demonstrating how much information is already encoded in the Word2Vec embeddings.

The bottleneck architecture with only 10 neurons still achieves 85.45%, surprisingly close to larger architectures. This suggests the sentiment classification task can be solved with a very compact internal representation.

## Activation Functions

| Activation | Accuracy (mean ± std) |
| ---------- | --------------------- |
| ReLU       | 0.8598 ± 0.0009       |
| Tanh       | 0.8595 ± 0.0005       |
| LeakyReLU  | 0.8607 ± 0.0009       |

The choice of activation function has virtually no impact on final accuracy. The difference between the best (LeakyReLU at 86.07%) and worst (Tanh at 85.95%) is only 0.12%, which is within the standard deviation of the measurements.

This result is expected given the simplicity of the network. For deeper architectures, activation function choice becomes more important due to vanishing gradient issues, but for a single hidden layer, all three activations perform equivalently.

# How Different Learning Configurations Affect the Results

This section examines how different hyperparameter configurations impact model training and final accuracy while keeping the architecture constant.

**Variables tested:**
- Learning rate: 0.0001, 0.0005, 0.001, 0.01
- Batch size: 16, 32, 64, 128, 256
- Epochs: 5, 10, 15, 20

**Hypotheses:**
- Too low learning rates will converge slowly; too high will cause instability
- Smaller batch sizes provide noisier gradients but may converge faster per epoch
- More epochs allow better convergence but risk overfitting

**Fixed parameters for fair comparison:**
- Architecture: 1 hidden layer (128 neurons), ReLU activation
- Dictionary: min_df=0.0005, max_df=0.5

## Learning Rate Impact

| Learning Rate | Accuracy (mean ± std) |
| ------------- | --------------------- |
| 0.0001        | 0.8437 ± 0.0006       |
| 0.0005        | 0.8577 ± 0.0012       |
| 0.001         | 0.8598 ± 0.0009       |
| 0.01          | 0.8609 ± 0.0010       |

The learning rate shows the clearest impact of any hyperparameter tested. The lowest learning rate (0.0001) significantly underperforms at 84.37%, approximately 1.7% worse than optimal. This confirms that very low learning rates fail to converge within 10 epochs.

Interestingly, the highest learning rate (0.01) performs best at 86.09%, slightly outperforming 0.001. This contradicts the initial expectation that high learning rates would cause instability. For this simple architecture and dataset, even aggressive learning rates work well.

The practical takeaway is that anything in the 0.001–0.01 range works well, but 0.0001 is too conservative for 10 epochs of training.

## Batch Size Impact

| Batch Size | Accuracy (mean ± std) |
| ---------- | --------------------- |
| 16         | 0.8613 ± 0.0005       |
| 32         | 0.8611 ± 0.0011       |
| 64         | 0.8598 ± 0.0009       |
| 128        | 0.8587 ± 0.0012       |
| 256        | 0.8566 ± 0.0005       |

Smaller batch sizes perform slightly better, with batch size 16 achieving 86.13% compared to 85.66% for batch size 256. This difference of approximately 0.5% is small but consistent across runs.

The trend is expected: smaller batches perform more gradient updates per epoch, allowing faster convergence. With batch size 16, the model performs 1,562 gradient updates per epoch, compared to only 97 updates with batch size 256.

However, the absolute differences are small enough that batch size selection can be based on computational convenience rather than accuracy optimization.

## Number of Epochs Impact

| Epochs | Accuracy (mean ± std) |
| ------ | --------------------- |
| 5      | 0.8566 ± 0.0008       |
| 10     | 0.8598 ± 0.0009       |
| 15     | 0.8618 ± 0.0003       |
| 20     | 0.8623 ± 0.0004       |

The model continues to improve with more epochs, going from 85.66% at 5 epochs to 86.23% at 20 epochs. Notably, there is no sign of overfitting at 20 epochs—the standard deviation actually decreases (from 0.0008 to 0.0004), suggesting more stable convergence.

This indicates that the model architecture is simple enough that it does not easily memorize the training data. With a deeper or wider network, overfitting would likely occur sooner.


### Summary of Learning Configuration Experiments

The most impactful parameter was learning rate when set too low (0.0001), causing a 1.7% accuracy drop. The other parameters showed differences of 0.3–0.6%, which while statistically significant, are relatively minor in practical terms.

# Dictionary Cutoff Frequencies

This section investigates how vocabulary cutoff thresholds (min_df and max_df) in the CountVectorizer affect model performance. These parameters control which words are included in the feature vocabulary.

**Variables tested:**
- min_df (minimum document frequency): 0.0001, 0.0005, 0.001, 0.002
- max_df (maximum document frequency): 0.3, 0.5, 0.7, 0.9

**Hypotheses:**
- Too low min_df includes noisy rare words that do not generalize
- Too high min_df loses important sentiment-specific words
- max_df controls removal of very common words (stopwords)

**Fixed hyperparameters:**
- Architecture: 1 hidden layer (128 neurons), ReLU
- Learning rate: 1e-3
- Batch size: 64
- Epochs: 10

## Minimum Document Frequency (min_df)

| min_df | Vocab Size | Words Not Found | Accuracy (mean ± std) |
| ------ | ---------- | --------------- | --------------------- |
| 0.0001 | 35,827     | 5,624           | 0.8598 ± 0.0008       |
| 0.0005 | 15,862     | 1,145           | 0.8598 ± 0.0009       |
| 0.001  | 10,430     | 502             | 0.8587 ± 0.0007       |
| 0.002  | 6,441      | 186             | 0.8572 ± 0.0008       |

The min_df parameter dramatically affects vocabulary size (ranging from 6,441 to 35,827 words) but has minimal impact on accuracy. The difference between the best (85.98%) and worst (85.72%) is only 0.26%.

An interesting observation is the correlation between vocabulary size and missing Word2Vec embeddings. With min_df=0.0001, 5,624 words (15.7% of vocabulary) have no embedding, likely because they are rare misspellings or domain-specific terms absent from Google News. With min_df=0.002, only 186 words (2.9%) are missing.

Despite including thousands of words with zero vectors, min_df=0.0001 performs identically to min_df=0.0005. The model appears robust to this noise because rare words contribute little to the averaged document embedding.

## Maximum Document Frequency (max_df)

| max_df | Vocab Size | Accuracy (mean ± std) |
| ------ | ---------- | --------------------- |
| 0.3    | 15,827     | 0.8589 ± 0.0007       |
| 0.5    | 15,862     | 0.8598 ± 0.0009       |
| 0.7    | 15,877     | 0.8588 ± 0.0003       |
| 0.9    | 15,883     | 0.8588 ± 0.0011       |

The max_df parameter has essentially no effect. Vocabulary size changes by only 56 words across the entire range, and accuracy differences (0.1%) are smaller than the standard deviations.

This is expected: max_df removes words appearing in more than X% of documents. Even at max_df=0.3, only extremely common words like "the", "a", and "movie" are removed. Since the model uses averaged Word2Vec embeddings, these high-frequency words contribute little discriminative information.

## Summary of Dictionary Cutoff Experiments

| Parameter | Effect on Vocab Size | Effect on Accuracy |
| --------- | -------------------- | ------------------ |
| min_df    | Large (6× range)     | Small (~0.26%)     |
| max_df    | Minimal (~56 words)  | Negligible (~0.1%) |

The dictionary cutoffs matter little when using Word2Vec embeddings. The recommended setting is min_df=0.0005 and max_df=0.5, providing a reasonable vocabulary size (~16,000 words) with good Word2Vec coverage.

# Additional Experiments: Embedding Quality and Overfitting

These experiments address two questions raised by the previous results: why do architectural choices have such small effects, and when does overfitting actually occur?

## Random vs Word2Vec Embeddings

This experiment tests whether the pretrained Word2Vec embeddings are responsible for the strong baseline performance.

**Setup:**
- Architecture: 1 hidden layer (128 neurons), ReLU
- Two conditions: Word2Vec embeddings vs random 300-dimensional vectors (normalized)
- All other hyperparameters identical

| Embedding Type | Accuracy (mean ± std) |
| -------------- | --------------------- |
| Word2Vec       | 0.8582 ± 0.0027       |
| Random         | 0.7425 ± 0.0006       |

The results are striking: **Word2Vec outperforms random embeddings by 11.6 percentage points**. This is by far the largest effect observed in any experiment.

With random embeddings, the model achieves only 74.25% accuracy, significantly worse than with meaningful embeddings. The neural network cannot learn effective patterns when the input representation carries no semantic information.

This explains why architectural choices in previous experiments had such small effects. The Word2Vec embeddings already encode rich semantic relationships learned from billions of words of text. The neural network's task is relatively simple: learn a decision boundary in this well-structured embedding space. Whether 1, 2, or 3 hidden layers are used matters little when the input representation is already so powerful.

The extremely low standard deviation for random embeddings (0.0006 vs 0.0027) is also notable. With meaningless input features, every random initialization converges to essentially the same poor solution.

## Extended Training and Overfitting Detection

Previous experiments showed no overfitting at 20 epochs with a simple model. This experiment trains for longer and with larger models to identify when overfitting occurs.

**Conditions tested:**

| Condition | Architecture              | Epochs |
| --------- | ------------------------- | ------ |
| 1         | Simple (300→128→2)        | 50     |
| 2         | Simple (300→128→2)        | 100    |
| 3         | Deep/Wide (300→512→256→128→2) | 30     |
| 4         | Deep/Wide (300→512→256→128→2) | 50     |

**Results:**

| Condition            | Best Test Acc   | Best Epoch | Final Test Acc  |
| -------------------- | --------------- | ---------- | --------------- |
| Simple, 50 epochs    | 0.8639 ± 0.0004 | 40.2 ± 8.8 | 0.8600 ± 0.0035 |
| Simple, 100 epochs   | 0.8639 ± 0.0004 | 40.2 ± 8.8 | 0.8543 ± 0.0029 |
| Deep/Wide, 30 epochs | 0.8622 ± 0.0007 | 11.4 ± 4.4 | 0.8506 ± 0.0038 |
| Deep/Wide, 50 epochs | 0.8622 ± 0.0007 | 11.4 ± 4.4 | 0.8412 ± 0.0029 |

**Overfitting is clearly present**, but manifests differently for the two architectures:

**Simple model:** Peak performance occurs around epoch 40 (86.39%), then slowly declines. By epoch 100, accuracy drops to 85.43%, a decrease of approximately 1%. The overfitting is gradual and mild.

**Deep/wide model:** Peak performance occurs much earlier, around epoch 11 (86.22%), then declines more steeply. By epoch 50, accuracy drops to 84.12%, a decrease of 2.1%. The deep model overfits faster and more severely.

Interestingly, the simple model achieves slightly higher peak accuracy (86.39%) than the deep model (86.22%), despite having far fewer parameters. This reinforces the finding that model complexity provides no benefit for this task, and simpler models are less prone to overfitting.

The practical recommendation is to use early stopping: monitor validation accuracy and stop training when it begins to decline. For the simple model, training for 30–50 epochs with early stopping is optimal. For deeper models, 10–15 epochs may be sufficient.

# Conclusion

This study examined neural network performance on IMDB sentiment classification using Word2Vec embeddings. The key findings are:

1. **Pretrained embeddings are the dominant factor.** Word2Vec embeddings outperform random embeddings by 11.6 percentage points, explaining why architectural choices have relatively small effects.

2. **Model complexity provides minimal benefit.** A single hidden layer with 128 neurons achieves nearly the same accuracy as deeper architectures (85.98% vs 86.13%), while being more resistant to overfitting.

3. **Learning rate is the most sensitive hyperparameter.** Setting it too low (0.0001) causes a 1.7% accuracy drop, while other parameters show differences under 0.6%.

4. **Dictionary cutoffs have negligible impact** when using Word2Vec embeddings, as the averaging approach naturally handles both rare and common words.

5. **Overfitting occurs but is mild** with simple architectures. Peak accuracy is reached around epoch 40 for a single-layer model, with gradual decline thereafter.

**Recommended configuration:** A single hidden layer (128 neurons) with ReLU activation, learning rate 0.001, batch size 32–64, and 30–50 epochs with early stopping. This achieves approximately 86% test accuracy while maintaining simplicity and training stability.


Both models peak near 86.2 %, but the deep one overfits faster (epoch 11 → 84.1 % at 50) than the simple one (epoch 40 → 85.4 % at 100).   
Fewer parameters give slightly higher accuracy and gentler decay; stop early after 30–50 epochs for simple nets, 10–15 for deep.

**before computing averaged Word2Vec embeddings**


The min_df parameter dramatically affects vocabulary size (ranging from 189 to 35,827 words). Within the moderate range (0.0001–0.002), accuracy remains remarkably stable with only 0.26% variation. At extreme values, performance degrades significantly—unsurprisingly, when you remove so many words that you can barely form coherent sentences anymore, the model struggles.

What is surprising is that with only 981 words (min_df=0.02), the model still achieves 83.76% accuracy. That is a tiny vocabulary to work with, yet it captures enough sentiment-bearing terms to perform reasonably well. Only when pushed to truly extreme levels (189 words) does accuracy drop substantially to 76.31%.

The model appears robust to including rare, noisy words (low min_df) but depends on having sufficient vocabulary coverage. The optimal range is min_df=0.0005–0.002, balancing vocabulary size with stable accuracy around 86%.