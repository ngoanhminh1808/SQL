WITH skill_demands AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT (skills_job_dim.job_id) AS demand_num
    FROM
        job_postings_fact 
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY    
        skills_dim.skill_id
), salary_avg AS (
    SELECT 
        skills_dim.skill_id,
        ROUND (AVG (job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact 
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY    
        skills_dim.skill_id
)

SELECT 
    skill_demands.skill_id,
    skill_demands.skills,
    demand_num,
    avg_salary
FROM
    skill_demands
INNER JOIN salary_avg ON salary_avg.skill_id = skill_demands.skill_id
WHERE
    demand_num > 10
ORDER BY
    avg_salary DESC,
    demand_num DESC
LIMIT 25


--Rewriting a more concise version

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT (skills_job_dim.job_id) AS demand_num,
    ROUND (AVG (job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING 
    COUNT (skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_num DESC
LIMIT 25