--  DROP

DROP TABLE ora_customers CASCADE CONSTRAINTS;
DROP TABLE ora_orders CASCADE CONSTRAINTS;
DROP TABLE ora_stocks CASCADE CONSTRAINTS;
DROP TABLE ora_order_items CASCADE CONSTRAINTS;
DROP TABLE ora_brands CASCADE CONSTRAINTS;
DROP TABLE ora_staffs CASCADE CONSTRAINTS;
DROP TABLE ora_stores CASCADE CONSTRAINTS;
DROP TABLE ora_categories CASCADE CONSTRAINTS;
DROP TABLE ora_products CASCADE CONSTRAINTS;


CREATE TABLE ora_customers( 

    customer_id int NOT NULL, 

    first_name varchar(255) NOT NULL, 

    last_name varchar(255) NOT NULL, 

    phone varchar(12), 

    email varchar(255), 

    street varchar(255), 

    city varchar(255), 

    state varchar(255), 

    zip_code varchar(5), 

    CONSTRAINT PK_customer PRIMARY KEY (customer_id) 

); 

  

  

CREATE TABLE ora_stores ( 

    store_id int NOT NULL, 

    store_name varchar(255) NOT NULL, 

    phone varchar(12), 

    email varchar(255), 

    street varchar(255), 

    city varchar(255), 

    state varchar(255), 

    zip_code varchar(5), 

    CONSTRAINT PK_store PRIMARY KEY (store_id) 

); 

  

  

CREATE TABLE ora_staffs ( 

    staff_id int NOT NULL, 

    first_name varchar(255) NOT NULL, 

    last_name varchar(255) NOT NULL, 

    email varchar(255), 

    phone varchar(12), 

    store_id int, 

    manager_id int, 

    CONSTRAINT PK_staff PRIMARY KEY (staff_id), 

    CONSTRAINT FK_store FOREIGN KEY (store_id) REFERENCES ora_stores(store_id) 

    --CONSTRAINT FK_manager FOREIGN KEY (manager_id) REFERENCES ora_staffs(staff_id) 

); 

  

  

CREATE TABLE ora_categories ( 

    category_id int NOT NULL, 

    category_name varchar(255) NOT NULL, 

    CONSTRAINT PK_category PRIMARY KEY (category_id) 

); 

  

CREATE TABLE ora_brands ( 

    brand_id int NOT NULL, 

    brand_name varchar(255) NOT NULL, 

    CONSTRAINT PK_brand PRIMARY KEY (brand_id) 

); 

  

CREATE TABLE ora_products ( 

    product_id int NOT NULL, 

    product_name varchar(255) NOT NULL, 

    brand_id int, 

    category_id int, 

    model_year smallint, 

    list_price DECIMAL(10,2) NOT NULL, 

    CONSTRAINT PK_product PRIMARY KEY (product_id), 

    CONSTRAINT FK_category FOREIGN KEY (category_id) REFERENCES ora_categories(category_id), 

    CONSTRAINT FK_brand FOREIGN KEY (brand_id) REFERENCES ora_brands(brand_id), 

    CONSTRAINT CHK_price CHECK (list_price > 0) 

); 

  

CREATE TABLE ora_orders ( 

    order_id int NOT NULL, 

    customer_id int NOT NULL, 

    order_status int NOT NULL, 

    order_date date NOT NULL, 

    required_date date NOT NULL, 

    shipped_date date, 

    store_id int NOT NULL, 

    staff_id int NOT NULL, 

    CONSTRAINT PK_order PRIMARY KEY (order_id), 

    CONSTRAINT FK_stores FOREIGN KEY (store_id) REFERENCES ora_stores(store_id), 

    CONSTRAINT FK_staff FOREIGN KEY (staff_id) REFERENCES ora_staffs(staff_id), 

    CONSTRAINT FK_customer FOREIGN KEY (customer_id) REFERENCES ora_customers(customer_id), 

CONSTRAINT CHK_status CHECK (order_status IN (1, 2, 3, 4)) 

); 

  

  

  

CREATE TABLE ora_order_items ( 

    order_id int NOT NULL, 

    item_id int NOT NULL, 

    product_id int NOT NULL UNIQUE, 

    quantity int, 

    list_price DECIMAL(10,2) NOT NULL, 

    discount DECIMAL(10,2), 

    CONSTRAINT PK_order_item PRIMARY KEY (order_id, item_id), 

    CONSTRAINT FK_order FOREIGN KEY (order_id) REFERENCES ora_orders(order_id), 

    CONSTRAINT FK_product_item FOREIGN KEY (product_id) REFERENCES ora_products(product_id) 

); 

  

CREATE TABLE ora_stocks ( 

    store_id int NOT NULL, 

    product_id int NOT NULL, 

    quantity int, 

    CONSTRAINT PK_stock PRIMARY KEY (store_id, product_id), 

    CONSTRAINT FK_product FOREIGN KEY (product_id) REFERENCES ora_products(product_id) 

); 

 

--a , b

DROP SEQUENCE seq_customer_pk;
DROP SEQUENCE seq_staff_pk;

CREATE SEQUENCE seq_customer_pk
START WITH 101
INCREMENT BY 1;

CREATE SEQUENCE seq_staff_pk
START WITH 201
INCREMENT BY 1;

SELECT sequence_name, min_value, max_value, increment_by,
last_number
FROM user_sequences;


--c
--stores
insert into ora_stores (store_id,store_name,phone,email,street,city,state,zip_code)
values (111,'Santa Bikes', '831-476-5543', 'santa@Keithsbikes.com', '3700 Portola Drive', 'Santa Cruz','CA','95060');
insert into ora_stores (store_id,store_name,phone,email,street,city,state,zip_code)
values (112,'Cruz Bikes', '516-379-8888', 'Cruz@Keithsbikes.com', '4200 Chestnut Lane', 'Baldwin','NY','11432');
insert into ora_stores (store_id,store_name,phone,email,street,city,state,zip_code)
values (113,'Scarlett Bikes', '972-530-5555', 'Scarlett@Keithsbikes.com', '8000 Fairway Avenue', 'Rowlett','TX','75088');
insert into ora_stores (store_id,store_name,phone,email,street,city,state,zip_code)
values (114,'John Bikes', '972-530-5555', 'John@Keithsbikes.com', 'Yishun Avenue 11', 'Sengkang','SK','76248');



-- brands
INSERT INTO ora_brands (brand_id, brand_name)
VALUES (1, 'Electra');
INSERT INTO ora_brands (brand_id, brand_name)
VALUES (2, 'Haro');
INSERT INTO ora_brands (brand_id, brand_name)
VALUES (3, 'Heller');
INSERT INTO ora_brands (brand_id, brand_name)
VALUES (4, 'Pure Cycle');

-- categories
INSERT INTO ora_categories (category_id, category_name)
VALUES (11, 'Children Bikes');

INSERT INTO ora_categories (category_id, category_name)
VALUES (12, 'Electric Bikes');

INSERT INTO ora_categories (category_id, category_name)
VALUES (13, 'Mountain Bikes');

INSERT INTO ora_categories (category_id, category_name)
VALUES (14, 'Road Bikes');



-- products
INSERT INTO ora_products (product_id, product_name, brand_id, category_id, model_year, list_price)
VALUES (1, 'Trek 820 - 2016', 2, 13, '2016', 379);

INSERT INTO ora_products (product_id, product_name, brand_id, category_id, model_year, list_price)
VALUES (2, 'Ritchey Timberwolf Frameset - 2016', 2, 13, '2016', 749.99);

INSERT INTO ora_products (product_id, product_name, brand_id, category_id, model_year, list_price)
VALUES (3, 'Surly Wednesday Frameset - 2016', 3, 13, '2016', 899);

INSERT INTO ora_products (product_id, product_name, brand_id, category_id, model_year, list_price)
VALUES (6, 'Sun Bicycles Streamway - 2017', 2, 12, '2017', 480);

INSERT INTO ora_products (product_id, product_name, brand_id, category_id, model_year, list_price)
VALUES (7, 'Sun Bicycles Cruz 7 - 2017', 4, 11, '2017', 420);

INSERT INTO ora_products (product_id, product_name, brand_id, category_id, model_year, list_price)
VALUES (8, 'Sun Bicycles Drifter 7 - Women''s - 2017', 4, 11, '2017', 479.99);

INSERT INTO ora_products (product_id, product_name, brand_id, category_id, model_year, list_price)
VALUES (9, 'Trek 820 - 2018', 4, 14, '2018', 380);

INSERT INTO ora_products (product_id, product_name, brand_id, category_id, model_year, list_price)
VALUES (10, 'Trek Marlin 5 - 2018', 4, 14, '2018', 450);


-- staffs
INSERT INTO ora_staffs (staff_id, first_name, last_name, email, phone, store_id, manager_id)
VALUES (seq_staff_pk.NEXTVAL, 'Johonothon', 'Tim', 'jonas@gmail.com', '123-456-4478', 111, NULL);

INSERT INTO ora_staffs (staff_id, first_name, last_name, email, phone, store_id, manager_id)
VALUES (seq_staff_pk.NEXTVAL, 'Tigger', 'Tom', 'tigger@gmail.com', '876-543-2221', 112, NULL);

INSERT INTO ora_staffs (staff_id, first_name, last_name, email, phone, store_id, manager_id)
VALUES (seq_staff_pk.NEXTVAL, 'Jonas', 'Lim', 'Lim@gmail.com', '864-213-6557', 113, NULL);

INSERT INTO ora_staffs (staff_id, first_name, last_name, email, phone, store_id, manager_id)
VALUES (seq_staff_pk.NEXTVAL, 'Jim', 'Jum', 'Jum@gmail.com', '098-765-3443', 112, 202);

--customers
-- Customer 1
INSERT INTO ora_customers (customer_id, first_name, last_name, phone, email, street, city, state, zip_code)
VALUES (seq_customer_pk.NEXTVAL, 'John', 'Doe', '123-456-7890', 'john.doe@example.com', '123 Main St', 'Anytown', 'CA', '90210');

-- Customer 2
INSERT INTO ora_customers (customer_id, first_name, last_name, phone, email, street, city, state, zip_code)
VALUES (seq_customer_pk.NEXTVAL, 'Jane', 'Smith', '987-654-3210', 'jane.smith@example.com', '456 Elm St', 'Springfield', 'IL', '62704');

-- Customer 3
INSERT INTO ora_customers (customer_id, first_name, last_name, phone, email, street, city, state, zip_code)
VALUES (seq_customer_pk.NEXTVAL, 'Michael', 'Johnson', '012-345-6789', 'michael.johnson@example.com', '789 Maple Ave', 'Metropolis', 'NY', '10001');

-- Customer 4
INSERT INTO ora_customers (customer_id, first_name, last_name, phone, email, street, city, state, zip_code)
VALUES (seq_customer_pk.NEXTVAL, 'Sarah', 'Jones', '112-233-4455', 'sarah.jones@example.com', '1011 Oak Blvd', 'Sunnyville', 'FL', '33333');


-- orders
INSERT INTO ora_orders (order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES (1, 101, 1, to_date('2024-02-06', 'YYYY-MM-DD'), to_date('2024-02-13', 'YYYY-MM-DD'), TO_DATE('2024-02-10', 'YYYY-MM-DD'), 111, 201);

INSERT INTO ora_orders (order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES (2, 102, 2, to_date('2024-02-05', 'YYYY-MM-DD'), TO_DATE('2024-02-12', 'YYYY-MM-DD'), TO_DATE('2024-02-18', 'YYYY-MM-DD'), 112, 202);

INSERT INTO ora_orders (order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES (3, 103, 3, TO_DATE('2024-02-03', 'YYYY-MM-DD'), TO_DATE('2024-02-07', 'YYYY-MM-DD'), TO_DATE('2024-02-05', 'YYYY-MM-DD'), 112, 203);

INSERT INTO ora_orders (order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES (4, 104, 4, TO_DATE('2024-02-02', 'YYYY-MM-DD'), TO_DATE('2024-02-06', 'YYYY-MM-DD'), TO_DATE('2024-02-04', 'YYYY-MM-DD'), 113, 202);


--order_items
INSERT INTO ora_order_items (order_id, item_id, product_id, quantity, list_price, discount)
VALUES (1, 1, 1, 1, 379, 0.05); 

INSERT INTO ora_order_items (order_id, item_id, product_id, quantity, list_price, discount)
VALUES (2, 2, 2, 1, 749.99, 0.05); 

INSERT INTO ora_order_items (order_id, item_id, product_id, quantity, list_price, discount)
VALUES (3, 3, 3, 3, 899, 0.15); 

INSERT INTO ora_order_items (order_id, item_id, product_id, quantity, list_price, discount)
VALUES (4, 4, 6, 4, 480, 0);

--stocks
INSERT INTO ora_stocks (store_id, product_id, quantity)
VALUES (111, 1, 56);
INSERT INTO ora_stocks (store_id, product_id, quantity)
VALUES (112, 2, 72);
INSERT INTO ora_stocks (store_id, product_id, quantity)
VALUES (113, 3, 88);
INSERT INTO ora_stocks (store_id, product_id, quantity)
VALUES (114, 6, 76);


select * from ora_order_items;
select * from ora_orders;
select * from ora_products;
select * from ora_customers;
select * from ora_staffs;
select * from ora_brands;
select * from ora_stores;
select* from ora_stocks;
select * from ora_categories;


--d
CREATE INDEX index_customers
ON ora_customers(last_name);

select * from user_indexes
where index_name = 'INDEX_CUSTOMERS';



--e

DROP VIEW view_staffs;


CREATE VIEW view_staffs
AS SELECT ora_staffs.first_name ||' '|| ora_staffs.last_name name, ora_stores.store_name
FROM ora_staffs LEFT OUTER JOIN ora_stores on (ora_staffs.store_id = ora_stores.store_id)
WHERE ora_staffs.staff_id NOT IN (SELECT staff_id FROM ora_orders)
WITH READ ONLY;

select *
from view_staffs;

DROP SYNONYM v_staffs;

--f
CREATE SYNONYM v_staffs
FOR view_staffs;

select * from v_staffs;

