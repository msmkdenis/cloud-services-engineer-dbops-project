ALTER TABLE product ADD price DOUBLE PRECISION;
ALTER TABLE product ADD PRIMARY KEY (id);
ALTER TABLE orders ADD date_created date;
ALTER TABLE orders ADD PRIMARY KEY (id);

DROP TABLE product_info;
DROP TABLE orders_date;

ALTER TABLE order_product ADD CONSTRAINT product_id FOREIGN KEY(product_id) REFERENCES product(id);
ALTER TABLE order_product ADD CONSTRAINT orders_id FOREIGN KEY(order_id) REFERENCES orders(id);