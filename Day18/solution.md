# Day 18- Game Play Analysis II

## Problem
We are given a table `Activity` that records the gaming activity of players, including which device they used, the date of activity, and how many games they played.  
We need to find the **device each player first logged in with**, meaning the device associated with their earliest `event_date`.

---

## Thought Process
1. For each `player_id`, identify their earliest `event_date`.
2. Match that earliest date with the corresponding `device_id`.
3. Return the `player_id` and the `device_id` of that first login.

To achieve this, we can:
- Use a subquery (or CTE) to find the minimum event_date per player.
- Join it back with the main table on both `player_id` and `event_date` to fetch the corresponding device.

---

## SQL Query
```sql
SELECT a.player_id, a.device_id
FROM Activity a
JOIN (
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
) b
ON a.player_id = b.player_id
AND a.event_date = b.first_login;
```
---
## Takeaways

The MIN() function is key to identifying the earliest date per player.

Joining back ensures we get the correct device for that date.

If multiple records exist for the same first date (with different devices), this query will return all matching rows.

This approach is efficient and avoids unnecessary window functions.
