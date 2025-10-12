# Day 17- Find the Team Size

## Problem
We’re given a table `Employee`:

| Column Name  | Type |
|---------------|------|
| employee_id   | int  |
| team_id       | int  |

`employee_id` is the primary key. Each row contains an employee and the team they belong to.  
We need to return each employee’s ID alongside the size of their team.

### Example

**Input**

| employee_id | team_id |
|--------------|----------|
| 1            | 8        |
| 2            | 8        |
| 3            | 8        |
| 4            | 7        |
| 5            | 9        |
| 6            | 9        |

**Output**

| employee_id | team_size |
|--------------|------------|
| 1            | 3          |
| 2            | 3          |
| 3            | 3          |
| 4            | 1          |
| 5            | 2          |
| 6            | 2          |

---

## Thought Process
1. Each team’s size is determined by how many employees share the same `team_id`.
2. We can count the number of employees in each team using `GROUP BY team_id`.
3. After obtaining this summary, we need to attach each team’s size back to the employees belonging to that team.
4. This can be done by joining the grouped result with the original `Employee` table using `team_id`.

---

## SQL Query
```sql
SELECT 
    e.employee_id, t.team_size
FROM Employee e
JOIN (
    SELECT 
        team_id, COUNT(*) AS team_size
    FROM Employee
    GROUP BY team_id
) t
ON e.team_id = t.team_id;
```
---
## Takeaways / Notes

Use GROUP BY to calculate aggregate values like counts per team.

Aliasing tables (e and t) makes queries more readable and avoids ambiguity.

This approach is a common pattern when combining aggregate and detailed data in analytics or reporting.
