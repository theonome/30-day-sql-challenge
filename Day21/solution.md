# Day 21- Maximum Transaction Each Day

## Problem
We are given a `Transactions` table containing transaction details, including their unique ID, timestamp, and amount.  
We must find **the transaction(s) with the maximum amount per day** — if multiple transactions share the maximum amount on the same day, include them all.  

The final output should be ordered by `transaction_id` in ascending order.  
We will also consider how to solve this **without using the MAX() function**.

---

## Thought Process
1. Each day may have multiple transactions, so we first need to identify the **maximum amount per day**.  
2. The typical approach is to use `MAX(amount)` with a `GROUP BY` on the date portion of the `day` column.  
3. However, the follow-up asks for a version **without using MAX()** — which we can handle with a **window function**:
   - Use `RANK()` or `DENSE_RANK()` over partitions of each day, ordered by `amount DESC`.
   - Select only the rows where the rank is 1 (the highest for that day).  
4. Extract only the **date part** of the `day` field since we only compare transactions by date, not exact timestamp.  
5. Finally, order by `transaction_id ASC` as required.

---

## SQL Query (Without Using MAX)
```sql
SELECT 
    transaction_id
FROM (
    SELECT transaction_id, CAST(day AS DATE) AS transaction_day, amount,
        RANK() OVER (
            PARTITION BY CAST(day AS DATE)
            ORDER BY amount DESC
        ) AS rnk
    FROM Transactions
) ranked
WHERE rnk = 1
ORDER BY transaction_id;
```
---
## Takeaways

RANK() assigns the same rank to equal amounts, so all top transactions for the day are included.

CAST(day AS DATE) ensures transactions on the same calendar day are grouped correctly.

This approach avoids the use of MAX() while achieving the same result.

Using window functions provides flexibility and efficiency, especially when you need to handle ties or additional ranking logic.
