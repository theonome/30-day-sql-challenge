# Day 20- The Most Recent Three Orders

## Problem
We are given two tables — `Customers` and `Orders`.  
We need to find the **most recent three orders** of each customer.  
If a customer has fewer than three orders, we return all of them.  

The result must be ordered by:
1. `customer_name` ascending  
2. `customer_id` ascending  
3. `order_date` descending  

---

## Thought Process
1. Each customer can have multiple orders, and we want only their **three most recent** ones.  
2. We can use the `ROW_NUMBER()` window function to assign a rank to each order per customer, ordered by `order_date DESC`.
3. Then, we filter only those rows where the rank ≤ 3.
4. Join the `Orders` table with the `Customers` table to get the customer names.
5. Finally, sort the result as per the specified rules.

---

## SQL Query
```sql
WITH RankedOrders AS (
    SELECT o.customer_id, o.order_id, o.order_date,
        ROW_NUMBER() OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date DESC
        ) AS rn
    FROM Orders o
)
SELECT 
    c.name AS customer_name, c.customer_id, r.order_id, r.order_date
FROM RankedOrders r
JOIN Customers c
    ON r.customer_id = c.customer_id
WHERE r.rn <= 3
ORDER BY 
    c.name ASC,
    c.customer_id ASC,
    r.order_date DESC;
```
---
## Takeaways 

The ROW_NUMBER() window function efficiently selects the top N (here, 3) recent rows per group.

We use PARTITION BY to restart ranking per customer.

Filtering WHERE rn <= 3 ensures only the three latest orders are included.

Sorting by customer_name, then customer_id, and then order_date DESC ensures clean and consistent output.

This approach scales well and works even when customers have varying order counts.
