# E-commerce dataset

The e-commerce dataset is loaded into the `ecommerce` PostgreSQL schema by the
shared PostgreSQL environment. Its source records are the CSV files in `data/`.

## Tables

- `customers`: one row per customer, keyed by `customer_id`; includes the
  customer's name and country.
- `orders`: one row per order, keyed by `order_id`; `customer_id` references
  `customers`, `order_date` is a date, and `status` is either `completed` or
  `cancelled`.
- `order_items`: one row per order line, keyed by `order_item_id`; `order_id`
  references `orders`. Each row includes a product ID, positive quantity, and
  non-negative unit price (`NUMERIC(10, 2)`).

An order's line-item value can be calculated as `quantity * unit_price`.
Customers without orders remain present in `customers`; in the sample data,
customer 4 (Diana) has no orders. The data also includes a cancelled order, so
exercise queries can distinguish it from completed orders.

To reload the records, reset the PostgreSQL environment as described in the
root README. The environment runs this dataset's `init.sql` on first database
initialization.
