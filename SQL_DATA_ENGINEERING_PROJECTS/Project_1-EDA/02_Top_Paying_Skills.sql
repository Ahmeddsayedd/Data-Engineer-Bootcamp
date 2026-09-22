/*
Question: Which Data Engineering skills are associated with
          the highest salaries in Hungary?

- Join job postings with the skills tables
- Focus on Data Engineer positions in Hungary
- Focus only on jobs with salary information
- Calculate the average salary for each skill
- Count how many job postings require each skill
- Only include skills that appear in a meaningful number
  of job postings
- Identify the top 10 highest-paying skills

Why?
A skill appearing in only one job posting with an unusually
high salary may not be a reliable indicator.

By considering both salary and skill frequency, we can identify
skills that are associated with consistently higher-paying
Data Engineering opportunities in Hungary.
*/



SELECT 
    sd.skills,
    count(jpf.job_id) AS "Job Postings Count",
    AVG(jpf.salary_year_avg) AS "Average Salary"
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
    jpf.salary_year_avg is NOT Null
    AND 
    job_country = 'Hungary'
GROUP BY 
    sd.skills
HAVING
    count(jpf.job_id) >= 2
ORDER BY
    avg(jpf.salary_year_avg) DESC
LIMIT 
    10;



/*
Here's the breakdown of the Data Engineering skills associated
with the highest average salaries in Hungary:

- The results show which skills are associated with the highest
  average yearly salaries among Data Engineer jobs in Hungary.

- We only consider skills that appear in multiple job postings.
  This helps avoid giving too much importance to a skill that
  appears in only one unusually high-paying job.

- The results combine average salary with the number of job
  postings, giving us a more meaningful comparison of skills.

KEY TAKEAWAYS:

- The highest-ranked skills have the highest average yearly salaries
- Looking at multiple job postings makes the salary comparison more reliable
- A high average salary does not necessarily mean the skill causes higher pay
- The results show which skills are associated with higher-paying opportunities

TOP 10 HIGHEST-PAYING DATA ENGINEERING SKILLS:
┌────────────┬────────────────────┬────────────────────┐
│   skills   │ Job Postings Count │   Average Salary   │
│  varchar   │       int64        │       double       │
├────────────┼────────────────────┼────────────────────┤
│ airflow    │                  2 │           147500.0 │
│ shell      │                  2 │           147500.0 │
│ unix       │                  2 │           147500.0 │
│ linux      │                  2 │           147500.0 │
│ oracle     │                  2 │           147500.0 │
│ sql server │                  2 │           147500.0 │
│ java       │                  3 │ 143080.33333333334 │
│ jenkins    │                  2 │           140500.0 │
│ aws        │                  4 │           137370.5 │
│ mongodb    │                  2 │           133500.0 │
└────────────┴────────────────────┴────────────────────┘
  10 rows                                    3 columns


============================================================
NOTES / LESSONS LEARNED
============================================================

1. WHY USE HAVING COUNT >= 2?

   Normally, with a large dataset, we would use a higher number
   such as 50, 100, or more.

   The reason is that a skill appearing in only one or two jobs
   could have a very high average salary simply because of a
   small sample size. Requiring more job postings makes the
   salary comparison more reliable.

   However, the Hungarian Data Engineering dataset is relatively
   small, so using a high number such as 100 would remove too many
   skills and could leave us with little or no useful results.

   Therefore, for this analysis we use:

       HAVING COUNT(jpf.job_id) >= 2

   This allows us to get meaningful results while still avoiding
   skills that appear in only a single job posting.

*/