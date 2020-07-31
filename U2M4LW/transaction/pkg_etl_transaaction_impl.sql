CREATE OR REPLACE PACKAGE BODY pkg_etl_transactions_dw
AS  
   PROCEDURE load_t_transactions
   AS
        BEGIN
            INSERT /*+ PARALLEL */ 
                INTO t_transactions (transaction_id     
                                        , event_id           
                                        , dim_product_id     
                                        , dim_gen_period_id  
                                        , dim_geo_id
                                        , insert_dt          
                                        , update_dt )
                SELECT seq_transactions.NEXTVAL
                        , sa.event_id
                        , p.product_id
                        , prd.gen_period_id
                        , g.country_geo_id
                        , SYSDATE
                        , NULL
                FROM o_yukho_admin.sa_transactions sa
                    INNER JOIN t_products p 
                        ON ( sa.product = p.product_name )     
                    INNER JOIN t_period prd 
                        ON ( TO_CHAR(TO_DATE(sa.event_id,'yy.mm.dd'), 'dd')  BETWEEN prd.beg_gen_period AND prd.end_gen_period )
                    INNER JOIN t_geo_location  g 
                        ON ( sa.geo_sale = g.country_id );
                    
                   
   END load_t_transactions;
END pkg_etl_transactions_dw;