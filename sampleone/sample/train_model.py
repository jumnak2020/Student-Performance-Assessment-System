import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split, cross_val_score, KFold
from sklearn.metrics import accuracy_score, classification_report
import joblib

print("="*60)
print("   STUDENT PERFORMANCE MODEL TRAINING")
print("="*60)

# 1. Generate Synthetic Data
# Features: [Marks (0-100), Attendance (0-100), Behavior (1-10)]
# Labels: ['Slow Learner', 'Average Learner', 'Fast Learner']

print("\n📊 Generating training data...")
data = {
    'marks': np.random.randint(20, 100, 500),
    'attendance': np.random.randint(50, 100, 500),
    'behavior': np.random.randint(3, 11, 500)
}
df = pd.DataFrame(data)

# Define simple rules for labeling (just for training logic simulation)
def categorize(row):
    if row['marks'] < 40 or row['attendance'] < 60:
        return 'Slow Learner'
    elif row['marks'] > 80 and row['behavior'] > 7:
        return 'Fast Learner'
    else:
        return 'Average Learner'
    
df['label'] = df.apply(categorize, axis=1)

print(f"✅ Generated {len(df)} training samples")
print(f"   Class distribution:")
print(f"   - Slow Learner: {sum(df['label'] == 'Slow Learner')}")
print(f"   - Average Learner: {sum(df['label'] == 'Average Learner')}")
print(f"   - Fast Learner: {sum(df['label'] == 'Fast Learner')}")

# 2. Prepare Data
X = df[['marks', 'attendance', 'behavior']]
y = df['label']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 3. ✨ NEW: Cross-Validation BEFORE Final Training
print("\n" + "="*60)
print("   CROSS-VALIDATION (5-Fold)")
print("="*60)
print("Testing model reliability across different data splits...\n")

model = RandomForestClassifier(n_estimators=100, random_state=42)

# Perform 5-fold cross-validation
kf = KFold(n_splits=5, shuffle=True, random_state=42)
cv_scores = cross_val_score(model, X, y, cv=kf, scoring='accuracy')

print("📈 Cross-Validation Results:")
for i, score in enumerate(cv_scores, 1):
    print(f"   Fold {i}: {score:.4f} ({score*100:.2f}%)")

print(f"\n✅ Average CV Accuracy: {cv_scores.mean():.4f} ({cv_scores.mean()*100:.2f}%)")
print(f"   Standard Deviation: ±{cv_scores.std():.4f} ({cv_scores.std()*100:.2f}%)")

# Interpret results
if cv_scores.mean() >= 0.90:
    print("   🏆 Verdict: EXCELLENT - Model is highly reliable!")
elif cv_scores.mean() >= 0.80:
    print("   ✅ Verdict: GOOD - Model is reliable")
elif cv_scores.mean() >= 0.70:
    print("   ⚠️  Verdict: MODERATE - Model needs improvement")
else:
    print("   ❌ Verdict: POOR - Model needs significant improvement")

# 4. Train Final Model on ALL Training Data
print("\n" + "="*60)
print("   FINAL MODEL TRAINING")
print("="*60)
print("Training final model on full training set...\n")

model.fit(X_train, y_train)

# 5. Evaluate on Test Set
y_pred = model.predict(X_test)
test_accuracy = accuracy_score(y_test, y_pred)

print(f"✅ Test Set Accuracy: {test_accuracy:.4f} ({test_accuracy*100:.2f}%)")

# 6. Detailed Classification Report
print("\n📊 Detailed Performance by Class:")
print("-"*60)
print(classification_report(y_test, y_pred, zero_division=0))

# 7. Save Model
print("="*60)
print("   SAVING MODEL")
print("="*60)
joblib.dump(model, 'student_performance_model.pkl')
print("✅ Model saved as 'student_performance_model.pkl'")
print(f"   Model Type: Random Forest (100 trees)")
print(f"   Training Samples: {len(X_train)}")
print(f"   Test Samples: {len(X_test)}")
print(f"   Cross-Validation Score: {cv_scores.mean():.4f}")
print(f"   Test Accuracy: {test_accuracy:.4f}")
print("\n✅ Training Complete!")
print("="*60)