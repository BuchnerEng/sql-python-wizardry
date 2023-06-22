# Step 1: I find all the filters that rely on my old column_name
SELECT 
* 
FROM public.metabase_field 
WHERE display_name = 'old_column_name'
    OR name = 'old_column_name'
ORDER BY created_at DESC

# Step 2: update from old to new column_name ( I usually do it one at the time to double check everything)
UPDATE metabase_field
SET display_name = 'new_column_name'
WHERE display_name = 'old_column_name'
