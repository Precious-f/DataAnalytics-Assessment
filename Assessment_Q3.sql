-- Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .

SELECT 
    p.id AS plan_id,
    p.owner_id,
    
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
    END AS type,
		
    MAX(s.transaction_date) AS last_transaction_date,
    
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days

FROM plans_plan p
JOIN savings_savingsaccount s 
    ON p.id = s.plan_id

GROUP BY p.id, p.owner_id, type
HAVING 
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) > 365;