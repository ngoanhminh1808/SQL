SELECT 
    skills.skills,
    COUNT (job_postings_fact.job_id) AS demand_num
FROM
    job_postings_fact 
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim AS skills ON skills.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY    
    skills.skills
ORDER BY
    demand_num DESC
LIMIT 5