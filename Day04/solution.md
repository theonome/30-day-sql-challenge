# Day 04 – Sellers with No Sales in 2020

**Problem:**  
Given the `Seller` and `Orders` tables, find all sellers who did **not make any sales in 2020**.  
Return the `seller_name` ordered in ascending order.

**Thought Process / Approach:**  
1. We need to check which sellers **have no orders in 2020**.  
2. Use a **LEFT JOIN** from `Seller` to `Orders` filtered for 2020.  
3. Sellers with no matching rows in 2020 will have `NULL` in the join.  
4. Filter with `WHERE o.order_id IS NULL` to get sellers with zero sales in 2020.  

**Solution Query:**

```sql
SELECT s.seller_name
FROM Seller s
LEFT JOIN Orders o 
       ON s.seller_id = o.seller_id 
       AND YEAR(o.sale_date) = 2020
WHERE o.order_id IS NULL
ORDER BY s.seller_name;
```

**Takeaways / Notes:**

LEFT JOIN + WHERE ... IS NULL is a common pattern to find rows with no related entries.

YEAR(date_column) extracts the year from a date in MySQL.

Efficient for detecting "no sales" scenarios without subqueries.

The result only includes seller_name as required.
