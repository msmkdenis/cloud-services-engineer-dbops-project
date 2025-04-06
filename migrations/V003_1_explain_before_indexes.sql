DO $$
DECLARE
    r TEXT;
BEGIN
    SELECT string_agg(query_plan, E'\n') INTO r
    FROM (
        EXPLAIN (ANALYZE, VERBOSE)
        SELECT 
            o.date_created, 
            SUM(op.quantity) 
        FROM orders AS o
        JOIN order_product AS op ON o.id = op.order_id
        WHERE o.status = 'shipped' 
          AND o.date_created > now() - interval '7 DAY'
        GROUP BY o.date_created
    ) AS plan(query_plan);

    RAISE NOTICE E'\n--- EXPLAIN BEFORE INDEX ---\n%s\n---------------------------', r;
END $$;
