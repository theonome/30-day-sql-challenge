# Day 26- Product Sales Analysis III

### Problem
We need to find all sales that occurred in the **first year each product was sold**.  
For each `product_id`, determine the earliest `year` it appears in the `Sales` table, and return all sales entries for that product in that year.

The result should include:
- `product_id`
- `first_year`
- `quantity`
- `price`

---

### Thought Process
1. **Identify the first year for each product:**  
   Use an aggregation query with `MIN(year)` grouped by `product_id` to find the earliest sale year.

   ```sql
   SELECT product_id, MIN(year) AS first_year
   FROM Sales
   GROUP BY product_id
   ```
2. **Join back to the Sales table:**
To get all details (`quantity`, `price`) of sales that happened in that first year,
join this result with the `Sales` table on both `product_id` and the matching year.

3. **Select required columns:**
Include `product_id`, `first_year`, `quantity`, and `price`.

4. **Return in any order:**
No need for explicit sorting since the prompt doesn’t specify it.

### SQL Query
```
SELECT
    s.product_id,
    f.first_year,
    s.quantity,
    s.price
FROM Sales s
JOIN (SELECT
        product_id, MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id) f
ON s.product_id = f.product_id
AND s.year = f.first_year;
```
---

Takeaway

Use aggregation (MIN) to find each product’s first sale year.

Join aggregated results with the main table to retrieve full row details.

This pattern—“find minimum or maximum per group, then join back”—is common in data analysis for isolating first or most recent events.
