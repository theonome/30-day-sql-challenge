# Day 28- Friend Requests II: Who Has the Most Friends

### Problem  
We need to find the user who has the **most friends** in the `RequestAccepted` table.  
A friendship is **bidirectional** — meaning if `(1, 2)` exists, both user 1 and user 2 are considered friends.  
We must count how many unique friends each user has and return:
- Their `id`
- The number of friends `num`

Only one person will have the most friends (guaranteed by the problem).

---

### Thought Process  
1. Each row represents a friendship between `requester_id` and `accepter_id`.  
   So, both sides gain one friend.  
2. To count all friends, we can:
   - Use `UNION ALL` to combine both requester and accepter IDs into one column.
   - Group by user ID.
   - Count how many times each appears (each occurrence = one friend).  
3. Finally, select the user with the **maximum count**.

---

### Solution Query  
```sql
SELECT id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted) AS all_friends
GROUP BY id
ORDER BY num DESC
LIMIT 1;
```
---

### Takeaway

This problem reinforces how relationships can be bidirectional in social network datasets.
Using UNION ALL allows counting both directions of friendship.
The key insight is that friendship is symmetric, so each record contributes to two users’ totals.
