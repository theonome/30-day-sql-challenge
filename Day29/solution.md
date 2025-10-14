# Day 29- Investments in 2016

### Problem  
We need to calculate the **sum of tiv_2016** for all policyholders who meet both conditions:
1. Their `tiv_2015` value appears for **at least one other policyholder**.
2. Their `(lat, lon)` location pair is **unique** (i.e., no other policyholder shares that same city).

Finally, the sum must be **rounded to two decimal places**.

---

### Thought Process  
1. Identify all policyholders who have **duplicate tiv_2015** values.
   - Use `GROUP BY tiv_2015 HAVING COUNT(*) > 1`.
2. Identify all policyholders with **unique (lat, lon)** pairs.
   - Use `GROUP BY lat, lon HAVING COUNT(*) = 1`.
3. Filter the original table to include only policyholders who satisfy **both** conditions.
4. Sum their `tiv_2016` and round the result to 2 decimal places.

---

### Solution Query  
```sql
SELECT 
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1);
```
---

### Takeaway

This problem combines aggregation filtering with multi-column uniqueness checks.
Using subqueries with `GROUP BY` and `HAVING` is powerful for finding:

Duplicates (using `HAVING COUNT(*) > 1`).
Unique combinations (using `HAVING COUNT(*) = 1`).
