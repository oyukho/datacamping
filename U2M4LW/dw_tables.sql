--drop table t_gen_period;
CREATE TABLE t_period (
    gen_period_id   INTEGER NOT NULL,
    beg_gen_period  DATE NOT NULL,
    end_gen_period  DATE NOT NULL,
    insert_dt       DATE NOT NULL,
    update_dt       DATE
);

ALTER TABLE t_period
    ADD CONSTRAINT t_period_pk PRIMARY KEY ( gen_period_id );

CREATE SEQUENCE seq_period
    INCREMENT BY 1
    START WITH 1
    NOCYCLE
    NOCACHE;


--drop table t_payment_types;
CREATE TABLE t_payment_types (
    payment_type_id    INTEGER NOT NULL,
    payment_type_name  VARCHAR2(40) NOT NULL,
    insert_dt          DATE NOT NULL,
    update_dt          DATE
);

ALTER TABLE t_payment_types
    ADD CONSTRAINT t_payment_types_pk PRIMARY KEY ( payment_type_id );
    
CREATE SEQUENCE seq_payment_types
    INCREMENT BY 1
    START WITH 1
    NOCYCLE
    NOCACHE;
    
    
--drop table t_stores;
CREATE TABLE t_stores (
    store_id    INTEGER NOT NULL,
    store_name  VARCHAR2(40) NOT NULL,
    insert_dt   DATE NOT NULL,
    update_dt   DATE
);

ALTER TABLE t_stores
    ADD CONSTRAINT t_stores_pk PRIMARY KEY ( store_id );

CREATE SEQUENCE seq_stores
    INCREMENT BY 1
    START WITH 1
    NOCYCLE
    NOCACHE;
    
    
--drop table t_products;
CREATE TABLE t_products (
    product_id     INTEGER NOT NULL,
    product_name   VARCHAR2(40) NOT NULL,
    product_price  FLOAT NOT NULL,
    insert_dt      DATE,
    update_dt      DATE 
);

ALTER TABLE t_products
    ADD CONSTRAINT t_products_pk PRIMARY KEY ( product_id );

CREATE SEQUENCE seq_products
    INCREMENT BY 1
    START WITH 1
    NOCYCLE
    NOCACHE;
    
    
--drop table t_customers;
CREATE TABLE t_customers (
    cust_id             INTEGER NOT NULL,
    cust_first_name     VARCHAR2(40) NOT NULL,
    cust_last_name      VARCHAR2(40) NOT NULL,
    cust_gender         VARCHAR2(40) NOT NULL,
    cust_year_of_birth  DATE NOT NULL,
    cust_email          VARCHAR2(40) NOT NULL,
    insert_dt           DATE NOT NULL,
    update_dt           DATE
);

ALTER TABLE t_customers
    ADD CONSTRAINT t_customers_pk PRIMARY KEY ( cust_id );

CREATE SEQUENCE seq_customers
    INCREMENT BY 1
    START WITH 1
    NOCYCLE
    NOCACHE;


--drop table t_promotions;
CREATE TABLE t_promotions (
    promo_sur_id       INTEGER NOT NULL,  
    promo_name         VARCHAR2(40) NOT NULL,
    promo_category     VARCHAR2(40) NOT NULL,
    discount_percent   INTEGER NOT NULL,
    valid_from         DATE NOT NULL,
    valid_to           DATE NOT NULL,
    insert_dt          DATE NOT NULL,
    update_dt          DATE
);
  
ALTER TABLE t_promotions
    ADD CONSTRAINT t_promotions_pk PRIMARY KEY ( promo_sur_id);
                                          
CREATE SEQUENCE seq_promotions
    INCREMENT BY 1
    START WITH 1
    NOCYCLE
    NOCACHE;
    
    
--drop table t_transactions;
CREATE TABLE t_transactions (
    transaction_id     INTEGER NOT NULL,
    event_id           DATE NOT NULL,
    dim_product_id     INTEGER NOT NULL,
    dim_gen_period_id  INTEGER NOT NULL,
    dim_geo_id         INTEGER NOT NULL,
    insert_dt          DATE NOT NULL,
    update_dt          DATE
);

ALTER TABLE t_transactions ADD CONSTRAINT t_transactions_pk PRIMARY KEY ( transaction_id );

ALTER TABLE t_transactions
    ADD CONSTRAINT t_transactions_pk PRIMARY KEY ( transaction_id );
    
CREATE SEQUENCE seq_transactions
    INCREMENT BY 1
    START WITH 1
    NOCYCLE
    NOCACHE;
    


