
Written Exam Assignment 8 from the Web Intelligence course, Autumn semester 2025
Deliver a written document max 5 pages long as a pdf file in digital exam
Assignment start: 26 January 2026, 8:00 CET
Assignment deadline: 27 January 2026, 23:55 CET Language: English

# Basics of Neural Networks and Backpropagation

## Task description: 

In this assignment, you will work on a binary text classification problem using the [IMDB movie review](https://huggingface.co/datasets/stanfordnlp/imdb) dataset, which contains highly polarized movie reviews. To construct input representations for your neural network models, you will use pre-trained word embeddings on the [Google News](https://code.google.com/archive/p/word2vec/) dataset.

A Jupyter notebook file (assignment_3-part_I.ipynb) was provided in Session 9 to guide you through the implementation process, offering structured exercises to help you apply and experiment with neural network techniques for text classification. In your document, you need to describe and reflect on the following points:

- examine how performance is affected by key architectural choices, such as the number of hidden layers, the number of neurons per layer, and the choice of activation functions.
- experiment with different learning configurations to evaluate their impact on classification accuracy, including batch size, learning rate, and number of epochs.
- adjust the cutoff frequencies when constructing the IMDB dictionary and observe how these changes impact model accuracy.

You are expected to test each architecture across multiple runs with different initializations, report the average accuracy and the standard deviation, and discuss the results.  You can define a validation dataset to support performance analysis during model training.


---
# How Accuracy is affected by architectural choices

This experiment is about how different neural network architectural choices affect sentiment classification performance on the IMDB dataset.

**Variables to test:**
- Number of hidden layers: 0, 1, 2, 3 layers
- Neurons per layer: (32-64), (128), (256-512)
- Activation functions: ReLU vs Tanh vs LeakyReLU


The thought process or hypothesis is that deeper networks might capture more complex patterns, but too many layers would lead to overfitting or vanishing gradients.

**Fixed hyperparameters for fair comparison:**
- Learning rate: 1e-3
- Batch size: 64
- Epochs: 10
- Dictionary min_df: 0.0005, max_df: 0.5
## Number of Hidden Layers

I made 5 semi meaningful experiments, 4 of which are just about what happens when you add more layers to the network, and one was what would happen if the hidden layer has very few nodes:

The starting accuracy is what the average result was on Epoch 1, and final is what it was what the average result was on Epoch 10

| Architecture                                   | starting Accuracy | Final Accuracy |
| ---------------------------------------------- | ----------------- | -------------- |
| Linear (0 hidden) 300 -> 2                     | 0.7878            | 0.8303         |
| 1 hidden layer 300 -> (128) -> 2               | 0.8376            | 0.8594         |
| 2 hidden layers 300 -> (256→128) -> 2          | 0.8404            | 0.8637         |
| 3 hidden layers 300 -> (256→128→64) -> 2       | 0.8470            | 0.8612         |
| 1 hidden very messed up layer 300 -> (10) -> 2 | 0.7966            | 0.8548         |
So interestingly enough nothing i do has a significant effect on the results. The difference between the best performer (86.37%) and the worst performer (83.03%) is only about 3.3, which is a little weird because the worst performer does not even have any hidden layers.

With only 10 nodes in the hidden layer, which is is like putting your data through a hydraulic press, it still performs relatively well compared to the best one.

Changing the seed for individual tests has some impact on the results, but the general idea of "it does not drastically affect the results" still stands

```
Linear (0 hidden)                  0.8292 
1 hidden layer (128)               0.8590 
2 hidden layers (256→128)          0.8629 
3 hidden layers (256→128→64)       0.8608 
1 hidden very messed up layer (10) 0.8543
```

## Activation Functions

The starting accuracy is what it was on Epoch 1, and final is what it was on Epoch 10

| Activation | starting Accuracy | Final Accuracy |
| ---------- | ----------------- | -------------- |
| ReLU       | 0.8376            | 0.8603         |
| Tanh       | 0.8422            | 0.8600         |
| LeakyReLU  | 0.8398            | 0.8592         |

Here we see a very similar result as previously, this time, the activation function has little to no impact on the final result. When re-running the experiment with a different seed the order of the average final accuracy changes seemingly at random

Activation Final Accuracy 
ReLU           0.8599 
Tanh            0.8598 
LeakyReLU 0.8600 



===## drawbacks
i could probably test something about what happens if i change my input layer from 300 so something higher or something lower===


---
# How different learning configurations affect the results

Here i tried figuring out how different hyperparameter configurations impact model training and final accuracy. I change some learning parameters while keeping the architecture constant.

**Variables to test:**
- Learning rate: 0.0001, 0.0005, 0.001, 0.01
- Batch size: 16, 32, 64, 128, 256
- Epochs: 5, 10, 15, 20
  
The thought process or hypothesis is that:
- Too low learning rates might be bad at converging and too high learning rates would overshoot.
- Smaller batch sizes provide noisier gradients (may help escape local minima)
- Larger batch sizes: i'm honestly just curious, since this dataset is so simple
- More epochs allow better convergence but will probably overfit

**Fixed parameters for fair comparison:**
- Architecture: 1 hidden layer (128 neurons)
- Activation: ReLU
- Dictionary min_df: 0.0005, max_df: 0.5

## Learning Rate Impact

| Learning Rate | Best Accuracy |
| ------------- | ------------- |
| 0.0001        | 0.8437        |
| 0.0005        | 0.8596        |
| 0.001         | 0.8606        |
| 0.01          | 0.8597        |

The learning rate experiment shows that there is a sweet spot around 0.001. The lowest learning rate (0.0001) underperforms, reaching only 84.37% compared to 86.06% for the optimal rate. Looking at the training logs, the 0.0001 model was still improving at epoch 10 with train loss dropping steadily, after running this test alone once, i can see that it starts stabilising at around epoch 14 at 85.05%.

Interestingly, the highest learning rate (0.01) did not completely break things like I expected. It achieved 85.97% which is almost identical to 0.001. However, the training was noticeably more unstable at epoch 6 the test accuracy suddenly dropped to 81.61% before recovering. This "overshooting" behavior is what i suspected would happen, but the model managed to recover anyway.

The difference between the best (0.001) and second best (0.01) is only about 0.1%, so practically speaking anything in the 0.0005-0.01 range works fine for this task.

## Batch Size Impact

| Batch Size | Best Accuracy |
| ---------- | ------------- |
| 16         | 0.8606        |
| 32         | 0.8608        |
| 64         | 0.8599        |
| 128        | 0.8578        |
| 256        | 0.8577        |

This is where things get interesting. Batch sizes 16 and 32 perform best (86.06% and 86.08%). But honestly the difference is so tiny (about 0.02% between best and worst) that I'm not sure it matters for this dataset.

What is more noticeable is the convergence speed. Looking at epoch 1 results:
- Batch size 16: already at 84.37% accuracy
- Batch size 256: only at 81.16% accuracy

So smaller batches converge faster in terms of epochs, but each epoch takes longer because you're doing more gradient updates. The larger batch sizes eventually catch up by epoch 10 but never quite reach the same peak accuracy.

## Number of Epochs Impact

| Epochs | Best Accuracy |
| ------ | ------------- |
| 5      | 0.8574        |
| 10     | 0.8590        |
| 15     | 0.8616        |
| 20     | 0.8628        |

This result surprised me a bit. I expected overfitting to kick in at some point, but even at 20 epochs the model kept improving slightly. The best accuracy went from 85.74% at 5 epochs to 86.28% at 20 epochs, a gain of about 0.5%.

Looking at the training loss, it kept decreasing steadily (from ~0.46 at epoch 1 to ~0.32 at epoch 20), which normally would suggest overfitting. But the test accuracy also kept improving, so the model was genuinely learning something useful rather than just memorizing.

My hypothesis about overfitting was wrong for this particular setup. The model is simple enough (just one hidden layer with 128 neurons) that it probably cannot overfit this dataset easily. With a deeper network this might be different.

### Summary of Learning Configuration Experiments

The most impactful parameter was learning rate when it was set too low. The other parameters showed differences of less than 0.5% which is within noise range for different random seeds. A boring result, i know, but hey a result is a result, no matter if it is interesting or meaningful.


# Dictionary Cutoff Frequencies

This experiment investigates how the vocabulary cutoff thresholds (min_df and max_df) in the CountVectorizer affect model performance. These parameters control which words are included in the feature vocabulary.

**Variables to test:**
- min_df (minimum document frequency): 0.0001, 0.0005, 0.001, 0.002
- Lower values include rare words; higher values ignore them
- max_df (maximum document frequency): 0.3, 0.5, 0.7, 0.9
- Lower values remove common words; higher values keep them

**Hypothesis**:
- Too low min_df includes noisy rare words that don't generalize
- Too high min_df loses important sentiment-specific words
- Too low max_df removes common words that are important for understanding
- Too high max_df keeps meaningless common words (articles, prepositions)
- The optimal vocabulary size balances having enough words to capture meaning without noise

  

**Fixed hyperparameters for fair comparison:**
- Architecture: 1 hidden layer (128 neurons)
- Learning rate: 1e-3
- Batch size: 64
- Epochs: 10





## Minimum Document Frequency (min_df)

| min_df | Vocab Size | Words Not Found | Best Accuracy |
| ------ | ---------- | --------------- | ------------- |
| 0.0001 | 35827      | 5624            | 0.8593        |
| 0.0005 | 15862      | 1145            | 0.8606        |
| 0.001  | 10430      | 502             | 0.8594        |
| 0.002  | 6441       | 186             | 0.8569        |

The min_df parameter has a dramatic effect on vocabulary size. Going from 0.0001 to 0.002 reduces the vocabulary from 35,827 words down to 6,441, which is almost a 6x reduction. What's interesting is that despite this massive change in vocabulary size, the accuracy barely moves, the difference between best (86.06%) and worst (85.69%) is only 0.37%.

One thing I did not expect was how many words are missing from the Word2Vec embeddings when using a very low min_df. With min_df=0.0001, there are 5,624 words not found in Word2Vec, meaning these words just get zero vectors. These are probably rare misspellings, obscure terms, or reviewer-specific jargon that Google News never saw. When we increase min_df to 0.002, only 186 words are missing, which makes sense because the remaining words are common enough to appear in a large news corpus.

My hypothesis about rare words adding noise was partially correct, the lowest min_df (0.0001) does perform slightly worse than 0.0005. But the model seems surprisingly robust to including these noisy rare words. The best performance comes from min_df=0.0005, which gives a vocabulary of about 16,000 words with only 1,145 missing from Word2Vec.

## Maximum Document Frequency (max_df)

| max_df | Vocab Size | Best Accuracy |
| ------ | ---------- | ------------- |
| 0.3    | 15827      | 0.8579        |
| 0.5    | 15862      | 0.8598        |
| 0.7    | 15877      | 0.8583        |
| 0.9    | 15883      | 0.8594        |

The max_df parameter has almost no effect on anything. The vocabulary size changes by only about 50 words across the entire range (from 0.3 to 0.9), and the accuracy differences are within noise range (less than 0.2%).

This makes sense when you think about it. The max_df parameter removes words that appear in more than X% of documents. Even at max_df=0.3, we're only removing words that appear in over 30% of all reviews. These would be extremely common words like "the", "a", "is", "movie", etc. Since we're using Word2Vec embeddings, these common words probably don't contribute much unique information to the averaged document representation anyway. Whether we include "the" or not, the 300-dimensional average embedding ends up being similar.

My hypothesis about max_df being important for removing meaningless stopwords was wrong for this setup. The Word2Vec averaging approach seems to naturally handle this problem.

## Summary of Dictionary Cutoff Experiments

| Parameter | Effect on Vocab | Effect on Accuracy |
| --------- | --------------- | ------------------ |
| min_df    | Large (6x)      | Small (~0.4%)      |
| max_df    | Minimal (~50)   | Negligible (~0.2%) |

The main takeaway is that the dictionary cutoffs don't matter much for this task when using Word2Vec embeddings. The min_df parameter has more impact because it controls how many rare/noisy words enter the vocabulary (and how many of those have missing embeddings), but even then the accuracy differences are small.

The sweet spot appears to be around min_df=0.0005 and max_df=0.5, which was actually the default I used in the other experiments. This gives a reasonable vocabulary size (~16,000 words) with most words having valid Word2Vec embeddings.

If I were optimizing for computational efficiency rather than accuracy, I would use a higher min_df (like 0.002) since it gives nearly the same accuracy with 2.5x fewer words to process.


# Additional Experiments: Embedding Quality and Overfitting

These experiments address two questions raised by the previous results: why do architectural choices have such small effects, and when does overfitting actually occur?

## Random vs Word2Vec Embeddings

This experiment tests whether the pretrained Word2Vec embeddings are responsible for the strong baseline performance, or whether the neural network architecture is doing the heavy lifting.

**Setup:**

- Architecture: 1 hidden layer (128 neurons), ReLU
- Two conditions: Word2Vec embeddings vs random 300D vectors (normalized)
- All other hyperparameters identical

|Embedding Type|Mean Accuracy|Std Deviation|
|---|---|---|
|Word2Vec|0.8582|0.0027|
|Random|0.7425|0.0006|

The results are striking: **Word2Vec outperforms random embeddings by 11.6 percentage points**. This is by far the largest effect observed in any experiment.

With random embeddings, the model achieves only 74.25% accuracy, which is barely better than random guessing for a binary classification task. The neural network cannot learn meaningful patterns when the input representation carries no semantic information.

This explains why architectural choices in previous experiments had such small effects. The Word2Vec embeddings already encode rich semantic relationships learned from billions of words of text. The neural network's job is relatively simple: learn a linear (or near-linear) decision boundary in this well-structured embedding space. Whether you use 1, 2, or 3 hidden layers matters little when the input representation is already so powerful.

The extremely low standard deviation for random embeddings (0.0006 vs 0.0027) is also notable. With meaningless input features, every random initialization converges to essentially the same poor solution.

## Extended Training and Overfitting Detection

Previous experiments showed no overfitting at 20 epochs with a simple model. This experiment trains for longer and with larger models to find where overfitting occurs.

**Conditions tested:**

|Condition|Architecture|Epochs|
|---|---|---|
|1|Simple (300→128→2)|50|
|2|Simple (300→128→2)|100|
|3|Deep/Wide (300→512→256→128→2)|30|
|4|Deep/Wide (300→512→256→128→2)|50|

**Results:**

|Condition|Best Test Acc|Best Epoch|Final Test Acc|
|---|---|---|---|
|Simple, 50 epochs|0.8639 ± 0.0004|40.2 ± 8.8|0.8600 ± 0.0035|
|Simple, 100 epochs|0.8639 ± 0.0004|40.2 ± 8.8|0.8543 ± 0.0029|
|Deep/Wide, 30 epochs|0.8622 ± 0.0007|11.4 ± 4.4|0.8506 ± 0.0038|
|Deep/Wide, 50 epochs|0.8622 ± 0.0007|11.4 ± 4.4|0.8412 ± 0.0029|

**Overfitting is clearly present**, but manifests differently for the two architectures:

**Simple model:** Peak performance occurs around epoch 40 (86.39%), then slowly declines. By epoch 100, accuracy drops to 85.43%, a decrease of about 1%. The overfitting is gradual and mild.

**Deep/wide model:** Peak performance occurs much earlier, around epoch 11 (86.22%), then declines more steeply. By epoch 50, accuracy drops to 84.12%, a decrease of 2.1%. The deep model overfits faster and more severely.

Interestingly, the simple model achieves slightly higher peak accuracy (86.39%) than the deep model (86.22%), despite having far fewer parameters. This reinforces the finding that model complexity provides no benefit for this task, and the simpler model is less prone to overfitting.

The practical recommendation is to use early stopping: monitor validation accuracy and stop training when it begins to decline. For the simple model, training for 30-50 epochs with early stopping would be optimal. For deeper models, even 10-15 epochs may be sufficient.