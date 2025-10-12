# Day 13-Game Play Analysis III

## Problem
Given an `Activity` table that tracks players’ daily gaming activity (`player_id`, `event_date`, and `games_played`),  
write a query to report, for each player and date, the **total number of games played so far** by that player — i.e., the running cumulative total up to that date.

---

## Thought Process
1. We need to calculate a running total of `games_played` for each `player_id` over time.  
2. This can be achieved with the `SUM()` window function combined with `OVER()` and `ORDER BY event_date`.  
3. The partition ensures the cumulative count is done **per player**, not across all players.  

---

## Solution
```sql
SELECT
  player_id,
  event_date,
  SUM(games_played) OVER (
    PARTITION BY player_id 
    ORDER BY event_date
  ) AS games_played_so_far
FROM Activity;
```

## Takeaways / Notes

The SUM() OVER() clause is powerful for cumulative totals without needing subqueries.

Always partition by player_id to reset the total for each player.

Ordering by event_date ensures the total is calculated in sequence.
