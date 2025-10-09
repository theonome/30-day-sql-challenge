# Day 09 – Actor and Director Collaborations

**Problem:**  
Given the `ActorDirector` table, find all `(actor_id, director_id)` pairs  
where the actor has collaborated with the director **at least three times**.  

Each record represents one collaboration (a movie or project), and duplicates may exist for multiple collaborations.

**Thought Process / Approach:**  
1. Each row indicates a collaboration between an actor and a director.  
2. We need to **group by** both `actor_id` and `director_id` to count total collaborations per pair.  
3. Use `HAVING COUNT(*) >= 3` to filter only those pairs that have worked together three or more times.  

**Solution Query:**

```sql
SELECT 
    actor_id,
    director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3;
```

**Takeaways / Notes:**

GROUP BY allows us to aggregate data by unique actor–director pairs.

HAVING is used after aggregation to filter based on counts (unlike WHERE, which filters before aggregation).

This is a simple but powerful pattern for detecting frequent collaborations or relationships.

The query returns results in any order since ordering is not required by the problem statement.
