WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs

SELECT 
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE 
    company_id IN (
        SELECT company_id
        FROM job_postings_fact
        WHERE job_no_degree_mention = 'true'
        ORDER BY company_id
)
