### Day 01 – Employee Bonus Calculation

**Problem:**  
Given a table `employees` with columns `employee_id`, `name`, and `salary`, calculate the bonus for each employee based on the following rules:  

- If the employee's ID is **odd** and the employee's name does **not** start with the letter 'M', the bonus is **100% of their salary**.  
- Otherwise, the bonus is **0**.  

Return the result table **ordered by `employee_id`**.

**Solution:**  

```sql
SELECT 
    employee_id,
    CASE 
        WHEN MOD(employee_id, 2) = 1 AND name NOT LIKE 'M%' THEN salary
        ELSE 0
    END AS bonus
FROM employees
ORDER BY employee_id;
```

Approach:

Check for odd IDs:

Used MOD(employee_id, 2) = 1 to determine if the employee ID is odd.

Check name condition:

Used name NOT LIKE 'M%' to exclude names starting with 'M'.

Calculate bonus using CASE:

CASE WHEN ... THEN salary ELSE 0 END computes the bonus based on the conditions.

Order results:

Used ORDER BY employee_id to return results sorted by employee ID.

Notes:

Only two columns are returned: employee_id and the calculated bonus.

This solution is concise, readable, and works in standard SQL.
