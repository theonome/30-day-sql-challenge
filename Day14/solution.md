# Day 14- Grand Slam Titles

## Problem
You are given two tables:  
- **Players**: contains each tennis player’s `player_id` and `player_name`.  
- **Championships**: contains the yearly winners of the four grand slam tournaments (`Wimbledon`, `Fr_open`, `US_open`, and `Au_open`).  

Write a query to report how many grand slam tournaments each player has won in total.  
Exclude players who have not won any tournaments.

---

## Thought Process
1. Each championship year lists winners by player IDs across four tournaments.  
2. To count total wins, we need to “unpivot” these four columns into a single list of winners.  
3. Then we can `GROUP BY` each player to count how many times their ID appears.  
4. Finally, join the results back to the `Players` table to show player names.

---

## Solution
```sql
SELECT 
  p.player_id,
  p.player_name,
  COUNT(*) AS grand_slams_count
FROM Players p
JOIN (
  SELECT Wimbledon AS player_id FROM Championships
  UNION ALL
  SELECT Fr_open FROM Championships
  UNION ALL
  SELECT US_open FROM Championships
  UNION ALL
  SELECT Au_open FROM Championships
) AS winners
ON p.player_id = winners.player_id
GROUP BY p.player_id, p.player_name;
```

## Takeaways 

Use UNION ALL to stack multiple columns as rows — a key step when unpivoting data.

Counting wins simply means counting how many times each player ID appears among all tournaments.

UNION (without ALL) would remove duplicates, which isn’t desired because a player can win multiple times.

Joining after unpivoting ensures we get player names alongside the aggregated counts.
