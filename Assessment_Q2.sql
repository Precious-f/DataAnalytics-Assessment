-- Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    AVG(avg_transactions_per_month) AS avg_transactions_per_month
    
FROM (
    SELECT 
        u.id AS owner_id,
        u.name,
        AVG(monthly_transactions) AS avg_transactions_per_month,
        CASE 
            WHEN AVG(monthly_transactions) >= 10 THEN 'High Frequency'
            WHEN AVG(monthly_transactions) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM (
        SELECT 
            owner_id,
            DATE_FORMAT(transaction_date, '%Y-%m') AS month,
            COUNT(transaction_reference) AS monthly_transactions
        FROM savings_savingsaccount
        
        GROUP BY owner_id, month
    ) AS monthly_data
    
    JOIN users_customuser u 
        ON u.id = monthly_data.owner_id
        
    GROUP BY u.id, u.name
) AS customer_avg

GROUP BY frequency_category;