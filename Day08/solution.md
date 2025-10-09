# Day 08 – Calls Between Distinct Pairs

**Problem:**  
Given a `Calls` table with `from_id`, `to_id`, and `duration`,  
report for each distinct pair of persons `(person1, person2)` where `person1 < person2`:  
- the number of calls made between them, and  
- the total call duration.  

The table can contain duplicate records, and calls can occur in both directions (A→B or B→A).

**Thought Process / Approach:**  
1. We need to treat calls between two people as a **pair**, regardless of direction.  
   - For example, `(1, 2)` and `(2, 1)` should be counted together as `(1, 2)`.  
2. To achieve this, use `LEAST(from_id, to_id)` as `person1` and `GREATEST(from_id, to_id)` as `person2`.  
   This ensures `(1, 2)` and `(2, 1)` always map to the same pair.  
3. **Group by** these pair values and calculate:  
   - `COUNT(*)` for total calls,  
   - `SUM(duration)` for total duration.  

**Solution Query:**

```sql
SELECT 
    LEAST(from_id, to_id) AS person1,
    GREATEST(from_id, to_id) AS person2,
    COUNT(*) AS call_count,
    SUM(duration) AS total_duration
FROM Calls
GROUP BY person1, person2;
```

**Takeaways / Notes:**

LEAST() and GREATEST() are handy for normalizing pairs (avoiding direction duplication).

COUNT(*) tallies all records for each unique pair.

SUM(duration) aggregates total call time.

No need for ordering since any order is acceptable per the problem statement.

This pattern of “unordered pairs” shows up often in social network or communication analysis problems.
