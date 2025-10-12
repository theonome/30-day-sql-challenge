# Day 23- Managers with at Least 5 Direct Reports

### Problem
We need to find all **managers** who have at least **five direct reports**.  
Each employee has a `managerId` referencing the `id` of their manager in the same **Employee** table.  
If `managerId` is `NULL`, that person has **no manager**.

---

### Thought Process
1. Since the `managerId` column refers to another `id` in the same table, we’re dealing with a **self-join** situation.
2. We can group all employees by their `managerId` to count how many direct reports each manager has.
3. Managers with at least **five** reports will be selected.
4. Finally, we join this result back to the **Employee** table to get the manager’s name.

---

### SQL Query
```sql
SELECT e.name
FROM Employee e
JOIN (
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m
ON e.id = m.managerId;
```
---

### Takeaway

This solution uses a self-join:
The subquery identifies managers with five or more direct reports.
The main query retrieves their names from the same table.
