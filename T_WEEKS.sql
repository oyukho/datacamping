DROP TABLE T_WEEKS;
create table T_WEEKS
(
   WEEK_ID              NUMBER,
   CALENDAR_WEEK_NUMBER NUMBER,
   BEG_WEEK_DATE        DATE,
   END_WEEK_DATE        DATE,
   constraint T_WEEKS primary key (WEEK_ID)
);
