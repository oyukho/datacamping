--rollup by time 
WITH CTE1 AS
(
    SELECT  COUNTRY_DESC
            , beg_of_year
            , beg_of_cal_quarter
            , beg_of_month
            , event_id        
            , count(*)  as quantity_sales
            , GROUPING(COUNTRY_DESC) gr_country
            , GROUPING(beg_of_year) gr_year
            , GROUPING(beg_of_cal_quarter) gr_quarter
            , GROUPING(beg_of_month) gr_month
            , GROUPING(event_id) gr_day
            
    FROM ( SELECT   (SELECT TRUNC(TO_DATE(event_id, 'yy.mm.dd'), 'YY')  FROM DUAL) beg_of_year
                    , (SELECT TRUNC( TO_DATE(event_id, 'yy.mm.dd'), 'Q' )  FROM DUAL) beg_of_cal_quarter
                    , (SELECT TRUNC(TO_DATE(event_id, 'yy.mm.dd'), 'MM')  FROM DUAL) beg_of_month
                    , TO_DATE(event_id, 'yy.mm.dd')  event_id  
                    , geo_sale                      
                FROM o_yukho_admin.sa_transactions 
            )T1
            LEFT JOIN u_dw_references.LC_COUNTRIES T2 ON T2.GEO_ID = T1.geo_sale
    GROUP BY ROLLUP (COUNTRY_DESC, beg_of_year, beg_of_cal_quarter, beg_of_month, event_id) 
)
SELECT *
FROM CTE1
WHERE '1' = '1'
    AND gr_day = '1'
    --AND gr_month = '1'
    --AND gr_quarter = '1'
    --AND gr_year = '1'
    --AND gr_country = '1'
--put a comment on the line if you want to group by this prameter.

