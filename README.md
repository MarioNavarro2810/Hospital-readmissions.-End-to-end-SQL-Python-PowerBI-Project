# Hospital-readmissions.
# End-to-end SQL+Python+PowerBI Project

**Objective:**  
This project aims to **predict hospital readmission risk** by building an **end-to-end data pipeline** that connects **SQL data extraction**, **Python preprocessing and modeling**, and **Power BI visualization**.  
The final product supports **clinical decision-making**, helping hospitals **reduce readmissions** and **optimize resource allocation**.

## Project Overview  
Hospital readmissions are a critical indicator of care quality and financial efficiency.  
By analyzing patient data, we can detect **risk patterns** and identify which patients are **most likely to be readmitted** after discharge.

This project integrates all stages of a real-world data analytics workflow:

1. **SQL – Data Extraction and Integration**  

All data operations start within the hospital database (`dm_cardiologia`).  
Using advanced **SQL analytical queries**, the dataset is explored and key performance indicators are computed to understand patient behavior and hospitalization dynamics.

Main SQL tasks include:
- **Descriptive metrics** such as:
  - Total number of patients and admissions.  
  - Gender distribution and average patient age.  
  
- **Readmission analytics** such as: 
  - Average admissions and unique patients per month (using subqueries).  
  - Percentage of patients with more than one admission.  


2. **Python – Preprocessing and Risk Modeling**  
   - Data imported from SQL and analyzed using `pandas` and `numpy`.  
   - Statistical hypothesis testing to identify significant risk factors:  
     - **Chi-square test (χ²)** for associations between categorical variables (e.g., diagnosis, treatment type, readmission).  
     - **t-Student test** for mean comparison across patient groups (e.g., age, length of stay).  
   - Development of a **custom scoring function (`calcular_scoring`)** assigning weighted points to each variable based on its relationship with readmission risk.  
  
3. **Power BI – Visualization and Insights**
   - Processed data from Python is stored in SQL tables.
   - Power BI connects directly to the SQL database to build **interactive dashboards**.  
   - Visual outputs include:
     ........

## Technologies Used  

| Layer | Tools / Libraries |
|-------|-------------------|
| Database & Queries | MySQL / SQL Server (CTEs, Subqueries, Window Functions) |
| Data Analysis | Python, pandas, numpy, scipy |
| Statistical Testing | Chi-square test (χ²), t-Student test |
| Modeling | Custom Risk Scoring Function |
| Visualization | Power BI |
| Version Control | Git & GitHub |


## Repository Structure  

### 1. `/sql`

Contains all **database-related resources** used for analytical exploration and integration.

- **`/dump/`** → SQL **database dump** with all tables, ready to restore in MySQL or SQL Server 
- **`01_sql_analysis.sql`** → Main SQL script with **all analytical queries** 
- **`dm_cardiologia_documentation.pdf`** → Full **database documentation**, including:  
  - Entity–Relationship (ER) diagram  
  - Table definitions and relationships  
  - Data dictionary and integrity notes  
- **`executive_summary.pdf`** → Short **executive report** summarizing SQL insights and conclusions
