# Phase 1 — Data Warehouse

## Overview
This phase covers the full data infrastructure built for the 
Lumera platform using the Medallion Architecture.

## What Is In This Folder
- Database schema diagram (Bronze layer)
- Synthetic CSV datasets generated via Mockaroo
- SQL scripts for loading Bronze layer tables
- Silver layer cleaning scripts
- Gold layer analytics queries

## Architecture
The warehouse follows three layers:
- **Bronze** — Raw data loaded directly from CSV files
- **Silver** — Cleaned and validated data
- **Gold** — Business-ready tables for reporting

## Tables
- lms_users — 39 learners (11 admins excluded)
- lms_courses — 5 courses
- lms_modules — 15 modules with content type
- lms_lesson_activity — 111 learner activity events
- lms_quiz_attempts — 96 learner quiz attempts

## Tools
SQL Server · dbdiagram.io · Mockaroo · Excel

## Full Details
See the /documentation folder for complete schema design, 
data generation process, and architecture decisions.
