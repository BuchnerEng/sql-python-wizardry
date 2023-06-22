-- weeky active users
select
    date_trunc('week', created_at) as week_at,
    count(distinct user_id) as weekly_active_users
from
    core_session
group by 1
order by 1 asc
