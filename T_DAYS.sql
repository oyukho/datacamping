DROP TABLE T_DAYS;
CREATE TABLE T_DAYS AS
SELECT 
  CAST((TO_CHAR(sd+rn , 'YYYY')||TO_CHAR(sd+rn , 'MM')||TO_CHAR(sd+rn , 'DD') ) AS INTEGER) date_id,
  TRUNC( sd + rn ) time_id,
  TO_CHAR( sd + rn, 'fmDay' ) day_name,
  TO_CHAR( sd + rn, 'D' ) day_number_in_week,
  TO_CHAR( sd + rn, 'DD' ) day_number_in_month,
  TO_CHAR( sd + rn, 'DDD' ) day_number_in_year
  
FROM
  ( 
    SELECT 
      TO_DATE( '12/31/2018', 'MM/DD/YYYY' ) sd,
      rownum rn
    FROM dual
      CONNECT BY level <= 200
  )
  
 ALTER TABLE T_DAYS
 ADD  CONSTRAINT pk_date_id PRIMARY KEY (date_id);

