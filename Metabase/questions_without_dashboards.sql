/* Questions without a dashboard */
select q.id, q.name, q.description, q.display, q.query_type
from report_card q
LEFT OUTER JOIN report_dashboardcard rdc on rdc.card_id = q.id
where q.archived = 0 and rdc.card_id is null;
