-- Question 1 -----
-- Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

-- USE adashi_staging
SELECT 
    u.id AS owner_id,
    u.name,
    COUNT(CASE WHEN p.is_fixed_investment = 0 THEN 1 END) AS savings_count,
    COUNT(CASE WHEN p.is_fixed_investment = 1 THEN 1 END) AS investment_count,
    SUM(s.amount) AS total_deposits

FROM users_customuser u
JOIN plans_plan p 
    ON u.id = p.owner_id

JOIN savings_savingsaccount s 
    ON p.id = s.plan_id   

GROUP BY u.id, u.name

HAVING 
    COUNT(CASE WHEN p.is_fixed_investment = 0 THEN 1 END) >= 1
    AND
    COUNT(CASE WHEN p.is_fixed_investment = 1 THEN 1 END) >= 1

ORDER BY total_deposits DESC;

















