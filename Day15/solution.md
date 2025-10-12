# Day 15- leetflex Banned Accounts

## Problem
Given `LogInfo(account_id, ip_address, login, logout)`, find `account_id`s that should be banned.  
An account should be banned if it was logged in **at some moment** from **two different IP addresses** (i.e., two sessions from different IPs overlap at least at one point in time).  
Return the account ids in any order.

---

## Thought Process
- Two sessions overlap **if there exists any moment in time** when both are active.  
- For time intervals `[login, logout]`, intervals overlap if they are **not** disjoint. To allow a single instant (e.g., one session's logout equals another's login) to count as overlap, we use **inclusive** overlap checks.
- Use a self-join on `LogInfo` for the same `account_id`, require different `ip_address`es, and check interval overlap with:

```sql
SELECT DISTINCT a.account_id
FROM LogInfo a
JOIN LogInfo b
ON a.account_id = b.account_id
AND a.ip_address <> b.ip_address
AND a.login <= b.logout
AND a.logout >= b.login;
```
## Takeaways / Notes

Using a.ip_address <> b.ip_address ensures we only consider different IP addresses.

DISTINCT prevents duplicate account ids in the output even if multiple overlapping pairs exist.

This pattern (self-join + interval overlap) is common for detecting concurrent sessions or conflicting bookings.
