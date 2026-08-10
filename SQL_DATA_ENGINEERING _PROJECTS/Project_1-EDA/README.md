# Hungarian Data Engineering Job Market Analysis
![alt text](image.png)
A SQL project analyzing the **Data Engineering job market in Hungary** using real-world job posting data.

The goal of this project is to understand what Hungarian employers are looking for when hiring Data Engineers, which skills are associated with higher salaries, and which skills provide the best combination of **job demand and earning potential**.

This project focuses on writing clear analytical SQL and turning business questions into practical, data-driven insights.

---

## 🧾 Executive Summary

This project answers three key questions about the Hungarian Data Engineering job market:

1. 🔥 **Which skills are most in demand for Data Engineers in Hungary?**
2. 💰 **Which skills are associated with the highest average salaries?**
3. ⚖️ **Which skills provide the best combination of demand and salary?**

This project analyzes a data warehouse built using a star schema design. The warehouse structure consists of:

![alt text](image-1.png)

### Key findings

- 🧠 **SQL and Python** are the most demanded Data Engineering skills in Hungary.
- ☁️ **Azure and AWS** are the most requested cloud platforms.
- ⚡ **Spark** remains an important technology for big data processing.
- 💰 Some less frequently requested skills are associated with higher average salaries, although these results should be interpreted carefully because the Hungarian dataset is relatively small.
- ⚖️ **Python, SQL, Azure, AWS, and Spark** perform strongly when considering both demand and salary.
- 📊 A simple **Skill Score** was created to combine job demand and average salary.

---

## 🎯 Project Goals

The main goal is to answer:

> **"What does the Hungarian Data Engineering job market value?"**

More specifically:

- What technical skills are employers requesting most?
- Which skills are associated with higher salaries?
- Which skills provide the best balance between job opportunities and earning potential?
- What skills should someone prioritize when preparing for a Data Engineering career in Hungary?

---

## 🧩 Business Questions

### 01 — Most In-Demand Skills

**Question:**

> Which skills are most in demand for Data Engineers in the Hungarian job market?

The analysis:

- Filters for `Data Engineer` positions
- Filters for jobs located in Hungary
- Joins job postings with the skills tables
- Counts job postings for each skill
- Groups the results by skill
- Orders skills by demand
- Returns the top 10

### Result

| Skill | Demand Count |
|---|---:|
| SQL | 667 |
| Python | 660 |
| Azure | 393 |
| AWS | 315 |
| Spark | 248 |
| Snowflake | 196 |
| Java | 190 |
| Databricks | 165 |
| Kafka | 145 |
| Kubernetes | 144 |

### Key insight

**SQL and Python clearly dominate the Hungarian Data Engineering market**, appearing in 667 and 660 job postings respectively.

Azure and AWS follow as the leading cloud platforms, while Spark, Snowflake, Databricks, Kafka, and Kubernetes show demand for modern data engineering and cloud infrastructure technologies.

---

### 02 — Highest-Paying Skills

**Question:**

> Which Data Engineering skills are associated with the highest salaries in Hungary?

The analysis:

- Filters for `Data Engineer` positions
- Filters for Hungary
- Excludes jobs without salary information
- Calculates average yearly salary for each skill
- Counts job postings for each skill
- Groups results by skill
- Uses `HAVING` to require at least 2 job postings
- Orders skills by average salary
- Returns the top 10

### Result

| Skill | Job Postings | Average Salary |
|---|---:|---:|
| Airflow | 2 | 147,500 |
| Shell | 2 | 147,500 |
| Unix | 2 | 147,500 |
| Linux | 2 | 147,500 |
| Oracle | 2 | 147,500 |
| SQL Server | 2 | 147,500 |
| Java | 3 | 143,080 |
| Jenkins | 2 | 140,500 |
| AWS | 4 | 137,371 |
| MongoDB | 2 | 133,500 |

### Important consideration

The Hungarian dataset is relatively small, so the salary results need to be interpreted carefully.

A skill appearing in only two jobs can have a very high average salary simply because those particular jobs are highly paid.

For this reason, the query uses:

```sql
HAVING COUNT(jpf.job_id) >= 2
```
For a much larger dataset, a higher threshold such as **50 or 100 job postings** would provide a more reliable salary comparison.

The threshold of **2** was chosen because the Hungarian dataset is relatively small. Using a higher threshold would remove too many skills and could leave us with little or no useful salary results.

---

## 03 — Best Combination of Demand + Salary

**Question:** Which skills offer the best combination of demand and salary for Data Engineers in Hungary?

The goal is to identify skills that perform well in both:

- **Demand** — how many job postings require the skill
- **Salary** — the average yearly salary of jobs requiring the skill

A simple Skill Score was created:

**Skill Score = Job Postings Count × Average Salary**

### Results

| Skill | Job Postings | Average Salary | Skill Score |
|---|---:|---:|---:|
| Python | 13 | 118,806 | 1,544,482 |
| SQL | 7 | 112,398 | 786,783 |
| Azure | 5 | 122,748 | 613,741 |
| AWS | 4 | 137,371 | 549,482 |
| Spark | 5 | 105,548 | 527,741 |
| Java | 3 | 143,080 | 429,241 |
| Kafka | 3 | 130,815 | 392,444 |
| Oracle | 2 | 147,500 | 295,000 |
| SQL Server | 2 | 147,500 | 295,000 |
| Shell | 2 | 147,500 | 295,000 |

### Key Insight

Python ranks first because it combines relatively strong demand with a strong average salary.

SQL also performs well because it is one of the most important skills in the Hungarian Data Engineering market.

Azure, AWS, and Spark also achieve strong scores because they combine meaningful demand with competitive salaries.

---

## 📊 Understanding the Skill Score

The Skill Score is a **simple scoring method created for this project**.

**Skill Score = Job Postings Count × Average Salary**

For example:

**10 job postings × 60,000 average salary = 600,000 Skill Score**

The idea is:

- High demand + high salary → higher score
- High demand + lower salary → lower score
- Low demand + high salary → lower score
- Low demand + low salary → lowest score

This provides a simple way to identify skills that offer both employment opportunities and earning potential.

### Important Limitation

The Skill Score is **not a statistically normalized metric**.

Demand and salary have very different numerical scales. For example, demand might be `300` while salary might be `60,000`. Because salary has a much larger numerical value, the multiplication is heavily influenced by salary.

A more mathematically balanced approach would normalize demand and salary before combining them.

However, that would require more advanced SQL techniques such as subqueries or CTEs, which are intentionally outside the scope of this project.

For this project, `COUNT() × AVG()` is used as a simple career-opportunity score.

---

## 🗂️ Data Model

The project uses a relational data model containing fact, dimension, and bridge tables.

### Fact Table

**job_postings_fact**

The central table containing job posting information such as:

- job_id
- job_title_short
- job_country
- salary_year_avg
- other job-related attributes

### Dimension Tables

**skills_dim**

Contains the available skills, such as SQL, Python, AWS, Azure, Spark, and Kafka.

**company_dim**

Contains company information connected to job postings.

### Bridge Table

**skills_job_dim**

Connects job postings with skills.

This table is required because:

- one job can require many skills
- one skill can appear in many jobs

This creates a many-to-many relationship between jobs and skills.

---

## 🔗 SQL JOIN Structure

The main skill analyses connect:

**job_postings_fact → skills_job_dim → skills_dim**

The relationship is:

- `job_postings_fact.job_id` → `skills_job_dim.job_id`
- `skills_job_dim.skill_id` → `skills_dim.skill_id`

This allows the analysis to connect each Data Engineer job posting with its required skills.

---

## 🧰 Technologies Used

- 🐤 **DuckDB** — SQL query engine
- 🧮 **SQL** — Data analysis and querying
- 💻 **VS Code** — SQL development environment
- 🗃️ **Relational database** — Fact, dimension, and bridge tables
- 🔧 **Git / GitHub** — Version control

---

## 📂 Repository Structure

    hungarian-data-engineering-analysis/
    │
    ├── 01_top_demanded_skills.sql
    ├── 02_top_paying_skills.sql
    ├── 03_optimal_skills.sql
    │
    └── README.md

### SQL Files

**01_top_demanded_skills.sql**

Finds the 10 most demanded Data Engineering skills in Hungary.

**02_top_paying_skills.sql**

Finds the 10 skills associated with the highest average salaries while requiring at least 2 job postings.

**03_optimal_skills.sql**

Combines demand and salary into a simple Skill Score to identify skills with the strongest overall career opportunity.

---

## 🧠 SQL Concepts Demonstrated

This project intentionally focuses on foundational analytical SQL.

### Filtering — WHERE

The analysis focuses on Data Engineer positions in Hungary:

    WHERE
        jpf.job_title_short = 'Data Engineer'
        AND jpf.job_country = 'Hungary'

### JOINs

Jobs are connected to their required skills using:

    JOIN skills_job_dim sjd
        ON jpf.job_id = sjd.job_id

    JOIN skills_dim sd
        ON sjd.skill_id = sd.skill_id

### Aggregations

**COUNT()** measures skill demand.

**AVG()** calculates average yearly salary.

### GROUP BY

    GROUP BY sd.skills

The results are grouped by skill because the analysis is performed at the skill level.

### HAVING

    HAVING COUNT(jpf.job_id) >= 2

`HAVING` filters grouped results after aggregation.

The threshold of **2** was used because the Hungarian dataset is relatively small. In a much larger dataset, a threshold such as **50 or 100** would provide a more reliable comparison.

### ORDER BY

Used to rank the results by demand, salary, or Skill Score.

### LIMIT

    LIMIT 10

Used to return the top 10 results.

### NULL Handling

    jpf.salary_year_avg IS NOT NULL

Salary analysis only includes jobs where salary information is available.

### Calculated Metrics

    COUNT(jpf.job_id) * AVG(jpf.salary_year_avg)

Creates the Skill Score combining demand and salary.

---

## 📚 SQL Concepts Practiced

| SQL Concept | Purpose |
|---|---|
| SELECT | Select analytical fields |
| WHERE | Filter Data Engineer jobs in Hungary |
| INNER JOIN | Connect jobs with skills |
| GROUP BY | Aggregate results by skill |
| COUNT() | Measure skill demand |
| AVG() | Calculate average salary |
| HAVING | Filter skills by posting frequency |
| ORDER BY | Rank results |
| LIMIT | Return top 10 results |
| IS NOT NULL | Remove missing salary values |
| Calculated columns | Create the Skill Score |

The project intentionally avoids advanced SQL concepts such as:

- CTEs
- Subqueries
- Window Functions
- UNION
- CASE
- Complex date functions

This keeps the project focused on foundational analytical SQL.

---

## 💡 Key Findings

### 1. SQL and Python are foundational

SQL and Python are the two most requested skills:

- SQL → **667 job postings**
- Python → **660 job postings**

This suggests that strong SQL and Python fundamentals are particularly valuable for Data Engineering candidates in Hungary.

### 2. Cloud skills are highly relevant

Azure and AWS are among the most demanded technologies:

- Azure → **393 job postings**
- AWS → **315 job postings**

This highlights the importance of cloud knowledge in modern Data Engineering roles.

### 3. Modern data technologies are valuable

Spark, Snowflake, Databricks, Kafka, and Kubernetes also appear prominently in the demand analysis.

This shows that employers are looking for a combination of:

- programming
- cloud
- data processing
- data platforms
- streaming
- infrastructure

### 4. Salary results require context

Some skills have high average salaries but appear in only a small number of postings.

Several of the highest-paying skills appear in only **2 jobs**.

Therefore, the results should not be interpreted as:

> "This skill guarantees a higher salary."

Instead:

> "Jobs requiring this skill had a higher average salary in this dataset."

### 5. Demand + salary provides another perspective

The Skill Score shows that a skill can be valuable because of:

- high demand
- high salary
- or a combination of both

Python performs particularly well because it combines strong demand with relatively high-paying jobs.

---

## 🎯 What Should a Data Engineer Learn in Hungary?

Based on this dataset, a practical learning priority would be:

### 🥇 Foundation

- SQL
- Python

### 🥈 Cloud

- Azure
- AWS

### 🥉 Data Engineering Platforms

- Spark
- Snowflake
- Databricks

### ⚙️ Streaming & Infrastructure

- Kafka
- Kubernetes
- Java

The results suggest that a strong Data Engineer should not focus on one technology alone.

A practical learning path based on this dataset is:

**SQL + Python → Cloud → Big Data → Data Platforms → Streaming / Infrastructure**

---

## ⚠️ Limitations

### Small Hungarian Dataset

The Hungarian Data Engineering dataset is relatively small compared with a global job market dataset.

This is why the salary analysis uses:

    HAVING COUNT(jpf.job_id) >= 2

rather than a much higher threshold.

With a larger dataset, a threshold such as **50 or 100** would provide more statistically reliable comparisons.

### Salary Availability

Not every job posting contains salary information.

The salary analysis therefore only includes:

    salary_year_avg IS NOT NULL

Therefore, salary results represent jobs with available salary information rather than the entire Hungarian job market.

### Association ≠ Causation

A skill being associated with a higher average salary does not mean that learning the skill directly causes a higher salary.

Salary can also be influenced by:

- seniority
- company
- industry
- location
- experience
- role responsibilities
- other technical skills

### Simple Skill Score

The combined demand/salary score uses:

**COUNT × AVG Salary**

This is useful for this learning project but is not a statistically normalized measure of career value.

---

## 🚀 Future Improvements

Once more advanced SQL concepts are introduced, this project could be extended with:

- 📈 Normalized demand + salary scoring
- 🧮 Salary percentiles
- 📊 Median salary analysis
- 🪟 Window functions for ranking
- 🔎 Subqueries and CTEs
- 🏢 Company-level salary analysis
- 📍 Location-level analysis
- 🏠 Remote vs. on-site comparison
- 📅 Time-based job market trends
- 🎓 Degree requirement analysis
- 💼 Job schedule analysis

These improvements would allow the project to develop from a basic exploratory analysis into a more comprehensive Hungarian Data Engineering market analysis.

---

## 🏁 Conclusion

This project demonstrates how SQL can be used to turn real-world job posting data into practical career insights.

The Hungarian Data Engineering market strongly values:

**SQL + Python + Cloud + Modern Data Engineering Technologies**

SQL and Python dominate skill demand, while Azure and AWS are the leading cloud platforms. Spark, Snowflake, Databricks, Kafka, Kubernetes, and Java show the broader technical ecosystem expected from Data Engineers.

The salary analysis also demonstrates why demand and salary should be considered together rather than independently.

The combined Skill Score provides a simple way to identify skills that offer both employment opportunities and earning potential.

Ultimately, the project answers:

> **What skills should I prioritize if I want to maximize both my employment opportunities and earning potential as a Data Engineer in Hungary?**

Based on this dataset, the strongest starting point is:

**SQL → Python → Cloud → Big Data → Modern Data Platforms**

---

## 📌 Project Summary

This project demonstrates practical SQL skills through a real-world Data Engineering job market analysis.

The main analytical questions were:

1. **Which skills are most in demand?**
2. **Which skills are associated with the highest salaries?**
3. **Which skills provide the best combination of demand and salary?**

The project uses:

**Fact Table + Dimension Tables + Bridge Table + SQL Aggregations + Analytical Ranking**

The main SQL techniques practiced were:

**WHERE → JOIN → GROUP BY → COUNT / AVG → HAVING → ORDER BY → LIMIT**

The final result is a focused analysis of what the **Hungarian Data Engineering job market values** and which skills may provide the strongest combination of career opportunity and earning potential.