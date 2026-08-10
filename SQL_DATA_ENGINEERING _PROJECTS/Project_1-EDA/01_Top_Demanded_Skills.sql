/*
Question: Which skills are most in demand for Data Engineers
          in the Hungarian job market?

- Join job postings with the skills tables
- Focus on Data Engineer positions in Hungary
- Count how many job postings require each skill
- Rank the skills by demand
- Identify the top 10 most requested skills

Why?
This reveals which technical skills Hungarian employers are
looking for most frequently when hiring Data Engineers.

This can help answer:
"What should I learn if I want to become a Data Engineer
in Hungary?"
*/

SELECT 
    sd.skills,
    count(jpf.job_id) AS "Demand Count"
FROM 
    job_postings_fact jpf
    JOIN
    skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
    JOIN
    skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND
    job_country = 'Hungary'
GROUP BY 
    sd.skills
ORDER BY
    count(jpf.job_id) DESC
LIMIT 
    10;



/*

Here's the breakdown of the most demanded skills for Data Engineers
in Hungary:

    - SQL and Python are by far the most in-demand skills, appearing in
667 and 660 job postings respectively. This shows that strong SQL
and Python knowledge remains the foundation of Data Engineering
roles in the Hungarian job market.

    - Azure and AWS are the most demanded cloud platforms, with Azure
appearing in 393 postings and AWS in 315. This highlights the
importance of cloud technologies for Data Engineers in Hungary.

    - Apache Spark ranks fifth with 248 job postings, showing that big
data processing and distributed data technologies remain important
skills in the Hungarian market.

    - Other highly demanded technologies include Snowflake, Java,
Databricks, Kafka, and Kubernetes. This shows that employers are
looking for a combination of programming, cloud, data warehousing,
streaming, and infrastructure skills.


KEY TAKEAWAYS:

- SQL and Python are the core skills for Data Engineers in Hungary
- Azure and AWS are the leading cloud platforms
- Apache Spark remains an important big data technology
- Snowflake and Databricks show the importance of modern cloud data platforms
- Kafka highlights demand for real-time data and event-streaming skills
- Kubernetes shows that cloud infrastructure knowledge is also valuable
- Java remains relevant for enterprise and large-scale data processing


TOP 10 MOST IN-DEMAND SKILLS:

┌────────────┬──────────────┐
│   skills   │ Demand Count │
├────────────┼──────────────┤
│ sql        │          667 │
│ python     │          660 │
│ azure      │          393 │
│ aws        │          315 │
│ spark      │          248 │
│ snowflake  │          196 │
│ java       │          190 │
│ databricks │          165 │
│ kafka      │          145 │
│ kubernetes │          144 │
└────────────┴──────────────┘
  10 rows         2 columns


============================================================
NOTES / LESSONS LEARNED
============================================================

1. SQL STRING VALUES MUST USE SINGLE QUOTES

   ❌ Incorrect:
      jpf.job_title_short = "Data Engineer"

   ✅ Correct:
      jpf.job_title_short = 'Data Engineer'

   In SQL, double quotes are used for identifiers such as
   column names, while single quotes are used for string values.

   Using double quotes caused DuckDB to interpret
   "Data Engineer" as a column name instead of a text value.

------------------------------------------------------------

2. GROUP BY SHOULD MATCH WHAT YOU WANT TO ANALYZE

   The goal was to find the most in-demand skills.

   ❌ Incorrect:
      GROUP BY jpf.job_id

   ✅ Correct:
      GROUP BY sd.skills

   Since the analysis is about skills, the result needs to
   be grouped by skill.

------------------------------------------------------------
*/