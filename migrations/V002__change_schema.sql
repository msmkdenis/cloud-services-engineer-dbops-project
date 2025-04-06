-- Переносим поле price в таблицу product: цена (price) — атрибут продукта
ALTER TABLE product ADD price DOUBLE PRECISION;
-- Добавляем первичный ключ: обеспечивает уникальность и позволяет создавать внешние ключи
ALTER TABLE product ADD PRIMARY KEY (id);
-- Удаляем таблицу product_info: её данные перенесены в таблицу product
DROP TABLE product_info;

-- Переносим поле date_created в таблицу orders: дата создания заказа — атрибут заказа
ALTER TABLE orders ADD date_created date;
-- Добавляем первичный ключ: обеспечивает уникальность и позволяет создавать внешние ключи
ALTER TABLE orders ADD PRIMARY KEY (id);
-- Удаляем таблицу orders_date: её данные перенесены в таблицу orders
DROP TABLE orders_date;

-- Добавляем внешние ключи:
-- обеспечивают ссылочную целостность: нельзя добавить запись с несуществующим product или order
ALTER TABLE order_product ADD CONSTRAINT product_id FOREIGN KEY(product_id) REFERENCES product(id);
ALTER TABLE order_product ADD CONSTRAINT orders_id FOREIGN KEY(order_id) REFERENCES orders(id);
