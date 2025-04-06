-- Индекс для ускорения поиска всех товаров по заказу
CREATE INDEX order_product_order_id_idx ON order_product(order_id);

-- Составной индекс для ускорения выборок заказов по статусу и дате создания
CREATE INDEX orders_status_date_idx ON orders(status, date_created);