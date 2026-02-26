/* ===============================================================================
   /* ===============================================================================
Script Purpose:
    This script defines the 'silver' schema tables and performs the data 
    cleaning and casting from the 'bronze' layer.
    It standardizes statuses and formats timestamps for analytics.
    *NOTE: Admin accounts are excluded to focus solely on learner impact.*
=============================================================================== */

-- Create Schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS silver;

/* =====================================================
    SILVER LAYER TABLES & DATA LOAD
   ===================================================== */

-- 1. CLEAN USERS (Excluding Admins)
DROP TABLE IF EXISTS silver.lms_users;
CREATE TABLE silver.lms_users AS
SELECT 
    user_id,
    TRIM(first_name) AS first_name,
    TRIM(last_name) AS last_name,
    LOWER(TRIM(email)) AS email,
    department,
    role,
    created_at AS join_date
FROM bronze.lms_users
WHERE LOWER(role) != 'admin'; -- ⬅️ EXCLUDE ADMINS HERE

-- 2. CLEAN COURSES
DROP TABLE IF EXISTS silver.lms_courses;
CREATE TABLE silver.lms_courses AS
SELECT 
    course_id,
    course_name,
    category
FROM bronze.lms_courses;

-- 3. CLEAN MODULES
DROP TABLE IF EXISTS silver.lms_modules;
CREATE TABLE silver.lms_modules AS
SELECT 
    module_id,
    course_id,
    module_name,
    sequence_no
FROM bronze.lms_modules;

-- 4. CLEAN LESSON ACTIVITY (Filtered by Clean Users)
DROP TABLE IF EXISTS silver.lms_lesson_activity;
CREATE TABLE silver.lms_lesson_activity AS
SELECT 
    activity_id,
    user_id,
    module_id,
    LOWER(TRIM(status)) AS status,
    progress_percent,
    event_time
FROM bronze.lms_lesson_activity
WHERE user_id IN (SELECT user_id FROM silver.lms_users); -- ⬅️ ONLY LEARNERS

-- 5. CLEAN QUIZ ATTEMPTS (Filtered by Clean Users)
DROP TABLE IF EXISTS silver.lms_quiz_attempts;
CREATE TABLE silver.lms_quiz_attempts AS
SELECT 
    attempt_id,
    user_id,
    module_id,
    score,
    attempt_date
FROM bronze.lms_quiz_attempts
WHERE user_id IN (SELECT user_id FROM silver.lms_users); -- ⬅️ ONLY LEARNERS

-- 6. CLEAN SURVEYS (Filtered by Clean Emails)
DROP TABLE IF EXISTS silver.survey_combined;
CREATE TABLE silver.survey_combined AS
SELECT 
    'pre' AS survey_stage,
    user_email,
    confidence_level,
    awareness_score,
    submission_date
FROM bronze.survey_pre_assessment
WHERE user_email IN (SELECT email FROM silver.lms_users) -- ⬅️ ONLY LEARNERS
UNION ALL
SELECT 
    'post' AS survey_stage,
    user_email,
    confidence_level,
    awareness_score,
    submission_date
FROM bronze.survey_post_assessment
WHERE user_email IN (SELECT email FROM silver.lms_users); -- ⬅️ ONLY LEARNERS