CREATE OR REPLACE PACKAGE BODY pkg_etl_period_dw
AS  
   PROCEDURE load_t_period
   AS
       CURSOR cur
         IS
            (SELECT sa_period.beg_gen_period
                    ,sa_period.end_gen_period
            FROM o_yukho_admin.SA_GEN_PERIOD sa_period);
       BEGIN
         execute immediate 'truncate table t_period';
         FOR i IN cur LOOP
          INSERT INTO u_ts_dw_data.t_period ( gen_period_id
                                                 , beg_gen_period
                                                 , end_gen_period
                                                 , insert_dt     
                                                 , update_dt)
                    VALUES (seq_period.NEXTVAL
                           , i.BEG_GEN_PERIOD
                           , i.END_GEN_PERIOD
                           , SYSDATE
                           , NULL);

         EXIT WHEN cur%NOTFOUND;
       END LOOP;
        COMMIT;
   END load_t_period ;
END pkg_etl_period_dw;