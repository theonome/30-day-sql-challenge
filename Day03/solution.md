# Day 03 – Customers Who Bought A and B but Not C

**Problem:**  
From the `Customers` and `Orders` tables, find customers who bought **both product "A" and "B"**, but **did not buy product "C"**.  
Return `customer_id` and `customer_name` ordered by `customer_id`.

**Thought Process / Approach:**  
1. Join `Customers` and `Orders` to know which customer bought which products.  
2. Group by customer to check their purchased products.  
3. Use conditional aggregation:  
   - Bought "A" → `SUM(product_name='A') > 0`  
   - Bought "B" → `SUM(product_name='B') > 0`  
   - Did **not buy "C"** → `SUM(product_name='C') = 0`  
4. Filter only customers meeting all three conditions.

**Solution Query:**

```sql
SELECT c.customer_id, c.customer_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING 
    SUM(o.product_name = 'A') > 0
    AND SUM(o.product_name = 'B') > 0
    AND SUM(o.product_name = 'C') = 0
ORDER BY c.customer_id;
```

**Takeaways / Notes:**

Conditional aggregation (SUM(condition)) counts how many times a condition is true.

HAVING filters groups, not individual rows.

Ensures the customer bought both A and B, but zero C.

Efficient for checking multiple conditions in one pass through the table.
