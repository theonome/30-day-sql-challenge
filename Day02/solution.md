# Day 02 – Highest Grade per Student

**Problem:**  
Given the `Enrollments` table with columns `student_id`, `course_id`, and `grade`, find the **highest grade per student**.  
- If multiple courses have the same highest grade, pick the **smallest course_id**.  
- Return the results **ordered by student_id**.

**Thought Process / Approach:**  
1. Rank each course per student using a window function.  
2. Sort by `grade` descending, then `course_id` ascending to resolve ties.  
3. Pick only the **top-ranked row** for each student.

**Solution Query:**

```sql
SELECT student_id, course_id, grade
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY student_id
               ORDER BY grade DESC, course_id ASC
           ) AS rn
    FROM Enrollments
) t
WHERE rn = 1
ORDER BY student_id;
```

**Takeaways / Notes:**

ROW_NUMBER() is great for ranking within groups.

PARTITION BY groups data per student.

ORDER BY grade DESC, course_id ASC handles tie-breaking.

Efficient and clean—no subqueries needed.
