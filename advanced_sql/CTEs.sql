WITH job_count AS (
    SELECT 
        company_id,
        COUNT (*) AS number_of_job_postings
    FROM
        job_postings_fact
    GROUP BY 
        company_id
    ORDER BY    
        company_id
)

SELECT 
    cd.name AS company_name,
    jc.number_of_job_postings
FROM
    job_count AS jc
RIGHT JOIN company_dim AS cd ON cd.company_id = jc.company_id
ORDER BY   
    jc.number_of_job_postings DESC