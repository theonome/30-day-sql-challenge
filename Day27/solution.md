# Day 28- Customers Who Bought All Products

### Problem  
We need to find all customers who have purchased **every product** available in the `Product` table.  
The `Customer` table may contain duplicates, so we must ensure distinct counting.  
A customer qualifies only if they have bought all distinct products listed in the `Product` table.

---

### Thought Process  
1. Count how many unique products exist in the `Product` table.  
2. In the `Customer` table, group by each `customer_id` and count how many **distinct** products they purchased.  
3. Compare the customer’s distinct product count with the total number of products.  
4. If they match, that customer has bought all products.

---

### Solution Query  
```sql
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);
```
---

### Takeaway

This problem demonstrates how to use aggregation with HAVING to apply conditions on grouped data.
By comparing a customer’s product count with the total available products, 
we can efficiently identify those who purchased all items.
