/* data from both table */
SELECT *
FROM progress;
SELECT *
FROM users;

/* top 25 schools */
SELECT email_domain, COUNT (*) as "Top 25 Schools"
FROM users
GROUP BY 1
ORDER BY COUNT(email_domain) DESC
LIMIT 25;

/* learners in New York */
SELECT COUNT(*) as 'Learners located in New York'
FROM users
WHERE city = 'New York';

/* learners using the mobile app */
SELECT COUNT(*) as "Learners using the Mobile App"
FROM users
WHERE mobile_app IS NOT NULL;

/* sign-up date and time using strftime function*/
SELECT strftime('%H', sign_up_at) AS 'Hour of the Day', COUNT(*) AS 'Learners that signed up'
FROM users
GROUP BY 1;

/* join the 2 tables */
SELECT *
FROM users
LEFT JOIN progress
 ON users.user_id = progress.user_id;

/* which schools prefer which courses simple */
WITH temporary_name AS (
  SELECT *
  FROM users
  JOIN progress
  ON users.user_id = progress.user_id)
    SELECT user_id, email_domain, learn_cpp, learn_sql, learn_html, learn_javascript, learn_java
    FROM temporary_name
    ORDER BY email_domain ASC;

/* which schools prefer which courses complex*/
SELECT users.email_domain,
  COUNT(CASE
    WHEN progress.learn_cpp = 'completed'
    OR progress.learn_cpp = 'started'
    THEN '1'
    END) AS 'cpp',
    COUNT(CASE
    WHEN progress.learn_sql = 'completed'
    OR progress.learn_sql = 'started'
    THEN '1'
    END) AS 'sql',
    COUNT(CASE
    WHEN progress.learn_html = 'completed'
    OR progress.learn_html = 'started'
    THEN '1'
    END) AS 'html',
    COUNT(CASE
    WHEN progress.learn_javascript = 'completed'
    OR progress.learn_javascript = 'started'
    THEN '1'
    END) AS 'js',
    COUNT(CASE
    WHEN progress.learn_java = 'completed'
    OR progress.learn_java = 'started'
    THEN '1'
    END) AS 'java'
  FROM users
  LEFT JOIN progress
  ON users.user_id = progress.user_id
  GROUP BY 1;

/* courses the New York students are taking*/
WITH temporary_name AS (
  SELECT *
  FROM users
  LEFT JOIN progress
  ON users.user_id = progress.user_id)
    SELECT user_id, city, learn_cpp, learn_sql, learn_html, learn_javascript, learn_java
    FROM temporary_name
    WHERE city = 'New York';

/* courses the Chicago student are taking*/
WITH temporary_name AS (
  SELECT *
  FROM users
  LEFT JOIN progress
  ON users.user_id = progress.user_id)
    SELECT user_id, city, learn_cpp, learn_sql, learn_html, learn_javascript, learn_java
    FROM temporary_name
    WHERE city = 'Chicago';
