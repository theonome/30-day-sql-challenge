# Day 11- Friendly Movies Streamed Last Month

## Problem
Write a SQL query to report the distinct titles of kid-friendly movies streamed in June 2020.  
Return the result table in any order.

---

## Thought Process
1. Join `Content` and `TVProgram` using `content_id`.
2. Filter where:
   - `Kids_content = 'Y'`
   - `content_type = 'Movies'`
   - `program_date` falls between `'2020-06-01'` and `'2020-06-30'`.
3. Select distinct titles to avoid duplicates from multiple airings.

---

## Solution
```sql
SELECT DISTINCT c.title
FROM Content c
JOIN TVProgram t
  ON c.content_id = t.content_id
WHERE 
  c.Kids_content = 'Y'
  AND c.content_type = 'Movies'
  AND t.program_date BETWEEN '2020-06-01' AND '2020-06-30';
```
**Takeaways / Notes**

Use DISTINCT to remove duplicate movie titles.

The BETWEEN clause neatly captures the full month of June 2020.

Joins allow combining program details with content metadata.

Enum values like 'Y' should be matched exactly as stored.
