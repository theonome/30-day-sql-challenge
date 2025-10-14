# Day 30- Department Top Three Salaries

### Problem  
We need to find employees who are **high earners** in each department — specifically, those earning within the **top three unique salaries** per department.

We’ll return:
- Department name  
- Employee name  
- Salary  

and can return results in any order.

---

### Thought Process  
1. **Rank salaries by department:**  
   Use a window function (`DENSE_RANK()`) to rank salaries within each department in descending order.  
   `DENSE_RANK()` ensures that duplicate salary values share the same rank, which is important since multiple employees can earn the same amount.

2. **Filter top three salaries:**  
   Keep only rows where the rank ≤ 3.

3. **Join Department and Employee tables:**  
   Use the `departmentId` foreign key to map department names.

4. **Select final columns** — `Department`, `Employee`, and `Salary`.

---

### Solution Query  
```sql
SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM (
    SELECT id, name, salary, departmentId,
           DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rnk
    FROM Employee) e
JOIN Department d ON e.departmentId = d.id
WHERE e.rnk <= 3;
```
---
### Takeaway

Use DENSE_RANK() when ranking distinct salary levels instead of employees.

Always PARTITION BY department when computing per-department metrics.

Combining ranking and filtering (WHERE rank <= 3) is a clean way to extract “top-N per group” patterns.
