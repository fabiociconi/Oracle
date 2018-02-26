DROP TABLE products;

DROP TABLE stock;

DROP TABLE order_details;

DROP TABLE orders;

DROP TABLE customers;

CREATE TABLE stock (
	stock_id NUMBER(3) NOT NULL PRIMARY KEY,
	product_name varchar(20),
	product_qty NUMBER(4)

);
  

CREATE TABLE products (
	product_id NUMBER(3) NOT NULL,
	product_name varchar(20) NOT NULL,
	product_price NUMBER(6,2) NOT NULL,
  stock_id NUMBER (3),
  PRIMARY KEY (product_id),
  FOREIGN KEY (stock_id) REFERENCES stock (stock_id)
	);
	
CREATE TABLE customers (
	customer_id NUMBER(3) NOT NULL PRIMARY KEY,
	customer_last_name varchar(20) NOT NULL,
	customer_first_name varchar(20) NOT NULL,
	address varchar(50),
	date_in_system DATE,
	order_date date NOT NULL
	);
	
CREATE TABLE orders (
	order_id NUMBER(3)  NOT NULL PRIMARY KEY,
	customer_id NUMBER(3),
	order_qty NUMBER (4) NOT NULL,
	order_date date,
  FOREIGN KEY (customer_id) REFERENCES customers (customer_id) 
 
	);

CREATE TABLE order_details (
  specification NUMBER (3) NOT NULL PRIMARY KEY,
	order_id NUMBER(3),
	product_id NUMBER(3),
	product_qty NUMBER(4),
	product_price NUMBER(6,2),
	total_cost NUMBER(8,2),
  FOREIGN KEY (order_id) REFERENCES orders (order_id)
	);



INSERT INTO stock (stock_id, product_name, product_qty)
VALUES (1, 'Computer', 3);
INSERT INTO stock (stock_id, product_name, product_qty)
VALUES (2, 'Book', 10);
INSERT INTO stock (stock_id, product_name, product_qty)
VALUES (3, 'Phone', 5);
COMMIT;

INSERT INTO products (product_id, product_name, product_price, stock_id)
VALUES (1, 'Computer', 550, 1);
INSERT INTO products (product_id, product_name, product_price, stock_id)
VALUES (2, 'Book', 50, 2);
INSERT INTO products (product_id, product_name, product_price, stock_id)
VALUES (3, 'Phone', 110, 3);
COMMIT;

INSERT INTO customers (customer_id, customer_last_name, customer_first_name, address, date_in_system, order_date) 
VALUES (1, 'Doe', 'John', NULL, CURRENT_DATE, CURRENT_DATE);
INSERT INTO customers (customer_id, customer_last_name, customer_first_name, address, date_in_system, order_date) 
VALUES (4, 'Doe', 'Johan', NULL, CURRENT_DATE, CURRENT_DATE);
INSERT INTO customers (customer_id, customer_last_name, customer_first_name, address, date_in_system, order_date) 
VALUES (2, 'Joan', 'Smith', '500 Warden Avenue', CURRENT_DATE, CURRENT_DATE);

INSERT INTO orders (order_id, customer_id, order_qty, order_date)
VALUES (200, 1, 3, CURRENT_DATE);
INSERT INTO orders (order_id, customer_id, order_qty, order_date)
VALUES (201, 1, 3, CURRENT_DATE);
INSERT INTO orders (order_id, customer_id,  order_qty, order_date)
VALUES (202, 2, 3, CURRENT_DATE);
INSERT INTO orders (order_id, customer_id,  order_qty, order_date)
VALUES (203, 1, 3, CURRENT_DATE);

INSERT INTO order_details (specification, order_id, product_id, product_qty, product_price, total_cost)
VALUES (1, 200, 2, 2, 50, 100);
INSERT INTO order_details (specification, order_id, product_id, product_qty, product_price, total_cost)
VALUES (2, 200, 2, 2, 50, 100);

COMMIT;

SELECT * from products;
SELECT * from orders;
SELECT * from customers;
SELECT * from stock;
