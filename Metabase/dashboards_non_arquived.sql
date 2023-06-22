/* Current dashboards and their questions */
SELECT rd.id, rd.name as DashboardName, rd.description as DashboardQuestion, q.name as QuestionName, q.description as QuestionDescription, q.display as QuestionDisplay
FROM report_dashboard rd
INNER JOIN report_dashboardcard rdc on rd.id = rdc.dashboard_id
INNER JOIN report_card q on q.id = rdc.card_id
where rd.archived = 0 and q.archived = 0;
