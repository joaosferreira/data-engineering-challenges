COPY customers (customer_id, name, country)
FROM '/datasets/ecommerce/data/customers.csv'
WITH (FORMAT CSV, HEADER TRUE);

COPY orders (order_id, customer_id, order_date, status)
FROM '/datasets/ecommerce/data/orders.csv'
WITH (FORMAT CSV, HEADER TRUE);

COPY order_items (order_item_id, order_id, product_id, quantity, unit_price)
FROM '/datasets/ecommerce/data/order_items.csv'
WITH (FORMAT CSV, HEADER TRUE);
