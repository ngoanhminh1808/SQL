--Option_1
SELECT 
    sd.skills ,
    sd.skill_id,
    COUNT (sjd.job_id) AS jobs_num
FROM
    skills_job_dim AS sjd
LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    sjd.job_id IN (
        SELECT 
            jp.job_id
        FROM 
            job_postings_fact AS jp
        WHERE
            jp.job_location = 'Anywhere' AND
            jp.job_title_short = 'Data Analyst'
    )
GROUP BY
    sd.skills,
    sd.skill_id
ORDER BY
    jobs_num DESC
LIMIT 5
-- Option_2
WITH jobs_postings_num AS (
    SELECT 
        skill_id,
        COUNT (sjd.job_id) AS jobs_num
    FROM
        skills_job_dim AS sjd
    WHERE 
        sjd.job_id IN (
            SELECT 
                job_id 
            FROM 
                job_postings_fact AS jp
            WHERE 
                jp.job_location = 'Anywhere' AND
                jp.job_title_short = 'Data Analyst'
        )
    GROUP BY 
        skill_id
)
SELECT 
    jpn.skill_id,
    sd.skills,
    jpn.jobs_num
FROM
    jobs_postings_num AS jpn
LEFT JOIN skills_dim AS sd ON sd.skill_id = jpn.skill_id
ORDER BY
    jpn.jobs_num DESC
LIMIT 5


