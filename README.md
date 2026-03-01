# Data Analytics Assessment

## Overview
This repository contains my SQL solutions to a data analytics assessment focused on solving practical business problems. The tasks cover customer behavior analysis, transaction patterns, inactivity monitoring, and customer lifetime value estimation using MySQL.

---

## Question 1: High-Value Customers with Multiple Products
**Approach:**  
To solve this, I joined the users, plans, and savings tables using their respective foreign keys. I used conditional aggregation (CASE WHEN) to separately count savings and investment plans for each customer. I then filtered for customers who had at least one of each, and calculated their total deposits based on confirmed inflows.

**Challenges:**  
One issue I ran into was duplicate rows caused by joins, which led to inflated counts. I resolved this by using `COUNT(DISTINCT ...)` to ensure I was counting unique plans rather than transactions.

---

## Question 2: Transaction Frequency Analysis
**Approach:**  
First, I calculated the number of transactions per customer per month. Then, I  found the average the monthly values to get a more accurate measure of customer activity. Based on this average, I used a CASE statement to categorize customers into High, Medium, and Low frequency groups.

**Challenges:**  
The tricky part here was structuring the query correctly. Initially, I tried to do everything in one step, but the results were off, so I broke it into a subquery for monthly aggregation.

---

## Question 3: Account Inactivity Alert
**Approach:**  
I used the MAX(transaction_date) function to get the last transaction date for each account. Then, I calculated the number of inactive days using DATEDIFF and filtered accounts with no inflow activity in the past 365 days.

**Challenges:**  
Since I was working with aggregated values (MAX), I used HAVING to filter the results correctly.

---

## Question 4: Customer Lifetime Value (CLV)
**Approach:**  
I calculated customer tenure using TIMESTAMPDIFF (in months), counted total transactions, and computed the average profit per transaction (0.1% of transaction value). I then applied the given CLV formula to estimate customer value and sorted the results accordingly.

**Challenges:**  
Handling division by zero for new users (with very short tenure) was something I had to account for. I addressed this by filtering out cases where tenure was zero.

---

## Notes
- All monetary values were stored in kobo and converted to naira where necessary.
- Only valid inflow transactions (confirmed_amount > 0) were considered in calculations.
- The focus was on writing clear, efficient, and readable SQL queries.
