# Day 22- Department Highest Salary

### Problem
We need to find the employees who earn the **highest salary** in each department.  
There are two tables — **Employee** (contains salaries and department IDs) and **Department** (contains department names).  
We must join both tables and identify the top earners within each department.

---

### Thought Process
1. The task involves comparing salaries **within each department** — this indicates we’ll use **GROUP BY** on `departmentId`.
2. We can first compute the **maximum salary per department** using an aggregate query.
3. Then, join this result back with the **Employee** table to fetch employee names that match this maximum salary.
4. Finally, join with the **Department** table to show department names instead of IDs.

---

### SQL Query
```sql
SELECT d.name AS Department, e.name AS Employee, e.salary AS Salary
FROM Employee e
JOIN Department d 
    ON e.departmentId = d.id
WHERE (e.departmentId, e.salary) IN (
    SELECT departmentId, MAX(salary)
    FROM Employee
    GROUP BY departmentId
);
```
---

### Takeaway

This solution uses a subquery to find the highest salary in each department,
then filters the main Employee table to include only those matching records.
It effectively handles cases where multiple employees share the same top salary in a department.
