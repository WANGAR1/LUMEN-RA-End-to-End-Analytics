# Phase 2 — Ad Hoc Analysis

## Overview
Ad hoc analysis involves answering unplanned, one-off business 
questions that arise from stakeholder curiosity or patterns spotted 
during analysis. This phase goes beyond the planned dashboards to 
investigate specific behavioural questions directly from the 
warehouse data.

The ad hoc dashboard was built using **Luca Studio** and contains 
four visualizations each answering a distinct business question.

---

## Dashboard — Team 39 | Ad Hoc Performance Analysis


<img width="1876" height="779" alt="Screenshot 2026-02-26 231515" src="https://github.com/user-attachments/assets/35e34019-a964-4df3-8542-7224e3bfdc07" />



<img width="1869" height="619" alt="Screenshot 2026-02-26 231528" src="https://github.com/user-attachments/assets/3d788462-9101-4690-8158-4230f0ed7f0c" />


### Visual 1 — Monthly Active Users (MAU) Trend
**Line Chart**

**Business Question:**
Is the Digital Allyship Toolkit gaining momentum, or is user 
interest fading over time?

**Ad Hoc Questions Answered:**
- What was the percentage growth in unique users between 
  Month 1 and Month 3?
- Can we identify specific months where engagement spiked 
  and correlate that with company-wide initiatives?

---

### Visual 2 — Module Completion Funnel
**Bar Chart**

**Business Question:**
Where is the friction in our learning journey? At what point 
do we lose the most potential allies?

**Ad Hoc Questions Answered:**
- Which specific module has the highest abandonment rate?
- Is the drop-off occurring at advanced technical modules 
  or early in the introductory phase?

---

### Visual 3 — Impact by Department
**Ranked Table**

**Business Question:**
Which departments are leading the company in allyship culture, 
and which ones need more leadership support?

**Results:**
1. Education — 68.62
2. Management — 66.45
3. Legal — 63.72
4. Community — 56.49
5. HR — 53.47

**Ad Hoc Questions Answered:**
- Is there a correlation between high participation (volume) 
  and high quiz scores (quality) within specific departments?
- Which department has the highest completion to 
  registration ratio?

---

### Visual 4 — Distribution of Score by Status
**Scatter Plot**

**Business Question:**
Are our users truly mastering the content, or are they simply 
clicking through to finish the requirement?

**Ad Hoc Questions Answered:**
- Do we have a cluster of high progress / low score users 
  who might need a content refresher?
- Does the data show that users who spend more time on 
  modules consistently achieve higher certification scores?

---

## Key Insight Summary

The ad hoc analysis revealed that engagement is not uniform 
across the platform. While some departments like Education 
score highest on average (68.62), others like HR show 
significantly lower performance (53.47), suggesting targeted 
support is needed. The scatter plot analysis identifies whether 
high module progress translates to genuine knowledge mastery 
or surface-level completion — a critical distinction for 
measuring real allyship impact.

---

## Tools Used
Lookerstudio · SQL Server · Mockaroo datasets

## Files
- Ad hoc dashboard screenshot included in this folder

## Full Details
See the /documentation folder for KPIs, business questions 
answered, and key findings from both dashboards.
