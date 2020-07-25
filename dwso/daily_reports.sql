--top 5 countries by sales
SELECT event_id
       , COUNTRY_DESC
       , quantity_sales
FROM   (SELECT event_id
                , geo_sale
                , count(*)  as quantity_sales       
            FROM o_yukho_admin.sa_transactions
            GROUP BY event_id, geo_sale
            ORDER BY quantity_sales DESC
            ) T1 
            LEFT JOIN u_dw_references.LC_COUNTRIES T2 ON T2.GEO_ID = T1.geo_sale
WHERE ROWNUM <= 5
            AND event_id = '19.09.14';
 
 
--top 5 products in country by sales 
SELECT event_id
       , product
       , quantity_sales
FROM   (SELECT event_id
                , geo_sale
                , product
                , count(*)  as quantity_sales
            FROM o_yukho_admin.sa_transactions
            GROUP BY CUBE(event_id, geo_sale, product)
            ORDER BY quantity_sales DESC
            ) T1 
            LEFT JOIN u_dw_references.LC_COUNTRIES T2 ON T2.GEO_ID = T1.geo_sale
WHERE ROWNUM <= 5
            AND event_id = '19.09.14'
            AND COUNTRY_DESC = 'Belarus'
            AND product IS NOT NULL
            AND event_id IS NOT NULL
            AND product IS NOT NULL


-- 5 products that are in low demand in all countries
--and how much sales differ from average sales
WITH 
 T1 AS (
    SELECT event_id
            , product
            , quantity_sales 
    FROM   (SELECT event_id ,product
                , count(*)  as quantity_sales 
            FROM o_yukho_admin.sa_transactions
            GROUP BY event_id, product
            )
    ),
T2 AS(
    SELECT event_id, ROUND(AVG(quantity_sales), 2) avv_sales_daily
    FROM T1
    GROUP BY event_id
    ),
T3 AS(
    select  T1.event_id
            , product
            , quantity_sales
            , avv_sales_daily
    FROM T1,T2
    WHERE T1.event_id = T2.event_id
        AND  T1.event_id = '19.09.14'
    ORDER BY quantity_sales
    )
SELECT * 
FROM T3
WHERE ROWNUM <= 5;





            