# Day 19- The Most Recent Orders for Each Product

## Problem
We are given three tables — `Customers`, `Orders`, and `Products`.  
Our task is to find the **most recent order(s)** for each product.

If multiple orders exist on the same most recent date for a product, we must include all of them.

Finally, the result should be ordered by:
1. `product_name` ascending  
2. `product_id` ascending  
3. `order_id` ascending (in case of ties)

---

## Thought Process
1. First, find the **most recent order date** for each product by grouping the `Orders` table using `product_id` and selecting the `MAX(order_date)`.
2. Join this result (most recent dates per product) with the main `Orders` table to get all the orders that match the latest date for each product.
3. Join again with the `Products` table to get the product names and details.
4. Order the result according to the given sorting rules:
   - `product_name` ASC
   - `product_id` ASC
   - `order_id` ASC

---

## SQL Query
```sql
SELECT p.product_name, o.product_id, o.order_id, o.order_date
FROM Orders o
JOIN (
    SELECT product_id, MAX(order_date) AS latest_order_date
    FROM Orders
    GROUP BY product_id
) recent
    ON o.product_id = recent.product_id
    AND o.order_date = recent.latest_order_date
JOIN Products p
    ON o.product_id = p.product_id
ORDER BY 
    p.product_name ASC,
    o.product_id ASC,
    o.order_id ASC;
```
---
## Takeaways / Notes

The subquery isolates the most recent date per product efficiently using MAX(order_date).

Joining ensures that all orders matching that date are included.

Products with no orders are automatically excluded because they won’t appear in the Orders table.

Proper ordering ensures clear, consistent results that meet all tie-breaking requirements.
