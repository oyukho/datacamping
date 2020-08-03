--DROP MATERIALIZED VIEW mv_cntr_sales_mm

CREATE MATERIALIZED VIEW mv_cntr_sales_mm
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
AS
SELECT event_id
           , COUNTRY_DESC
           , quantity_sales
    FROM   (SELECT  TRUNC(TO_DATE(event_id, 'yy.mm.dd') ,'mm') event_id
                    , COUNTRY_DESC
                    , count(*)  as quantity_sales       
                FROM o_yukho_admin.sa_transactions T1
                    LEFT JOIN u_dw_references.LC_COUNTRIES T2 ON T2.GEO_ID = T1.geo_sale
                GROUP BY TRUNC(TO_DATE(event_id, 'yy.mm.dd') ,'mm')
                                        , COUNTRY_DESC
                )
     ORDER BY quantity_sales DESC;
     
     
BEGIN                
    DBMS_MVIEW.REFRESH('mv_cntr_sales_mm');
END;

SELECT *
FROM mv_cntr_sales_mm
ORDER BY quantity_sales DESC;

