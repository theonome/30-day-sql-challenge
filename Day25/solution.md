# Day 25- Monthly Transactions I

### Problem
We need to find, for each **month** and **country**, the following transaction summaries:
1. Total number of transactions (`trans_count`)
2. Total transaction amount (`trans_total_amount`)
3. Number of approved transactions (`approved_count`)
4. Total amount of approved transactions (`approved_total_amount`)

The `Transactions` table includes transaction ID, country, state (`approved` or `declined`), amount, and transaction date.  
We’ll group transactions by **month** (in `YYYY-MM` format) and **country**.

---

### Thought Process
1. **Extract Month:**  
   Convert `trans_date` to a monthly format using `DATE_FORMAT(trans_date, '%Y-%m')`.  
   This groups all transactions within the same month together.

2. **Group by Month and Country:**  
   We want totals per month per country, so we’ll use:
   ```sql
   GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country
   ```
3. **Count All Transactions:**
Use `COUNT(*)` for total transactions in each group.

4. **Count Approved Transactions:**
Use conditional aggregation with:
```sql
SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END)
```

5. **Sum All Amounts:**
Use:

```sql
SUM(amount)
```
for total transaction amount.

6. **Sum Approved Amounts:**
Use another conditional sum:

```sql
SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)
```

7. **Return Fields in Required Format:**
Include month, country, and all computed values.

---

### SQL Query
```sql
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country;
```
---


### Takeaway

DATE_FORMAT() simplifies grouping by month.

Conditional aggregation (CASE WHEN) is powerful for counting or summing selectively.

Always group by non-aggregated fields (month, country).

This query provides a clear monthly breakdown of transaction performance per country.
