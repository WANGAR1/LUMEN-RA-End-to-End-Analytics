Project Overview
This repository contains the end-to-end data pipeline for the Digital Allyship Toolkit. The project utilizes a Medallion Architecture (Bronze, Silver, Gold) to transform raw LMS and survey data into actionable business insights. The final output powers a dashboard that tracks user engagement, knowledge growth, and content friction points.
+1

Core Business Metrics
The pipeline is designed to validate and produce the following Key Performance Indicators (KPIs) visible in the analysis:
+3


Active Users: 46 


Engagement Rate: 0.92 


Module Completion Rate: 0.38 


Average Quiz Score: 62.46 
+1


Pass Rate: 0.68 

Data Pipeline Architecture
The project is organized into three distinct SQL layers to ensure data integrity:

1. Bronze Layer (Raw)
Purpose: Landing zone for raw CSV data.

Tables: Includes lms_users, lms_courses, lms_modules, lms_lesson_activity, lms_quiz_attempts, and pre/post assessments.

Logic: Uses VARCHAR and TIMESTAMP types for flexible data ingestion.

2. Silver Layer (Cleaned)
Purpose: Data deduplication, trimming, and standardization.


Logic: Standardizes activity statuses (e.g., in_progress, completed, started) to ensure accurate funnel reporting.
+2

3. Gold Layer (Analytics)
Purpose: Star Schema implementation for Power BI consumption.

Fact Table: fact_user_performance — joins user data with quiz scores and survey lift.


Dimension Tables: dim_users and dim_modules for filtering by department or course.

Insights & Analysis
The dashboard identifies a critical user funnel where users drop off between stages:


In-Progress: 70 users 


Completed: 57 users 


Started: 23 users 

Additionally, the User Performance Quadrant and Average Quiz Score by Module visuals allow stakeholders to identify specific lessons (such as "Responding" or "Body Language") that may require content adjustments to improve the 0.68 pass rate.
+3

How to Deploy
Environment: PostgreSQL 15+

Step 1: Run 01_bronze_layer.sql to create the schema.

Step 2: Import raw CSV files into the created bronze tables using the Import Wizard.

Step 3: Run 02_silver_layer.sql to clean the data.

Step 4: Run 03_gold_layer.sql to generate the Star Schema and Views.

Step 5: Run 04_validation_check.sql to verify the counts match the dashboard.