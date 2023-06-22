# Step 1: identify all the queries contain the term I need to update
SELECT 
    dataset_query,
    *
FROM report_card 
where dataset_query like '%native%'	-- to isolate those in native SQL
and dataset_query ~* 'field\/edit\/\?id=.[\|]{2}your_old_value'

# Step 2: update the queries
UPDATE
	report_card
SET 
	dataset_query = REGEXP_REPLACE
	(
	dataset_query,				
	'field\/edit\/\?id=.[\|]{2}your_old_value',
	'field/edit/?id='||'||your_new_value',
	'g'									
	)	
WHERE 
		dataset_query like '%native%'			
		AND dataset_query ~* 'field\/edit\/\?id=.[\|]{2}field_id'
