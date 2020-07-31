CREATE OR REPLACE PACKAGE BODY pkg_etl_payment_types_dw
AS  
   PROCEDURE load_t_payment_types
   AS       
       CURSOR cur
         IS
            (SELECT *                   
            FROM o_yukho_admin.sa_payment_types sa);
       BEGIN
         execute immediate 'truncate table t_payment_types';
         FOR i IN cur LOOP
          INSERT INTO u_ts_dw_data.t_payment_types ( payment_type_id
                                                             , payment_type_name
                                                             , insert_dt     
                                                             , update_dt)
                    VALUES (seq_payment_types.NEXTVAL
                           , i.payment_type_name
                           , SYSDATE
                           , NULL);

         EXIT WHEN cur%NOTFOUND;
       END LOOP;
        COMMIT;
   END load_t_payment_types;
END pkg_etl_payment_types_dw;