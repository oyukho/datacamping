DROP TABLE T_YEAR ;
create table T_YEAR 
(
   YEAR_ID              NUMBER,
   CALENDAR_YEAR        NUMBER,
   DAYS_IN_CAL_YEAR     NUMBER,
   BEG_CAL_YEAR_DATE    DATE,
   END_CAL_YEAR_DATE    DATE,  
   constraint T_YEAR primary key (YEAR_ID)
);