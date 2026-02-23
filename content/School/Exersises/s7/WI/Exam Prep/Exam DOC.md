 q
# Assignment 1 Selfstudy 0
![[Pasted image 20260113113404.png]]
### Requirements
- [x] Should be able to compare 2 strings
- [x] Should shingle strings effectively
- [x] Should be able to be used for seeing if something is a duplicate

### Cut Corners



# Assignment 1 Selfstudy 1 Crawling

![[Pasted image 20260113113613.png]]


### Requirements
- [x] Politeness
- [x] Saving the html

### Cut Corners
For duplicate pages i just ignore the second + page, instead of linking them together somehow. So there is no url priotiry, it just first one i find is the source of truth, which is obviously problematic.

I also am not able to index pages that are only videos, nor am i able to index pdf files, or images. (the crawler was getting stuck when it reaches one, so i hardcoded a skip)


# Assignment 1 Selfstudy 2 Indexing
![[Pasted image 20260113113909.png]]

the normalization leaves a lot to be desired, and i am not comparing synonyms in any way shape or form. the only thing i do is sort away words smaller than 2 characters (except words contaning åøæ because they are actually represented specially causing them to have more characters). My indexer essentailly knows nothing about language except that space denotes a word, and that words shoter than 3 characters are bad, and it has a list of useless words as well.

For searching it is basic reverse index search, that i plan on ranking later.

# Assignment 1 Selfstudy 3 Ranking

![[Pasted image 20260113114011.png]]







# Assignment 1 Selfstudy 4 Ranking link based
![[Pasted image 20260113115233.png]]



# Assignment 2 Selfstudy 1
![[Pasted image 20260113115356.png]]


i dont avoid the serendipity problem beceause i only do naive beyers

# Assignment 2 Selfstudy 2

![[Pasted image 20260113115439.png]]

📚 Loading Magazine Subscriptions dataset...
✅ Loaded 2375 reviews
   Columns: ['overall', 'verified', 'reviewTime', 'reviewerID', 'asin', 'reviewerName', 'reviewText', 'summary', 'unixReviewTime', 'vote', 'style', 'image']
   Rating distribution:
overall
1.0     102
2.0     118
3.0     239
4.0     375
5.0    1541
Name: count, dtype: int64
   Unique users: 348
   Unique items: 157

🔀 Splitting data into train/test sets...
   Training set: 1900 ratings
   Test set: 475 ratings
   Total unique users: 348
   Total unique items: 157

🎓 Training matrix factorization model...
   Global mean rating: 4.332
   Epoch 10/100 - RMSE: 1.0610
   Epoch 20/100 - RMSE: 1.0215
   Epoch 30/100 - RMSE: 0.9881
   Epoch 40/100 - RMSE: 0.9595
   Epoch 50/100 - RMSE: 0.9346
   Epoch 60/100 - RMSE: 0.9128
   Epoch 70/100 - RMSE: 0.8934
   Epoch 80/100 - RMSE: 0.8761
   Epoch 90/100 - RMSE: 0.8607
   Epoch 100/100 - RMSE: 0.8468

📊 Evaluating on test set...

   Mean Absolute Error: 0.7189
   Root Mean Squared Error: 0.9763

💾 Saving model and datasets...
✅ Model saved to matrix_factorization_model.pkl
✅ Saved train_set.csv, test_set.csv, and model.pkl

============================================================
✨ Training complete! Ready for next week's evaluation.
============================================================

============================================================
📝 EXAM REFLECTION NOTES
============================================================

🔧 WHAT WAS IMPLEMENTED:
   • Matrix factorization using Funk-SVD algorithm from lecture
   • Stochastic Gradient Descent (SGD) optimization
   • Regularization (weight decay) to prevent overfitting
   • Bias terms for users and items
   • 80/20 train/test split with proper handling of user/item IDs
   • Model persistence for next week's evaluation

⚙️ WHERE CORNERS WERE CUT:
   • Used small n_factors=20 (could use 50-100 for better accuracy)
   • Fixed hyperparameters (didn't do grid search/cross-validation)
   • No pre-processing (removing user/item means) as suggested in lecture
   • Simple SGD (could use Adam or other advanced optimizers)
   • No early stopping (runs all 100 epochs regardless)
   • Doesn't handle cold-start problem (new users/items)

📈 SCALABILITY REFLECTIONS:
   PROS:
   • SGD scales well - processes one rating at a time (memory efficient)
   • Linear in number of ratings (not quadratic like user-based CF)
   • Can be parallelized (not done here, but possible)
   • Works with sparse matrices
   
   CONS:
   • Current implementation stores full matrices in memory
   • For millions of users/items, need sparse matrix representation
   • Training is slow (100 epochs × 2375 ratings = 237,500 updates)
   • Could benefit from mini-batch SGD or GPU acceleration
   
   CURRENT DATASET:
   • ~2,375 reviews, ~450 users, ~350 items = manageable
   • Tried Books dataset but too large for available memory
   • Magazine dataset works well on this hardware

⚠️ PROBLEMS ENCOUNTERED:
   1. Books dataset too large (FileNotFoundError, memory issues)
      → Switched to Magazine Subscriptions dataset
   2. Initial overfitting (predictions too extreme)
      → Added regularization (lambda_reg=0.01)
   3. Slow convergence in early versions
      → Proper learning rate (0.001) and initialization helped

📊 COMPARISON: Matrix Factorization vs Naive Bayes (Task 1)

   NAIVE BAYES (Content-Based):
   • Uses: Review text (words, sentiment)
   • Strengths:
     - Works for NEW items (no ratings needed)
     - Explainable ("predicted 5 stars because review says 'amazing'")
     - Fast training
   • Weaknesses:
     - Needs text data (not always available)
     - Suffers from class imbalance (64.9% were 5-star reviews)
     - Can't learn user preferences
     - Poor accuracy (~40-50% exact match)
   
   MATRIX FACTORIZATION (Collaborative Filtering):
   • Uses: Only user-item-rating patterns
   • Strengths:
     - No content needed (works without text)
     - Learns hidden patterns (latent factors)
     - Personalizes to each user's taste
     - Better RMSE (lower error on average)
   • Weaknesses:
     - Cold-start problem (can't recommend for new users/items)
     - Less explainable ("why did you recommend this?")
     - Needs sufficient rating history
     - Slower to train
   
   WHICH IS BETTER?
   • For existing users with rating history: Matrix Factorization
   • For new items or explaining recommendations: Naive Bayes
   • Best solution: Hybrid approach combining both!

💡 RECOMMENDATIONS QUALITY:
   • Matrix Factorization: RMSE = 0.9763, MAE = 0.7189
   • This means predictions are typically off by ~0.72 stars
   • Better than random guessing (would be ~1.5 error)
   • Could improve with more factors, better preprocessing, and tuning
   
📚 NEXT WEEK:
   • Use saved model to generate top-N recommendations
   • Compare predicted vs actual ratings in test set
   • Analyze which users/items are predicted well/poorly


# Assignment 2 Selfstudy 2








