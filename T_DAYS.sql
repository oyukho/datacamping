DROP TABLE T_DAYS;
create table T_DAYS
(  DAY_ID                   NUMBER,
   DATA_ID                  DATA,   
   DAY_NUMBER_IN_WEEK       NUMBER,
   DAY_NUMBER_IN_MONTH      NUMBER,
   DAY_NUMBER_IN_YEAR       NUMBER,
   DAY_NUMBER_IN_QUARTER    NUMBER,
   constraint T_DAYS primary key (DAY_ID)
);

