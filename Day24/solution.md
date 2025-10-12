# Day24- Confirmation Rate

### Problem
We need to calculate the **confirmation rate** for each user.  
- A user’s **confirmation rate** = (number of `'confirmed'` actions) / (total confirmation requests).  
- If a user made **no confirmation requests**, their rate = 0.  
We must return all users from the **Signups** table.

---

### Thought Process
1. Start with the **Signups** table to ensure every user appears in the final result — even if they have no confirmations.  
2. Join it with the **Confirmations** table using a **LEFT JOIN** (since not all users have confirmation activity).  
3. Use **conditional aggregation** to count how many times each user’s confirmation was `'confirmed'`.  
4. Divide that count by the total number of confirmation records per user.  
5. Handle users with no confirmation requests by using `IFNULL` (or `COALESCE`) to set their rate to 0.  
6. Round the final value to **two decimal places**.

---

### SQL Query
```sql
SELECT s.user_id,
    ROUND(IFNULL(SUM(c.action = 'confirmed') / COUNT(c.action), 0),2) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id;
```
---

### Takeaway

LEFT JOIN ensures users without confirmations still appear.
Using SUM(c.action = 'confirmed') efficiently counts 'confirmed' actions.
The division with COUNT() gives the confirmation ratio.
ROUND(..., 2) ensures the output matches the required precision.
