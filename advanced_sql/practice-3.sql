WITH first_quarter AS (
    SELECT 
        *
    FROM 
        january_jobs AS january

    UNION ALL

    SELECT 
        *
    FROM 
        february_jobs AS february

    UNION ALL

    SELECT 
        *
    FROM 
        march_jobs AS march
)
SELECT 
    job_title,
    job_location,
    salary_year_avg,
    job_via
FROM 
    first_quarter
WHERE 
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC