DROP TABLE T_MONTH ;
create table T_MONTH 
(
   MONTH_ID                 NUMBER, 
   CALENDAR_MONTH_NUMBER    NUMBER,
   DAYS_IN_CAL_MONTH        NUMBER,
   BEG_CAL_MONTH_DATE           DATE,
   END_CAL_MONTH_DATE           DATE,
   constraint T_MONTH primary key (MONTH_ID)
);
