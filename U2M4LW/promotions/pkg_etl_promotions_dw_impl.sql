CREATE OR REPLACE PACKAGE BODY pkg_etl_promotions_dw
AS  
   PROCEDURE load_t_promotions
   AS
       CURSOR cur
         IS
            (SELECT *
            FROM o_yukho_admin.sa_promotions sa);
       BEGIN
         execute immediate 'truncate table t_promotions';
         FOR i IN cur LOOP
          INSERT INTO u_ts_dw_data.t_promotions ( promo_sur_id        
                                                   , promo_name
                                                   , promo_category     
                                                   , discount_percent   
                                                   , valid_from      
                                                   , valid_to           
                                                   , insert_dt          
                                                   , update_dt)
                    VALUES (i.promo_id        
                               , i.promo_name 
                               , i.promo_category     
                               , i.discount_percent   
                               , i.valid_from      
                               , i.valid_to           
                               , SYSDATE
                               , NULL);

         EXIT WHEN cur%NOTFOUND;
       END LOOP;
        COMMIT;
   END load_t_promotions;
END pkg_etl_promotions_dw;