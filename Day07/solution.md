# Day 07 – Difference Between Number of Apples and Oranges Sold

**Problem:**  
Given the `Sales` table with daily counts of apples and oranges sold,  
find the **difference** between the number of apples and oranges sold each day:  
`(apples_sold - oranges_sold)`.  
Return results ordered by `sale_date`.

**Thought Process / Approach:**  
1. The table records both fruits in different rows per date.  
2. Use **conditional aggregation** (`CASE WHEN fruit = ...`) to separate apples and oranges.  
3. Subtract total oranges from total apples for each day.  
4. Group by `sale_date` and order chronologically.

**Solution Query:**

```sql
SELECT 
    sale_date,
    SUM(CASE WHEN fruit = 'apples' THEN sold_num ELSE 0 END) -
    SUM(CASE WHEN fruit = 'oranges' THEN sold_num ELSE 0 END) AS diff
FROM Sales
GROUP BY sale_date
ORDER BY sale_date;
```

**Takeaways / Notes:**

CASE WHEN helps pivot rows into columns for comparison.

Using SUM ensures correct totals even if there are multiple entries per fruit per day.

Always use GROUP BY when aggregating data by date.

This is a great example of conditional aggregation, a key SQL concept for reporting.
