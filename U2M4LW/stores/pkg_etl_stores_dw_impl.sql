CREATE OR REPLACE PACKAGE BODY pkg_etl_stores_dw
AS  
   PROCEDURE load_t_stores
   AS
       CURSOR cur
         IS
            (SELECT *                   
            FROM o_yukho_admin.sa_stores sa);
       BEGIN
         execute immediate 'truncate table t_stores';
         FOR i IN cur LOOP
          INSERT INTO u_ts_dw_data.t_stores ( store_id
                                                 , store_name
                                                 , insert_dt     
                                                 , update_dt)
                    VALUES (seq_stores.NEXTVAL
                           , i.store_name
                           , SYSDATE
                           , NULL);

         EXIT WHEN cur%NOTFOUND;
       END LOOP;
        COMMIT;
   END load_t_stores ;
END pkg_etl_stores_dw;