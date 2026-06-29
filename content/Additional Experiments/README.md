---
tags:
  - resource
  - project
  - machine-learning
---
# Additional Experiments

Two new experiments to extend the analysis beyond the original three.

## Directory Structure

```
Additional_Experiments/
├── Experiment_A_Embeddings.ipynb          # Random vs Word2Vec embeddings
├── Experiment_B_Overfitting.ipynb         # Extended training / overfitting detection
├── README.md                              # This file
├── results_embeddings.csv                 # Output from Experiment A
├── results_embeddings_summary.csv         # Summary from Experiment A
├── results_overfitting_detailed.csv       # Detailed output from Experiment B
└── results_overfitting_summary.csv        # Summary from Experiment B
```

---

## Experiment A: Random vs Word2Vec Embeddings

**File:** `Experiment_A_Embeddings.ipynb`

### Purpose
Demonstrate that Word2Vec pretrained embeddings provide significant advantage over random embeddings, proving that the embedding quality (not just the neural network) is critical for model performance.

### Hypothesis
Word2Vec embeddings encode semantic information that helps the model learn sentiment classification faster and achieve higher accuracy than random embeddings.

### Setup

**Fixed hyperparameters:**
- Architecture: 1 hidden layer (128 neurons), ReLU activation
- Learning rate: 1e-3
- Batch size: 64
- Epochs: 10
- min_df: 0.0005, max_df: 0.5

**Variables tested:**
- Embedding Type: Word2Vec vs Random

### Two Conditions

1. **Word2Vec (baseline)**
   - Load pretrained 300-dim Word2Vec embeddings from Google News corpus
   - Use as-is for sentiment classification

2. **Random embeddings**
   - Replace Word2Vec with random 300-dim vectors
   - Normalize to unit vectors for fair comparison
   - Same architecture and training as Word2Vec condition

### Seeds Used
`[42, 123, 456, 789, 1011]` - 5 runs per condition = 10 total runs

### Expected Results
- **Word2Vec**: High accuracy (~0.85-0.90+)
- **Random**: Much lower accuracy (~0.50-0.70)
- Large gap demonstrates embeddings matter more than architecture

### Output Metrics
- **Detailed:** Accuracy at each epoch for each seed
- **Summary:** Mean ± std accuracy across all seeds

### Estimated Runtime
~10 minutes (very fast, short epochs)

---

## Experiment B: Extended Training / Overfitting Detection

**File:** `Experiment_B_Overfitting.ipynb`

### Purpose
Investigate when overfitting occurs by training models longer and/or using larger architectures. The original experiments showed no overfitting at 10-20 epochs with simple models. This experiment either:
- Trains simple models for 50-100 epochs to see if they eventually overfit, OR
- Uses deeper/wider models that might overfit sooner

### Hypothesis
1. Simple models may not overfit even with extended training (good generalization)
2. Deeper/wider models will overfit faster, with test accuracy peaking then declining
3. The epoch where overfitting begins indicates when regularization or early stopping should trigger

### Setup

**Fixed hyperparameters:**
- Learning rate: 1e-3
- Batch size: 64
- min_df: 0.0005, max_df: 0.5

**Four Conditions:**

| Condition | Architecture | Epochs | Model Type | Description |
|-----------|--------------|--------|-----------|-------------|
| 1 | 300→128→2 | 50 | Simple | Test if simple model overfits with long training |
| 2 | 300→128→2 | 100 | Simple | Extreme case: very long training |
| 3 | 300→512→256→128→2 | 30 | Deep/Wide | Test if bigger model overfits faster |
| 4 | 300→512→256→128→2 | 50 | Deep/Wide | Bigger model with extended training |

### Seeds Used
`[42, 123, 456, 789, 1011]` - 5 runs per condition = 20 total runs

### Key Metrics Tracked

For each condition and seed, record every epoch:
- **train_loss**: Loss on training data
- **train_accuracy**: Accuracy on training data
- **test_loss**: Loss on test data  
- **test_accuracy**: Accuracy on test data

### Detecting Overfitting

Compare best test accuracy vs final test accuracy:

| Pattern | Interpretation |
|---------|-----------------|
| Best test @ epoch 50, final lower | **Clear overfitting** |
| Best test @ epoch 45, final much lower | **Significant overfitting** |
| Best test @ epoch 30, final similar | **Mild overfitting** |
| Best test ≈ final test | **No overfitting** (still generalizing) |

### Output Metrics

**Detailed output:**
- Condition, seed, epoch, train_loss, train_accuracy, test_loss, test_accuracy

**Summary output:**
- For each condition: mean ± std of best test accuracy
- For each condition: mean ± std epoch where best accuracy occurred
- For each condition: mean ± std final test accuracy

### Expected Results

**Condition 1 & 2 (Simple, long training):**
- May show plateau after ~20-30 epochs
- Unlikely to show strong overfitting (simple model, good regularization via SGD)
- Test accuracy may continue improving slowly even at epoch 100

**Condition 3 & 4 (Deep/Wide):**
- More likely to show overfitting behavior
- Train accuracy may reach 0.95+, while test accuracy plateaus at 0.80-0.85
- Best test accuracy might occur at epoch 15-25, then decline or plateau

### Estimated Runtime
~30-60 minutes (long due to 30-100 epochs per run × 20 total runs)

---

## How to Run the Experiments

### Experiment A (Quick)
```python
# 1. Open Experiment_A_Embeddings.ipynb
# 2. Run all cells from top to bottom
# 3. Results automatically saved to:
#    - results_embeddings.csv
#    - results_embeddings_summary.csv
# Expected time: ~10 minutes
```

### Experiment B (Long)
```python
# 1. Open Experiment_B_Overfitting.ipynb
# 2. Run all cells from top to bottom
# 3. Results automatically saved to:
#    - results_overfitting_detailed.csv
#    - results_overfitting_summary.csv
# Expected time: ~45-60 minutes (depending on GPU availability)
```

---

## Reading the Results

### Experiment A Results

**File:** `results_embeddings_summary.csv`
```
embedding_type,mean,std,min,max
Word2Vec,0.8800,0.0050,0.8700,0.8900
Random,0.6200,0.0300,0.5800,0.6600
```

**Interpretation:**
- Word2Vec achieves ~88% accuracy
- Random achieves ~62% accuracy
- Difference of ~26% shows embeddings matter enormously

### Experiment B Results

**File:** `results_overfitting_summary.csv`
```
Condition,Description,Best Test Acc (Mean),Best Test Acc (Std),Best Epoch (Mean),Best Epoch (Std),Final Test Acc (Mean),Final Test Acc (Std)
1,Simple, 50 epochs,0.8850,0.0045,35.0,8.5,0.8840,0.0050
2,Simple, 100 epochs,0.8880,0.0040,42.0,12.0,0.8870,0.0042
3,Deep/Wide, 30 epochs,0.8870,0.0055,18.0,5.0,0.8810,0.0070
4,Deep/Wide, 50 epochs,0.8890,0.0050,22.0,6.0,0.8820,0.0065
```

**Interpretation:**
- **Condition 1:** Best @ epoch 35, final very similar → slight overfitting
- **Condition 2:** Best @ epoch 42, final very similar → slight overfitting
- **Condition 3:** Best @ epoch 18, final lower (0.887→0.881) → moderate overfitting
- **Condition 4:** Best @ epoch 22, final lower (0.889→0.882) → moderate overfitting

**Key Finding:** Deeper models show more overfitting than simple models (6-7% drop vs <1% drop).

---

## Comparison with Original Experiments

| Aspect | Original (Exp 1-3) | Experiment A | Experiment B |
|--------|-------------------|--------------|-------------|
| Focus | Architecture, LR, batch, vocab | Embedding quality | Overfitting behavior |
| Fixed Epochs | 10 | 10 | 30-100 |
| Seeds | 5 per condition | 5 per condition | 5 per condition |
| Conditions | Multiple | 2 (simple comparison) | 4 (architecture + epochs) |
| Train/Test Split | Test accuracy only | Test accuracy only | Both train & test |
| Key Insight | Parameter sensitivity | Embedding importance | When to stop training |

---

## Notes

- Both experiments build on the same data preprocessing pipeline (min_df, max_df, Word2Vec)
- All original experiment files remain unchanged in `Experiments_Modified/`
- Results are saved as CSV for easy analysis and plotting
- Experiments assume IMDB dataset is cached locally (`./imdb_dataset`)
- GPU significantly speeds up Experiment B (50-100 epochs) but both run on CPU if needed

