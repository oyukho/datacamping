--top 5 countries by sales per month
SELECT COUNTRY_DESC
       , quantity_sales
FROM   (SELECT  geo_sale
                , count(*)  as quantity_sales       
            FROM o_yukho_admin.sa_transactions
            WHERE TO_DATE(event_id, 'yy.mm.dd') between TO_DATE('19-01-01', 'yy-mm-dd') and TO_DATE('19-01-31', 'yy-mm-dd')
            GROUP BY GROUPING SETS(geo_sale)  
            ORDER BY quantity_sales DESC
            ) T1 
            LEFT JOIN u_dw_references.LC_COUNTRIES T2 ON T2.GEO_ID = T1.geo_sale
WHERE ROWNUM <= 5;


 
--top 5 products in country by sales per month
SELECT  product
       , quantity_sales
FROM   (SELECT  geo_sale
                , product
                , count(*)  as quantity_sales
                , GROUPING(geo_sale)gr_sale
                , GROUPING(product)gr_product
            FROM o_yukho_admin.sa_transactions
            WHERE TO_DATE(event_id, 'yy.mm.dd') between TO_DATE('19-01-01', 'yy-mm-dd') and TO_DATE('19-01-31', 'yy-mm-dd')                  
            GROUP BY ROLLUP(geo_sale, product)
            ORDER BY quantity_sales DESC
            ) T1 
            LEFT JOIN u_dw_references.LC_COUNTRIES T2 ON T2.GEO_ID = T1.geo_sale
WHERE ROWNUM <= 5
        AND gr_sale = '0'
        AND gr_product = '0'
        AND COUNTRY_DESC = 'Belarus'


-- 5 products that are in low demand in all countries
--and how much sales differ from average sales per month
WITH 
 T1 AS (
    SELECT product
            , quantity_sales 
    FROM   (SELECT product
                , count(*)  as quantity_sales
            FROM o_yukho_admin.sa_transactions
            WHERE TO_DATE(event_id, 'yy.mm.dd') between TO_DATE('19-01-01', 'yy-mm-dd') and TO_DATE('19-01-31', 'yy-mm-dd')
            GROUP BY  GROUPING SETS(product)
            )
    ),
T2 AS(
    SELECT ROUND(AVG(quantity_sales), 2) avv_sales_daily
    FROM T1
    ),
T3 AS( 
    SELECT * 
    FROM T1, T2
    ORDER BY quantity_sales
)
SELECT * 
FROM T3
WHERE ROWNUM <= 5;


