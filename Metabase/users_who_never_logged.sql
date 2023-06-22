/* users who have never logged in */
select id, email, first_name, last_name
from core_user
where last_login is null;
