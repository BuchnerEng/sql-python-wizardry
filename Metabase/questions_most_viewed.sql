/* Most viewed questions in the last 3 months */
SELECT 
  rc.name AS CardName
, COUNT(vl.user_id) AS viewCount
, rc.description AS CardDescription
FROM view_log vl
INNER JOIN report_card rc ON rc.id = vl.model_id
WHERE vl.model='card' 
-- last 3 months
AND str_to_date(concat(date_format(vl.timestamp, '%Y-%m'), '-01'), '%Y-%m-%d') 
   BETWEEN str_to_date(concat(date_format(date_add(now(6), INTERVAL -3 month), '%Y-%m'), '-01'), '%Y-%m-%d')
   AND str_to_date(concat(date_format(now(6), '%Y-%m'), '-01'), '%Y-%m-%d')

GROUP BY rc.name, rc.description
ORDER BY viewCount DESC
