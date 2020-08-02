CREATE OR REPLACE PACKAGE BODY pkg_etl_fct_sales_mm
AS  
   PROCEDURE load_fct_sales_mm
   AS
        BEGIN
         EXECUTE IMMEDIATE 'TRUNCATE TABLE fct_sales_mm';
            INSERT /*+ PARALLEL */ 
                INTO fct_sales_mm (fct_id             
                                    , event_id           
                                    , dim_product_id     
                                    , dim_gen_period_id  
                                    , dim_geo_id        
                                    , quantity_sales    
                                    , insert_dt         
                                    , update_dt)
                SELECT seq_fct_sales_mm.NEXTVAL
                        , t.* 
                        , SYSDATE
                        , NULL
FROM( SELECT TRUNC(TO_DATE(event_id, 'yy.mm.dd') ,'mm') event_id
                    , dim_product_id
                    , dim_gen_period_id
                    , dim_geo_id
                    , count(*)
            FROM u_ts_dw_data.t_transactions
            GROUP BY TRUNC(TO_DATE(event_id, 'yy.mm.dd') ,'mm')
                            , dim_product_id
                            , dim_gen_period_id
                            , dim_geo_id) t ;
        COMMIT;
   END load_fct_sales_mm;
END pkg_etl_fct_sales_mm;