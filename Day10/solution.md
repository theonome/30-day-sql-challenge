# Day 10 – Countries with Above-Average Call Durations

**Problem:**  
Given the tables `Person`, `Country`, and `Calls`,  
find the countries where the **average call duration** (for all calls involving their citizens)  
is **strictly greater than the global average call duration**.

Each call connects a caller and a callee (both from possibly different countries).  
A country’s average duration includes all calls **made or received** by its citizens.

**Thought Process / Approach:**  
1. Each `Person` has a `phone_number` with a **country code prefix** (`xxx-yyyyyyy`).  
2. We can **extract the country code** using `LEFT(phone_number, 3)`.  
3. Join `Person` → `Country` on that country code to identify each person’s country.  
4. For each call:
   - Join `Calls` to `Person` twice — once for the caller, once for the callee —  
     so we can associate each call with both countries involved.
5. Average duration per country = average of all calls made **from or to** people in that country.  
6. Compare each country’s average duration with the **global average duration** using a subquery.

**Solution Query:**

```sql
SELECT 
    co.name AS country
FROM Person p
JOIN Country co 
    ON LEFT(p.phone_number, 3) = co.country_code
JOIN Calls c 
    ON p.id = c.caller_id OR p.id = c.callee_id
GROUP BY co.name
HAVING AVG(c.duration) > (
    SELECT AVG(duration) FROM Calls
);
```

**Takeaways / Notes:**

LEFT(phone_number, 3) extracts the 3-digit country code prefix.

Joining twice (caller and callee) ensures both sides of calls are counted.

AVG(duration) computes the average per group; the HAVING clause filters above-average countries.

The subquery (SELECT AVG(duration) FROM Calls) gives the global average for comparison.

This problem highlights real-world data aggregation and conditional filtering across relationships,
useful in analytics and reporting for telecom or service performance.
