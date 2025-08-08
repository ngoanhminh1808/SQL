SELECT 
    cd.name AS company_name
FROM 
    job_postings_fact AS jp
JOIN company_dim AS cd ON jp.company_id = cd.company_id
WHERE  
    jp.job_health_insurance = TRUE
    AND EXTRACT (YEAR FROM jp.job_posted_date) =  2023
    AND EXTRACT (QUARTER FROM jp.job_posted_date) = 2


