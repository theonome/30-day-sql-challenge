# Day 12- Page  Recommendations

## Problem
Find pages to recommend to the user with `user_id = 1` based on the pages liked by their friends.  
Do not recommend pages the user already likes.  
Return unique page recommendations in any order.

---

## Thought Process
1. Identify all friends of user 1:
   - Friendship is mutual, so we need both directions: `user1_id = 1` or `user2_id = 1`.
2. Collect all pages liked by those friends from the `Likes` table.
3. Exclude pages that user 1 already likes.
4. Use `DISTINCT` to remove duplicates from the result.

---

## Solution
```sql
SELECT DISTINCT l.page_id AS recommended_page
FROM Likes l
JOIN (
    SELECT user2_id AS friend_id FROM Friendship WHERE user1_id = 1
    UNION
    SELECT user1_id AS friend_id FROM Friendship WHERE user2_id = 1
) f
  ON l.user_id = f.friend_id
WHERE l.page_id NOT IN (
    SELECT page_id FROM Likes WHERE user_id = 1
);
```

**Takeaways / Notes**

Use UNION (not UNION ALL) to combine both friendship directions without duplicates.

NOT IN filters out pages already liked by user 1.

Joining the friend list with Likes links friends to their liked pages.

Always include DISTINCT in recommendation-style queries to avoid repeated results.
