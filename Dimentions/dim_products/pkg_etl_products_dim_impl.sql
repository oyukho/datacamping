CREATE OR REPLACE PACKAGE BODY pkg_etl_products_dim
AS  
   PROCEDURE load_dim_products
   AS
        BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE dim_products';
        DECLARE
            TYPE var_cur IS
                TABLE OF VARCHAR2(50);
            TYPE num_cur IS
                TABLE OF NUMBER;
            TYPE date_cur IS
                TABLE OF DATE;
            TYPE all_cur IS REF CURSOR;
            ls_at              all_cur;
            product_id         num_cur;
            product_name       var_cur;
            product_price      num_cur;               
            insert_dt          date_cur;
            update_dt          date_cur;
        BEGIN
            OPEN ls_at FOR SELECT DISTINCT
                                product_id         
                                , product_name       
                                , product_price                  
                                , insert_dt          
                                , update_dt 
                           FROM
                               u_ts_dw_data.t_products;

            FETCH ls_at BULK COLLECT INTO
                                product_id         
                                , product_name       
                                , product_price                  
                                , insert_dt          
                                , update_dt;

            CLOSE ls_at;
            FORALL i IN product_id .first..product_id .last
                INSERT INTO  dim_products (
                                product_id         
                                , product_name       
                                , product_price                  
                                , insert_dt          
                                , update_dt) 
                VALUES (
                                product_id(i)         
                                , product_name(i)       
                                , product_price(i)                 
                                , insert_dt(i)          
                                , update_dt(i)
                );

        END;
        COMMIT;
   END load_dim_products ;
END pkg_etl_products_dim;