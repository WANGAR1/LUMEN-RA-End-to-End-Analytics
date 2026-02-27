# Phase 4 — Machine Learning

## Overview
Predictive models built to identify behavioural patterns that predict learning 
success on the Lumen-Ra platform. Raw LMS event data is transformed into weekly 
behavioural snapshots, which are then used to train an interpretable Logistic 
Regression model that predicts completion risk and identifies at-risk learners 
before they disengage.

## Business Questions Answered
- Which users are most likely to complete all modules?
- What early behaviours predict drop-off?
- Can we predict a user's final quiz score from their early activity patterns?
- Which learners need early intervention before they disengage?

## Notebooks — Run in This Order

| # | File | Purpose |
|---|------|---------|
| 1 | `01_eda.ipynb` | Exploratory Data Analysis — understanding engagement patterns, learning progression, and admin exclusion |
| 2 | `02_weekly_features.ipynb` | Weekly Feature Engineering — transforms event-level activity logs into weekly behavioural snapshots per learner |
| 3 | `03_ml_completion_prediction.ipynb` | Machine Learning Model — Logistic Regression completion prediction with probability outputs and at-risk flags |
| 4 | `EDA_ML.ipynb` | Combined EDA and ML pipeline — full end-to-end notebook covering all stages from data loading to model evaluation |

## What Each Notebook Does

**01_eda.ipynb**  
Loads all five LMS CSV files, converts timestamps to datetime format, filters 
out admin accounts (keeping learners only), and analyses engagement patterns 
including lesson progress distribution, module completion rates and quiz score 
trends. Provides the data understanding that informs the feature engineering 
decisions in notebook 2.

**02_weekly_features.ipynb**  
Transforms raw event-level data into weekly behavioural snapshots. Each learner 
is represented as a weekly record with six engineered features: sessions, 
avg_progress, modules_completed, avg_quiz_score, active_days and inactivity_days. 
Outputs `weekly_behavioral_features.csv` — the single source of truth for the 
machine learning model.

**03_ml_completion_prediction.ipynb**  
Applies Logistic Regression to the weekly features to predict learning completion 
risk. Outputs probability scores per learner, a classification report, and a 
final prediction CSV (`ML_Prediction.csv`) that feeds directly into the platform 
website for at-risk learner identification.

**EDA_ML.ipynb**  
A comprehensive combined notebook covering the full pipeline — from library 
imports and data cleaning through to EDA, feature engineering, model training 
and evaluation. Includes statistical tests, visualizations and defensive error 
handling throughout.

## Output Files

| File | Description |
|------|-------------|
| `outputs/weekly_behavioral_features.csv` | Engineered weekly features — input to the ML model |
| `outputs/ML_Prediction.csv` | Model predictions with completion probability per learner |

## Tools
Python · Pandas · NumPy · Scikit-learn · Matplotlib · Seaborn · SciPy · Google Colab · GitHub

## Dashboard

<img width="1907" height="851" alt="Screenshot 2026-02-27 092644" src="https://github.com/user-attachments/assets/fb8f1747-2d55-40a2-bd08-6a4e54110c67" />


<img width="1886" height="782" alt="Screenshot 2026-02-27 092702" src="https://github.com/user-attachments/assets/f07f0e02-00fc-4ccd-b712-4981fbdd1903" />

## 📊 View the Dashboard Live

| Dashboard | Link |
|-----------|------|
| ML Prediction Pipeline | [Open Dashboard](https://wangar1.github.io/LUMEN-RA-End-to-End-Analytics/phase_4_machine_learning/LumenRa_Dashboard_Phase4_MachineLearning.html) |

## Full Details
See the `/documentation` folder for the complete ML pipeline write-up, 
feature engineering decisions, model selection rationale and key findings.
