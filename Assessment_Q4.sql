-- For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
-- ● Account tenure (months since signup)
-- ● Total transactions
-- ● Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 *avg_profit_per_transaction)
-- ● Order by estimated CLV from highest to lowest

SELECT 
    u.id AS customer_id,
    u.name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    COUNT(s.transaction_reference) AS total_transactions,
    
    (
        (COUNT(s.transaction_reference) / 
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE())) 
        * 12 *
        AVG(s.confirmed_amount * 0.001)
    ) / 100 AS estimated_clv  

FROM users_customuser u
JOIN savings_savingsaccount s
    ON u.id = s.owner_id

GROUP BY u.id, u.name, u.date_joined

HAVING tenure_months > 0

ORDER BY estimated_clv DESC;