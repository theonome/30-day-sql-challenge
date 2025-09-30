### **Day 02 – Highest Grade per Student**

**Problem:**
Given the `Enrollments` table (`student_id, course_id, grade`), find the course with the **highest grade** for each student. If multiple courses tie for the highest grade, pick the one with the **smallest course_id**. Return results ordered by `student_id`.

---

**Thought Process / Approach:**

1. We need to **rank each course per student** based on grade.
2. Resolve **ties** by selecting the course with the **smallest course_id**.
3. Use a **window function** (`ROW_NUMBER()`) to assign ranks per student.
4. Pick **only the top-ranked row** per student.

---

**Solution Query (MySQL 8+):**

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

---

**Takeaways / Notes:**

* `ROW_NUMBER()` lets us **rank rows per group** without subqueries.
* `PARTITION BY student_id` groups courses per student.
* `ORDER BY grade DESC, course_id ASC` ensures **highest grade first** and **smallest course_id for ties**.
* Clean, readable, and efficient compared to nested subqueries.

