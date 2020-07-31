CREATE OR REPLACE PACKAGE BODY pkg_etl_castomers_dw
AS  
   PROCEDURE load_t_castomers
   AS
        BEGIN
        DECLARE BEGIN
            MERGE INTO u_ts_dw_data.t_customers t
            USING o_yukho_admin.sa_customers sa ON ( t.cust_id = sa.cust_id)
            WHEN MATCHED THEN UPDATE
            SET t.cust_gender = sa.cust_gender
                    , t.cust_email = sa.cust_email
                    , t.update_dt = SYSDATE
            WHEN NOT MATCHED THEN
            INSERT (   cust_id
                        , t.cust_first_name    
                        , t.cust_last_name     
                        , t.cust_gender        
                        , t.cust_year_of_birth 
                        , t.cust_email         
                        , t.insert_dt          
                        , t.update_dt )
            VALUES
                (  sa.cust_id
                    , sa.cust_first_name    
                    , sa.cust_last_name     
                    , sa.cust_gender        
                    , TO_DATE(sa.cust_year_of_birth,'dd.mm.yy')
                    , sa.cust_email         
                    , SYSDATE
                    , NULL);

        END;
        COMMIT;
   END load_t_castomers ;
END pkg_etl_castomers_dw;