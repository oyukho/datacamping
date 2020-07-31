CREATE OR REPLACE PACKAGE BODY pkg_etl_products_dw
AS  
   PROCEDURE load_t_products
   AS
        BEGIN
        DECLARE BEGIN
            MERGE INTO u_ts_dw_data.t_products t
            USING o_yukho_admin.sa_products sa ON ( t.product_name = sa.product_name)
            WHEN MATCHED THEN UPDATE
            SET t.product_price = sa.product_price
                , t.update_dt = SYSDATE
            WHEN NOT MATCHED THEN
            INSERT (   product_id
                        , t.product_name    
                        , t.product_price                     
                        , t.insert_dt          
                        , t.update_dt )
            VALUES
                (  seq_products.NEXTVAL
                    , sa.product_name    
                    , sa.product_price
                    , SYSDATE
                    , NULL);

        END;
        COMMIT;
   END load_t_products ;
END pkg_etl_products_dw;