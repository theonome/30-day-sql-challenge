# Day 16- Students with Invalid Departments

## Problem
We are given two tables:  
- **Departments(id, name)** — contains the list of all departments in the university.  
- **Students(id, name, department_id)** — contains each student’s department assignment.  

We need to find the **students whose department_id does not exist** in the `Departments` table.

---

## Thought Process
- Some departments may no longer exist (i.e., have been deleted from the `Departments` table).  
- We need to return students who belong to these missing departments.  
- Use a **LEFT JOIN** from `Students` to `Departments` and filter where the department information is `NULL`.  
  - `LEFT JOIN` ensures all students are included, even if their department has no match.
  - `WHERE Departments.id IS NULL` identifies the missing department records.

---

## Solution
```sql
SELECT s.id, s.name
FROM Students s
LEFT JOIN Departments d
  ON s.department_id = d.id
WHERE d.id IS NULL;
```
---

## Takeaways / Notes

LEFT JOIN + WHERE IS NULL is a common SQL pattern to find rows in one table that reference non-existent rows in another.
