create tablespace ts_sa_customers_data_01 datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_oyukho/ts_sa_customers_data_01.dat'
size 5M autoextend ON next 5M MAXSIZE 100M;

create tablespace ts_sa_employees_data_01 datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_oyukho/ts_sa_employees_data_01.dat'
size 5M autoextend ON next 5M MAXSIZE 100M;

create tablespace ts_sa_products_data_01 datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_oyukho/ts_sa_products_data_01.dat'
size 5M autoextend ON next 5M MAXSIZE 100M;

create tablespace ts_sa_promotions_data_01 datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_oyukho/ts_sa_promotions_data_01.dat'
size 5M autoextend ON next 5M MAXSIZE 100M;

create tablespace ts_dw_cl datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_oyukho/ts_dw_cl.dat'
size 5M autoextend ON next 5M MAXSIZE 100M;

create tablespace ts_dw_data datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_oyukho/ts_dw_data.dat'
size 5M autoextend ON next 5M MAXSIZE 100M;

create tablespace ts_dw_sal_cl datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_oyukho/ts_dw_sal_cl.dat'
size 5M autoextend ON next 5M MAXSIZE 100M;

create tablespace ts_sal_cl datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_oyukho/ts_sal_cl.dat'
size 5M autoextend ON next 5M MAXSIZE 100M;

create tablespace ts_dims datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_oyukho/ts_dims.dat'
size 5M autoextend ON next 5M MAXSIZE 100M;