# Day 05 – Total Distance Traveled by Users

**Problem:**  
Given the `Users` and `Rides` tables, report the **total distance traveled** by each user.  
- Include users with **no rides** (distance = 0).  
- Order by `travelled_distance` descending, and if tied, by `name` ascending.

**Thought Process / Approach:**  
1. **LEFT JOIN** `Users` with `Rides` so users without rides are included.  
2. Use `SUM(distance)` with `COALESCE` to handle NULLs for users with no rides.  
3. **Group by user** to calculate total distance.  
4. Order results by `travelled_distance` descending, then `name` ascending for ties.  

**Solution Query:**

```sql
SELECT 
    u.name,
    COALESCE(SUM(r.distance), 0) AS travelled_distance
FROM Users u
LEFT JOIN Rides r 
       ON u.id = r.user_id
GROUP BY u.id, u.name
ORDER BY travelled_distance DESC, u.name ASC;
```

**Takeaways / Notes:**

LEFT JOIN ensures users with zero rides are included.

COALESCE(SUM(...), 0) converts NULL to 0 for users with no rides.

GROUP BY aggregates distances per user.

ORDER BY handles both descending distance and alphabetical tie-breaker efficiently.
