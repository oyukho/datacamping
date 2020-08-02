CREATE OR REPLACE PACKAGE BODY pkg_etl_period_dim
AS  
   PROCEDURE load_dim_period
   AS
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE dim_gen_period';
        DECLARE
            TYPE var_cur IS
                TABLE OF VARCHAR2(50);
            TYPE num_cur IS
                TABLE OF NUMBER;
            TYPE date_cur IS
                TABLE OF DATE;
            TYPE all_cur IS REF CURSOR;
            ls_at               all_cur;
            gen_period_id       num_cur;
            beg_gen_period      num_cur;
            end_gen_period      num_cur;
            insert_dt           date_cur;
            update_dt           date_cur;
        BEGIN
            OPEN ls_at FOR SELECT DISTINCT
                                gen_period_id
                                , beg_gen_period
                                , end_gen_period
                                , insert_dt     
                                , update_dt
                           FROM
                               u_ts_dw_data.t_period;

            FETCH ls_at BULK COLLECT INTO
                                gen_period_id
                                , beg_gen_period
                                , end_gen_period
                                , insert_dt     
                                , update_dt;

            CLOSE ls_at;
            FORALL i IN gen_period_id.first..gen_period_id.last
                INSERT INTO  dim_gen_period (
                                gen_period_id
                                , beg_gen_period
                                , end_gen_period
                                , insert_dt     
                                , update_dt) 
                    VALUES (gen_period_id(i)
                                , beg_gen_period(i)
                                , end_gen_period(i)
                                , insert_dt(i)     
                                , update_dt(i)
                );

        END;
        COMMIT;
   END load_dim_period ;
END pkg_etl_period_dim;