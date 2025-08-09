SELECT
    job_title,
    job_location,
    cd.name AS company_name,
    job_schedule_type,
    salary_year_avg AS avg_salary
FROM
    job_postings_fact AS jp
LEFT JOIN company_dim as cd ON cd.company_id = jp.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY    
    salary_year_avg DESC
LIMIT 10