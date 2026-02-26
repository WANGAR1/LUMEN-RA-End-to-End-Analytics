
# Behavioral Learning Analytics - Machine Learning Pipeline

## Phase 4 Overview

This chapter focuses on building an interpretable machine learning pipeline using Learning Management System (LMS) behavioral data.

The goal is to move from raw learner activity logs to actionable weekly insights and predictions that can support:

- A learning analytics website
- Early identification of at-risk learners
- Data-driven monitoring of engagement and learning progress

The work is designed for small datasets, prioritizing clarity, explainability, and reliability over complex black-box models.

---

## Data Sources

The analysis uses CSV exports from an LMS database.

**Tables Used**

| Table | Description |
|---|---|
| Users | Learner demographic and role information |
| Courses | Course metadata |
| Modules | Course structure and sequencing |
| Lesson Activity | Learner interaction logs (progress, status, timestamps) |
| Quiz Attempts | Assessment performance data |

---

## Project Structure

```
├── data/
│   ├── users.csv
│   ├── courses.csv
│   ├── modules.csv
│   ├── lesson_activity.csv
│   └── quiz_attempts.csv
│
├── notebooks/
│   ├── EDA+ML.ipynb
│   └── 02_weekly_feature_engineering.ipynb
│
├── outputs/
│   ├── weekly_behavioral_features.csv
│   └── ML_Prediction.csv
│
└── README.md
```

---

## Pipeline Phases

### 1. Exploratory Data Analysis (EDA)

**Purpose**

To understand learner behavior before modeling, ensuring that features are meaningful and grounded in real patterns.

**Key EDA Steps**

- Data loading and schema inspection
- Timestamp conversion and ordering
- Analysis of:
  - Lesson progress distribution
  - Module completion patterns
  - Quiz score trends
  - User engagement frequency

**Key Insight**

Many learners show partial progress without completion, indicating potential disengagement before finishing modules. Not all users were learners.

> EDA is used for decision-making, not prediction.

---

### 2. Weekly Feature Engineering

**Why Weekly Aggregation?**

Raw LMS data is event-based and noisy. Weekly aggregation:

- Reduces daily fluctuations
- Reflects natural learning cycles
- Improves modeling stability for small datasets

**Engineered Weekly Features**

Each learner is represented as a weekly behavioral snapshot, including:

| Feature | Description |
|---|---|
| `sessions` | Number of activity events per week |
| `modules_completed` | Completed modules per week |
| `avg_progress` | Average lesson progress per week |
| `avg_quiz_score` | Mean quiz score per week |
| `active_days` | Number of unique active days |
| `inactivity_days` | Days without activity |

**Confidence Score (Behavioral Proxy)**

A confidence score is calculated using observable behavior:

- Progress consistency
- Completion signals
- Quiz performance

This avoids subjective surveys and relies entirely on platform usage data.

**Output**

The final engineered dataset is saved as `outputs/weekly_behavioral_features.csv`.

This file serves as the single source of truth for:

- Machine learning
- Website analytics
- KPI reporting

---

### 3. Machine Learning Modeling

**Objective**

Use early behavioral signals to predict learner engagement outcomes and identify potential risk patterns.

**Model Used: Logistic Regression**

| Reason | Detail |
|---|---|
| Interpretable | Coefficients are easy to explain |
| Small dataset friendly | Works well without large amounts of data |
| Probabilistic output | Returns probabilities instead of hard labels |
| Stakeholder accessible | Easy to explain to non-technical audiences |

**Features Used**

- Weekly engagement metrics
- Average progress
- Quiz performance
- Confidence score
- Inactivity indicators

**Target Variable**

A binary outcome representing learner success or risk, derived from engagement and completion behavior.

**Model Output**

- Probability of learner success or risk
- Clear decision boundaries
- Actionable insights for early intervention

> The focus is interpretation, not algorithmic complexity.

---

## Website Integration

The machine learning outputs directly support the website by enabling:

- Weekly active learner counts
- Engagement trend visualizations
- Confidence growth tracking
- Early identification of at-risk learners

> The website presents insights, not raw data.

---

## Technologies Used

- Python
- Pandas
- NumPy
- Scikit-learn
- Google Colab
- GitHub

---

## Key Takeaway

This project demonstrates that meaningful learning analytics can be built using:

- Small datasets
- Simple, explainable models
- Strong feature engineering
- Behavioral data only

The result is a clean, scalable, and interpretable analytics pipeline suitable for real-world educational platforms.
