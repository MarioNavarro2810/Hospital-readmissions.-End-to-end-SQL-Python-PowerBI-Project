## 🏥 Hospital-readmissions
## Complete SQL+Python+PowerBI Project

**Final result:** [View on the web](https://app.powerbi.com/view?r=eyJrIjoiNjkzYWFjYmMtYmRmNS00NjVhLTg3NWUtZjBkNmMyYzBiN2E0IiwidCI6IjAzYTBmYjY5LWE0ZDAtNDQyZC1hNGQ0LWNmYjVkYTgwNzUwMCJ9)

## Table of Contents
1. [Objective](#objective)
2. [Project Overview](#project-overview)
3. [Technologies Used](#technologies-used)
4. [Repository Structure](#repository-structure)
   - [1_SQL](#1_sql)
   - [2_Python](#2_python)
     - [01_Data](#01_data)
     - [02_Notebooks](#02_notebooks)
     - [Python_Documentation.pdf](#pythondocumentationpdf)
   - [3_PowerBI](#3_powerbi)
     - [Reports](#reports)
     - [Full_Explanation.pdf](#fullexplanationpdf)


### Objective
This project aims to **predict hospital readmission risk** by building an **end-to-end data pipeline** that connects **SQL data extraction**, **Python preprocessing and modeling**, and **Power BI visualization**.  
The final product supports **clinical decision-making**, helping hospitals **reduce readmissions** and **optimize resource allocation**.


### Project Overview  
**Hospital readmissions** are among the most relevant operational and clinical issues in healthcare.  
They often stem from preventable causes such as premature discharges, inadequate post-discharge follow-up, or unaddressed comorbidities.  
By leveraging data analytics, hospitals can identify **which patients are most at risk of being readmitted** and implement targeted interventions, such as home monitoring programs or optimized discharge planning.

From a management perspective, reducing avoidable readmissions translates into:
- Lower hospitalization costs and optimized bed occupancy.  
- Improved patient outcomes and satisfaction.  
- Data-backed resource allocation and strategic planning.

This project proposes a complete **end-to-end analytical solution** designed to understand, predict, and mitigate hospital readmissions through the use of data analytics, statistical modeling, and business intelligence.

The workflow integrates all stages of the data lifecycle with the ultimate goal of **supporting clinical decision-making and resource optimization**.


**Our analytical workflow:**

1. **SQL – Data Extraction and Integration**

All data operations start within the hospital database (`dm_cardiologia`).  
Using advanced **SQL analytical queries**, the dataset is explored and key performance indicators are computed to understand patient behavior and hospitalization dynamics.

Main SQL tasks include:
- **Descriptive metrics** such as *total number of patients and admissions*
- **Readmission analytics** such as *average admissions and unique patients per month*


2. **Python – Preprocessing and Risk Modeling**  
   - Data imported from SQL and analyzed using `pandas` and `numpy`.  
   - Statistical hypothesis testing to identify significant risk factors:  
     - **Chi-square test (χ²)** for associations between categorical variables (e.g., diagnosis, treatment type, readmission).  
     - **t-Student test** for mean comparison across patient groups (e.g., age, length of stay).  
   - Development of a **custom scoring function (`calcular_scoring`)** assigning weighted points to each variable based on its relationship with readmission risk.  
  
3. **Power BI – Visualization and Insights**

   - The final dataset from SQL was **imported** into Power BI for data visualization and reporting.

   - **Basic transformations** were applied in Power Query (mainly regional and formatting adjustments).

   - **Interactive dashboards** were designed to display key insights on admissions, readmissions, and risk segmentation.

   - **Visual interactions** were refined for a clear analytical flow
  
   - **Final publication** to online PowerBI Service

### Technologies Used  

| Layer | Tools / Libraries |
|-------|-------------------|
| Database & Queries | MySQL / SQL Server (CTEs, Subqueries, Window Functions) |
| Data Analysis | Python, pandas, numpy, scipy |
| Statistical Testing | Chi-square test (χ²), t-Student test |
| Modeling | Custom Risk Scoring Function |
| Visualization | Power BI |
| Version Control | Git & GitHub |


### Repository Structure  

### [1_SQL/](./1_SQL)

Contains all **database-related resources** used for analytical exploration and integration.

- [**Dump.sql**](./1_SQL/Dump.sql) → SQL **database dump** with all tables, ready to restore in MySQL or SQL Server 
- [**Queries.sql**](./1_SQL/Queries.sql) → Main SQL script with **all analytical queries** 
- [**Data Documentation.pdf**](./1_SQL/Data%20Documentation.pdf) → Full **database documentation**, including:  
  - Entity–Relationship (ER) diagram  
  - Table definitions and relationships  
  - Data dictionary and integrity notes  
- [**Executive Summary.pdf**](./1_SQL/Executive%20Summary.pdf) → Short **executive report** summarizing SQL insights and conclusions


### [2_Python/](./2_Python)

Contains all **Python notebooks and scripts** used for data processing, statistical testing, risk modeling, and final production deployment.  
This layer connects the **SQL analytical base** with the **Power BI visualization layer**, acting as the core of the analytical pipeline.

---

#### [01_Data/](./2_Python/01_Data)
Stores **temporary or intermediate files** generated during notebook execution (e.g., cached `.pickle` dataframes).  
This folder is automatically created when running the notebooks and is not tracked in Git.  

#### [02_Notebooks/](./2_Python/02_Notebooks)
Contains all **Jupyter notebooks** used throughout the analytical and modeling workflow:

- [**01_Data Loading and Integration.ipynb**](./2_Python/02_Notebooks/01_Data%20Loading%20and%20Integration.ipynb) →
    Loads hospital data directly from       SQL, merges tables, and integrates them into a single analytical dataset.  
  

- [**02_Data Quality and Exploratory Data Analysis.ipynb**](./2_Python/02_Notebooks/02_Data%20Quality%20and%20Exploratory%20Data%20Analysis.ipynb)  
  Performs **data quality checks** (missing values, inconsistencies) and **exploratory data analysis (EDA)**.  
  Produces descriptive statistics, categorical distributions, and outlier detection.  
  

- [**03_Minicube and Risk Scorecard.ipynb**](./2_Python/02_Notebooks/03_Minicube%20and%20Risk%20Scorecard.ipynb)  
  Applies **statistical hypothesis testing** (Chi-square and t-Student) to identify key risk factors.  
  Builds a **minicube** for analysis and develops a **custom risk scorecard** using rule-based scoring logic.

- [**04_Production.py**](./2_Python/02_Notebooks/04_Production.py)  
  Final **production-ready script** that automates the entire process:  
  - Connects to the SQL database  
  - Cleans and integrates data  
  - Calculates the readmission **risk score** for each patient  
  - Outputs the final dataset (`risk_scored_patients.csv`)

#### [Python_Explanation.pdf](./2_Python/Python_Explanation.pdf)
Comprehensive **PDF documentation** covering the full Python stage of the project, including:
  - Detailed explanations of each notebook and its purpose  
  - Execution workflow and data flow across the pipeline
---

### [3_PowerBI/](./3_PowerBI)

Contains all **visualization assets** and the **final analytical dashboards** developed in Power BI.  
This stage transforms the processed data into dynamic and interactive reports for strategic insights.

#### [Reports/](./3_PowerBI/Reports)
Includes all final **Power BI report files**:
- [**cardiology_dashboard.pbix**](./3_PowerBI/reports/Cardiology_Dashboard.pbix) → Interactive Power BI dashboard with admissions and readmission analytics.  
- [**cardiology_dashboard.pdf**](./3_PowerBI/reports/Cardiology_Dashboard.pdf) → Exported version of the Power BI report for static sharing or documentation purposes.  

#### [Full_Explanation.pdf](./3_PowerBI/Full_explanation.pdf)
Contains the **step-by-step documentation** of the Power BI development process, covering:  
- Data connection from SQL Server  
- Power Query transformations  
- Data modeling and relationships  
- DAX measures and KPI logic  
- Dashboard design, structure, and visuals 

**Final result:** [View on the web](https://app.powerbi.com/view?r=eyJrIjoiNjkzYWFjYmMtYmRmNS00NjVhLTg3NWUtZjBkNmMyYzBiN2E0IiwidCI6IjAzYTBmYjY5LWE0ZDAtNDQyZC1hNGQ0LWNmYjVkYTgwNzUwMCJ9)

  

