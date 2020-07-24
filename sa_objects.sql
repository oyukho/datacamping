CREATE TABLE sa_gen_period (
    beg_gen_period  INTEGER NOT NULL,
    end_gen_period  INTEGER NOT NULL
);
--drop table sa_gen_period;

CREATE TABLE sa_payment_types (
    payment_type_name  VARCHAR2(40) NOT NULL
);
--drop table sa_payment_types;

CREATE TABLE sa_stores (
    store_name  VARCHAR2(40) NOT NULL
);
--drop table sa_stores;

CREATE TABLE sa_products (
    product_name         VARCHAR2(40) NOT NULL,
    product_price        FLOAT NOT NULL  
);
--drop table sa_products;

CREATE TABLE sa_customers (
    cust_id             INTEGER NOT NULL,
    cust_first_name     VARCHAR2(40) NOT NULL,
    cust_last_name      VARCHAR2(40) NOT NULL,
    cust_gender         VARCHAR2(40) NOT NULL,
    cust_year_of_birth  DATE NOT NULL,
    cust_email          VARCHAR2(40) NOT NULL
);
--drop table sa_customers;

CREATE TABLE sa_promotions (
    promo_id           INTEGER NOT NULL,
    promo_name         VARCHAR2(40) NOT NULL,
    promo_category     VARCHAR2(40) NOT NULL,
    discount_percent   INTEGER NOT NULL,
    valid_from         DATE NOT NULL,
    valid_to           DATE NOT NULL
);
--drop table sa_promotions;

CREATE TABLE sa_data ( 
    data_sale  DATE 
);

CREATE TABLE sa_transactions (
    event_id             DATE NOT NULL,
    store_name           VARCHAR2(40) NOT NULL,
    cust_id              INTEGER NOT NULL,
    product              VARCHAR2(40) NOT NULL,
    payment_type         VARCHAR2(40) NOT NULL,
    geo_sale             VARCHAR2(40) NOT NULL,
    promo_id             INTEGER NOT NULL
);
--drop table sa_transactions;