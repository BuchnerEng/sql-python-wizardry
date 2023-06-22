/* Questions never viewed in the last 3 months */
SELECT 
  rc.id
, CONCAT('http://your_base_url', rc.id) AS CardUrl
, rc.name AS CardName
, rc.description AS CardDescription
FROM report_card rc
WHERE rc.id NOT IN (
    SELECT vl.model_id
    FROM view_log vl 
    WHERE vl.model='card' 
    -- last 3 months
    AND str_to_date(concat(date_format(vl.timestamp, '%Y-%m'), '-01'), '%Y-%m-%d') 
       BETWEEN str_to_date(concat(date_format(date_add(now(6), INTERVAL -3 month), '%Y-%m'), '-01'), '%Y-%m-%d')
       AND str_to_date(concat(date_format(now(6), '%Y-%m'), '-01'), '%Y-%m-%d')
)
