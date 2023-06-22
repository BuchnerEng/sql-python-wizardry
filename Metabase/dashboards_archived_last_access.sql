-- using view log table see when cards were last accessed and map the card ids to dashboard ids. 
-- (none of my cards are on more than one dash)
with joined as (
    select 
        view_log.model_id as Model_ID,
        date(max(view_log.timestamp)) as Last_Viewed,
        report_dashboardcard.dashboard_id as Dashboard_ID 
    from
        view_log 
        left join report_dashboardcard on view_log.model_id = report_dashboardcard.card_id 
    where 
        view_log.model = 'card'
        and view_log.user_id is null
    group by 
        Model_ID, 
        Dashboard_ID
),

-- get rid of dashboards that are archived
dashboards as (
    select 
        report_dashboard.id as Dashboard_ID,
        report_dashboard.name as Dashboard_Name
    from 
        report_dashboard
    where
        report_dashboard.archived = false
)

-- join two above tables to link dashboard name to dashboard id
select 
    dashboards.dashboard_name as Dashboard_Name,
    max(joined.last_viewed) as last_viewed 
from 
    joined 
    inner join dashboards on joined.dashboard_id = dashboards.dashboard_id
group by 
    Dashboard_Name
order by 
    last_viewed desc
