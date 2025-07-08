#### Student Result Processing System ###

A full-stack SQL + Power BI project that manages and analyzes student academic performance using normalized relational databases and interactive dashboards.

# Project Overview

This system handles:
- Student, course, semester, and grade data
- Automatic GPA and grade assignment
- Result reports and performance summaries
- Power BI dashboard for visual insights


# Tools Used
- **Database:** MySQL Workbench
- **Visualization:** Microsoft Power BI
- **Design:** EER Diagram

# Database Design

*Tables Created:**
- `Students`
- `Courses`
- `Semesters`
- `Grades`

*Features:
- Trigger to auto-calculate GPA and Grade before insert
- Normalized schema (3NF)
- Referential integrity with foreign keys


# Power BI Dashboard

Key Visuals:
- 📈 GPA trends by semester
- 🧑‍🎓 Topper ranking table
- 🔘 Donut chart of grade distribution
- ✅ Pass/fail breakdown
- 🎯 KPI cards (Average GPA, Total Students, Failed Count)

---

# SQL Features Implemented
- `CASE`, `GROUP BY`, `RANK()`, `HAVING`, and subqueries
- Views for simplified analytics:
  - `StudentFullResult`
  - `SemesterTopperView`
  - `AllStudentsSummaryView`
  - `SemesterGPAView`
  - `FailedSubjects`


## 📝 Project Report
See the `StudentResult_Project_Report.pdf` for an overview of the system architecture, implementation steps, and summary.
