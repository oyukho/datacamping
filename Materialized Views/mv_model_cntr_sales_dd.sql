-- DROP MATERIALIZED VIEW mv_model_cntr_sales_dd
CREATE MATERIALIZED VIEW mv_model_cntr_sales_dd
    REFRESH
        COMPLETE
        ON DEMAND
        START WITH SYSDATE NEXT (current_timestamp + 1/2)
 AS
SELECT *
    FROM (SELECT TRUNC(TO_DATE(event_id, 'dd.mm.yy'), 'mm') event_id
                , COUNTRY_DESC
                , quantity_sales
            FROM o_yukho_admin.sa_transactions T1
                    LEFT JOIN u_dw_references.LC_COUNTRIES T2 ON T2.GEO_ID = T1.geo_sale
                GROUP BY TRUNC(TO_DATE(event_id, 'yy.mm.dd'), 'mm')
                         , COUNTRY_DESC
                MODEL PARTITION BY (TRUNC(TO_DATE(event_id, 'yy.mm.dd') ,'mm') event_id
                                    , COUNTRY_DESC)
                    DIMENSION BY (0 dummy)
                    MEASURES (count(*) quantity_sales)
                    RULES ()
                    ORDER BY quantity_sales DESC
                    );
                    
SELECT * 
FROM mv_model_cntr_sales_dd