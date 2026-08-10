/*
Question: Which skills offer the best combination of demand
          and salary for Data Engineers in Hungary?

- Combine the results of skill demand and salary analysis
- Focus on Data Engineer positions in Hungary
- Consider both:
      1. How frequently the skill is requested
      2. How well-paid jobs requiring the skill are
- Create a ranking that balances skill demand and salary
- Identify the top 10 skills that provide the strongest
  combination of career opportunity and earning potential

Why?

A highly demanded skill may have a relatively average salary,
while a high-paying skill may appear in very few job postings.

The goal is therefore not to find the skill with the highest
salary or the highest demand individually.

Instead, identify skills that provide a strong balance between
both factors.

This helps answer:

"What skills should I prioritize if I want to maximize both
my employment opportunities and earning potential in Hungary?"
*/



SELECT
    sd.skills,
    COUNT(jpf.job_id) AS "Job Postings Count",
    AVG(jpf.salary_year_avg) AS "Average Salary",
    COUNT(jpf.job_id) * AVG(jpf.salary_year_avg) AS "Skill Score"
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
    AND jpf.job_country = 'Hungary'
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.job_id) >= 2
ORDER BY
    "Skill Score" DESC
LIMIT
    10;



/*
Here's the breakdown of the Data Engineering skills that offer
the best combination of demand and salary in Hungary:

- Instead of looking only at the most demanded skills or only at
  the highest-paying skills, this analysis considers both factors.

- SQL and Python may have very high demand, while other skills may
  have higher average salaries but appear in fewer job postings.

- To balance these two factors, we calculate a Skill Score using:

      Skill Score = Job Postings Count * Average Salary

- A higher Skill Score means that a skill combines relatively high
  demand with relatively high average salary.

- This helps identify skills that provide both strong employment
  opportunities and earning potential in the Hungarian Data
  Engineering market.

KEY TAKEAWAYS:

- The highest-ranked skills combine strong demand with higher salaries
- A skill does not need to have the highest demand or highest salary
  individually to rank highly
- The Skill Score helps identify skills with a stronger overall
  career opportunity
- Skills with very high demand and good salaries can rank especially
  well
- The results can help identify which skills may be worth prioritizing
  when considering both employability and earning potential


TOP 10 SKILLS WITH THE BEST DEMAND + SALARY COMBINATION:

┌────────────┬────────────────────┬────────────────────┬─────────────┐
│   skills   │ Job Postings Count │   Average Salary   │ Skill Score │
│  varchar   │       int64        │       double       │   double    │
├────────────┼────────────────────┼────────────────────┼─────────────┤
│ python     │                 13 │ 118806.30769230769 │   1544482.0 │
│ sql        │                  7 │ 112397.57142857143 │    786783.0 │
│ azure      │                  5 │           122748.2 │    613741.0 │
│ aws        │                  4 │           137370.5 │    549482.0 │
│ spark      │                  5 │           105548.2 │    527741.0 │
│ java       │                  3 │ 143080.33333333334 │    429241.0 │
│ kafka      │                  3 │ 130814.66666666667 │    392444.0 │
│ oracle     │                  2 │           147500.0 │    295000.0 │
│ sql server │                  2 │           147500.0 │    295000.0 │
│ shell      │                  2 │           147500.0 │    295000.0 │
└────────────┴────────────────────┴────────────────────┴─────────────┘
  10 rows                                                  4 columns


============================================================
IMPORTANT NOTE ABOUT THE SKILL SCORE:
============================================================

The Skill Score is a simple scoring method, not a statistically
normalized score.

We use:

    Skill Score = Job Postings Count * Average Salary

Demand and salary have very different scales. For example,
demand might be 300 while salary might be 60,000, so salary
has a much larger numerical value.

For this SQL learning project, this simple approach is useful
because it allows us to combine demand and salary while practicing:

- COUNT()
- AVG()
- GROUP BY
- HAVING
- ORDER BY
- LIMIT

A more mathematically balanced approach would normalize the
demand and salary values first, but that would require more
advanced SQL such as subqueries or CTEs.

For now, COUNT * AVG is a simple career-opportunity score
used to rank the skills in this project.
*/