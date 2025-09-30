# Day 06 – Percentage of Immediate Orders

**Problem:**  
Given the `Delivery` table, calculate the **percentage of immediate orders**.  
- An order is **immediate** if `customer_pref_delivery_date = order_date`.  
- Round the percentage to 2 decimal places.  

**Thought Process / Approach:**  
1. Count the total number of orders.  
2. Count the number of **immediate orders** where `customer_pref_delivery_date = order_date`.  
3. Calculate `(immediate_count / total_count) * 100`.  
4. Use `ROUND(..., 2)` to round to two decimal places.  

**Solution Query:**

```sql
SELECT 
    ROUND(
        100.0 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS immediate_percentage
FROM Delivery;
```

**Takeaways / Notes:**

CASE WHEN ... THEN 1 ELSE 0 END is used to count conditional occurrences.

SUM(...) / COUNT(*) calculates the ratio of immediate orders.

Multiplying by 100 converts it to a percentage.

ROUND(..., 2) ensures the result is rounded to two decimal places.
