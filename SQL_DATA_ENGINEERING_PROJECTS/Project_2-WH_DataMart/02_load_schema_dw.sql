-- Step 2: DW - Load data from CSV files into star schema tables (Data Warehouse)



SELECT '=== Loading company_dim Table ===' AS info;
-- FIRST TABLE:
INSERT INTO company_dim (company_id, name)
SELECT company_id, name
FROM read_csv_auto('https://storage.googleapis.com/sql_de/company_dim.csv');



SELECT '=== Loading skills_dim Table ===' AS info;
-- SECOND TABLE:
INSERT INTO skills_dim (skill_id, skills, type)
SELECT skill_id, skills, type
FROM read_csv_auto('https://storage.googleapis.com/sql_de/skills_dim.csv');



SELECT '=== Loading job_postings_fact Table ===' AS info;
-- THIRD TABLE:
INSERT INTO job_postings_fact (
    job_id, company_id, job_title_short, job_title, job_location, 
    job_via, job_schedule_type, job_work_from_home, search_location,
    job_posted_date, job_no_degree_mention, job_health_insurance, 
    job_country, salary_rate, salary_year_avg, salary_hour_avg
)
SELECT 
    job_id, company_id, job_title_short, job_title, job_location, 
    job_via, job_schedule_type, job_work_from_home, search_location,
    job_posted_date, job_no_degree_mention, job_health_insurance, 
    job_country, salary_rate, salary_year_avg, salary_hour_avg
FROM read_csv_auto('https://storage.googleapis.com/sql_de/job_postings_fact.csv');



SELECT '=== Loading skills_job_dim Table ===' AS info;
-- FOURTH TABLE:
INSERT INTO skills_job_dim (skill_id, job_id)
SELECT skill_id, job_id
FROM read_csv_auto('https://storage.googleapis.com/sql_de/skills_job_dim.csv');





-- Verify data was loaded correctly
SELECT 'company_dim' AS Table_Name, count(*) AS Record_Count FROM company_dim
UNION ALL
SELECT 'skills_dim', count(*) FROM skills_dim
UNION ALL
SELECT 'job_postings_fact', count(*) FROM job_postings_fact
UNION ALL
SELECT 'skills_job_dim', count(*) FROM skills_job_dim;



-- Show sample data
SELECT '=== Company Dimension Sample ===' AS info;
SELECT * FROM company_dim LIMIT 5;

SELECT '=== Skills Dimension Sample ===' AS info;
SELECT * FROM skills_dim LIMIT 5;

SELECT '=== Job Postings Fact Sample ===' AS info;
SELECT * FROM job_postings_fact LIMIT 5;

SELECT '=== Skills Job Bridge Sample ===' AS info;
SELECT * FROM skills_job_dim LIMIT 5;

