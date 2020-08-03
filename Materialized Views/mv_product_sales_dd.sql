CREATE MATERIALIZED VIEW mv_product_sales_dd
BUILD DEFERRED
REFRESH  ON COMMIT
AS
SELECT  TO_DATE(event_id, 'yy.mm.dd')  event_id
                , COUNTRY_DESC
                , product
                , count(*)  as quantity_sales
            FROM o_yukho_admin.sa_transactions  T1 
                LEFT JOIN u_dw_references.LC_COUNTRIES T2 
                    ON T2.GEO_ID = T1.geo_sale                            
            GROUP BY TO_DATE(event_id, 'yy.mm.dd') 
                            , COUNTRY_DESC
                            , product
            ORDER BY quantity_sales DESC;           