/* ===============================================================================
   Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables.
=============================================================================== */

-- Create Schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS bronze;

/* =====================================================
    BRONZE LAYER TABLES
    Digital Allyship Toolkit – Raw Data
   ===================================================== */

-- USERS
DROP TABLE IF EXISTS bronze.lms_users;
CREATE TABLE bronze.lms_users (
    user_id VARCHAR PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    department VARCHAR,
    role VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- COURSES
DROP TABLE IF EXISTS bronze.lms_courses;
CREATE TABLE bronze.lms_courses (
    course_id VARCHAR PRIMARY KEY,
    course_name VARCHAR,
    category VARCHAR,
    created_at TIMESTAMP
);

-- MODULES
DROP TABLE IF EXISTS bronze.lms_modules;
CREATE TABLE bronze.lms_modules (
    module_id VARCHAR PRIMARY KEY,
    course_id VARCHAR, -- Foreign key constraints removed for raw import flexibility
    module_name VARCHAR,
    sequence_no INT
);

-- LESSON ACTIVITY
DROP TABLE IF EXISTS bronze.lms_lesson_activity;
CREATE TABLE bronze.lms_lesson_activity (
    activity_id VARCHAR PRIMARY KEY,
    user_id VARCHAR,
    module_id VARCHAR,
    status VARCHAR,
    progress_percent NUMERIC(5,2),
    event_time TIMESTAMP
);

-- QUIZ ATTEMPTS
DROP TABLE IF EXISTS bronze.lms_quiz_attempts;
CREATE TABLE bronze.lms_quiz_attempts (
    attempt_id VARCHAR PRIMARY KEY,
    user_id VARCHAR,
    module_id VARCHAR,
    score NUMERIC(5,2),
    attempt_date TIMESTAMP
);

-- PRE ASSESSMENT
DROP TABLE IF EXISTS bronze.survey_pre_assessment;
CREATE TABLE bronze.survey_pre_assessment (
    response_id VARCHAR PRIMARY KEY,
    user_email VARCHAR,
    confidence_level INT,
    awareness_score NUMERIC(5,2),
    submission_date TIMESTAMP
);

-- POST ASSESSMENT
DROP TABLE IF EXISTS bronze.survey_post_assessment;
CREATE TABLE bronze.survey_post_assessment (
    response_id VARCHAR PRIMARY KEY,
    user_email VARCHAR,
    confidence_level INT,
    awareness_score NUMERIC(5,2),
    submission_date TIMESTAMP
);