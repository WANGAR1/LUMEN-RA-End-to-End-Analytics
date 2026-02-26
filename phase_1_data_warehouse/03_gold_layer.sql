/* =============================================================
   GOLD LAYER: STAR SCHEMA ARCHITECTURE
=============================================================
Script Purpose:
    This script builds the final Dimension and Fact tables.
    It links the cleaned 'silver' data into a structure 
    optimized for the Lumenra Analytics Dashboard.
============================================================= */

-- Ensure Schema exists
CREATE SCHEMA IF NOT EXISTS gold;

/* =============================================================
   1. DIMENSION TABLES (Slicers & Context)
============================================================= */

-- DIM_USERS: For Departmental and Role-based filtering
DROP TABLE IF EXISTS gold.dim_users;
CREATE TABLE gold.dim_users AS
SELECT 
    user_id,
    first_name,
    last_name,
    email,
    department,
    role,
    join_date
FROM silver.lms_users;
ALTER TABLE gold.dim_users ADD PRIMARY KEY (user_id);

-- DIM_MODULES: For Course and Content-type filtering
DROP TABLE IF EXISTS gold.dim_modules;
CREATE TABLE gold.dim_modules AS
SELECT 
    m.module_id,
    m.module_name,
    c.course_name,
    c.category
FROM silver.lms_modules m
JOIN silver.lms_courses c ON m.course_id = c.course_id;
ALTER TABLE gold.dim_modules ADD PRIMARY KEY (module_id);

-- DIM_TIME: For Time-series and Trend analysis (Daily Activity)
DROP TABLE IF EXISTS gold.dim_date;
CREATE TABLE gold.dim_date AS
SELECT 
    datum AS date_id,
    EXTRACT(YEAR FROM datum) AS year,
    TO_CHAR(datum, 'Month') AS month_name,
    EXTRACT(DAY FROM datum) AS day,
    TO_CHAR(datum, 'Day') AS day_name,
    CASE WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN 'Weekend' ELSE 'Weekday' END AS day_type
FROM (
    SELECT generate_series('2025-01-01'::DATE, '2026-12-31'::DATE, '1 day'::INTERVAL)::DATE AS datum
) AS calendar;
ALTER TABLE gold.dim_date ADD PRIMARY KEY (date_id);

/* =============================================================
   2. FACT TABLE (The Analytics Engine)
============================================================= */

-- FACT_USER_PERFORMANCE: Central table for all KPI Metrics
DROP TABLE IF EXISTS gold.fact_user_performance;
CREATE TABLE gold.fact_user_performance AS
SELECT 
    u.user_id,
    u.join_date::DATE AS join_date_id, -- Links to dim_date
    -- KPI 1: Performance (Target 62.46 Avg Score)
    ROUND(AVG(qa.score), 2) AS avg_quiz_score,
    -- KPI 2: Progress (Funnel Analysis)
    MAX(la.progress_percent) AS max_progress,
    -- KPI 3: Awareness Shift (Survey Lift)
    pre.awareness_score AS pre_score,
    post.awareness_score AS post_score,
    (COALESCE(post.awareness_score, 0) - COALESCE(pre.awareness_score, 0)) AS knowledge_gain
FROM silver.lms_users u
LEFT JOIN silver.lms_quiz_attempts qa ON u.user_id = qa.user_id
LEFT JOIN silver.lms_lesson_activity la ON u.user_id = la.user_id
LEFT JOIN silver.survey_combined pre ON u.email = pre.user_email AND pre.survey_stage = 'pre'
LEFT JOIN silver.survey_combined post ON u.email = post.user_email AND post.survey_stage = 'post'
GROUP BY u.user_id, u.join_date, pre.awareness_score, post.awareness_score;

/* =============================================================
   3. ANALYTICS VIEWS (Reporting Ready)
============================================================= */

-- View for "Avg Quiz Score by module_name"
CREATE OR REPLACE VIEW gold.view_module_ranking AS
SELECT 
    dm.module_name,
    ROUND(AVG(qa.score), 2) AS avg_score
FROM gold.dim_modules dm
JOIN silver.lms_quiz_attempts qa ON dm.module_id = qa.module_id
GROUP BY dm.module_name;
