## Hospital-readmissions
## End-to-end SQL+Python+PowerBI Project

**Objective:**  
This project aims to **predict hospital readmission risk** by building an **end-to-end data pipeline** that connects **SQL data extraction**, **Python preprocessing and modeling**, and **Power BI visualization**.  
The final product supports **clinical decision-making**, helping hospitals **reduce readmissions** and **optimize resource allocation**.

### Project Overview  
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


### 2_Python/

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

#### [Python_Documentation.pdf](./2_Python/Python_Documentation.pdf)
Comprehensive **PDF documentation** covering the full Python stage of the project, including:
  - Detailed explanations of each notebook and its purpose  
  - Execution workflow and data flow across the pipeline  
  

