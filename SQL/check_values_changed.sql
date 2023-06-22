(   SELECT 'original' as source, * FROM Table1
    EXCEPT distinct
    SELECT 'original' as source, * FROM Table2)  
UNION ALL
(   SELECT 'atual' as source, * FROM Table2
    EXCEPT distinct
    SELECT 'atual' as source, * FROM Table1) 
