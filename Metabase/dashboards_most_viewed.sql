    /* Most viewed dasboards in the last 3 months */
select rd.name as DashboardName, count(cu.id) as viewCount, rd.description as DashboardDescription
from core_user cu
INNER JOIN view_log vl on vl.user_id = cu.id
INNER JOIN report_dashboard rd on rd.id = vl.model_id
where vl.model='dashboard' 
-- last 3 months
AND str_to_date(concat(date_format(vl.timestamp, '%Y-%m'), '-01'), '%Y-%m-%d') 
   BETWEEN str_to_date(concat(date_format(date_add(now(6), INTERVAL -3 month), '%Y-%m'), '-01'), '%Y-%m-%d')
   AND str_to_date(concat(date_format(now(6), '%Y-%m'), '-01'), '%Y-%m-%d')

GROUP BY rd.name, rd.description
ORDER BY viewCount DESC
