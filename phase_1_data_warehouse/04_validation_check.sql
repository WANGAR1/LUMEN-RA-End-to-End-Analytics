/* ===============================================================================
   Project Validation Script
===============================================================================
Script Purpose:
    Run this script after the Gold Layer is deployed to verify data integrity.
    This ensures the numbers in the database match the Power BI Dashboard.
=============================================================================== */

-- 1. KPI VERIFICATION (Check against Dashboard Cards)
SELECT 
    (SELECT COUNT(DISTINCT user_id) FROM gold.dim_users) AS total_users_check, -- Should be 46 
    ROUND(AVG(avg_quiz_score), 2) AS dashboard_avg_quiz_score,                -- Should be 62.46 [cite: 37, 41]
    (SELECT COUNT(*) FROM silver.lms_lesson_activity WHERE status = 'completed') AS completed_count -- Should be 57 
FROM gold.fact_user_performance;

-- 2. FUNNEL INTEGRITY (Check against "Where Are Users Dropping Off")
SELECT 
    status, 
    COUNT(DISTINCT user_id) AS user_count 
FROM silver.lms_lesson_activity 
WHERE status IN ('in_progress', 'completed', 'started') -- [cite: 10, 12, 14]
GROUP BY status 
ORDER BY user_count DESC;

-- 3. SCHEMA ORPHAN CHECK (Ensure no data was lost in transformation)
SELECT 
    'Bronze' AS layer, COUNT(*) AS row_count FROM bronze.lms_users
UNION ALL
SELECT 
    'Silver' AS layer, COUNT(*) AS row_count FROM silver.lms_users
UNION ALL
SELECT 
    'Gold' AS layer, COUNT(*) AS row_count FROM gold.dim_users;