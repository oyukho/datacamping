--top 5 countries by sales per month
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
                )
    WHERE ROWNUM <= 5
            AND event_id = '01-01-19';
    


--top 5 products in country by sales per month
SELECT *
FROM( SELECT TRUNC(TO_DATE(event_id, 'dd.mm.yy') ,'mm') event_id
            , COUNTRY_DESC
            , product
            , quantity_sales
        FROM o_yukho_admin.sa_transactions T1
                LEFT JOIN u_dw_references.LC_COUNTRIES T2 ON T2.GEO_ID = T1.geo_sale
            GROUP BY TRUNC(TO_DATE(event_id, 'yy.mm.dd') ,'mm')
                     , COUNTRY_DESC
                     , product
            MODEL PARTITION BY (TRUNC(TO_DATE(event_id, 'yy.mm.dd') ,'mm') event_id
                                , COUNTRY_DESC
                                , product)
                DIMENSION BY (0 dummy)
                MEASURES (count(*) quantity_sales)
                RULES ()
                ORDER BY quantity_sales DESC5)
WHERE ROWNUM <= 5
            AND event_id = '01-01-19'
            AND COUNTRY_DESC = 'Belarus';




