use audit_db;


#Total Fraud Summary
SELECT 
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS total_fraud,
    ROUND(SUM(isFraud)/COUNT(*) * 100, 3) AS fraud_rate_percentage
FROM transactions;

SET GLOBAL max_allowed_packet=1073741824;



#Fraud by Transaction Type
SELECT 
    type,
    COUNT(*) AS total_txn,
    SUM(isFraud) AS fraud_cases,
    ROUND(SUM(isFraud)/COUNT(*) * 100, 3) AS fraud_rate
FROM transactions
GROUP BY type
ORDER BY fraud_rate DESC;


#High Risk vs Fraud
SELECT 
    high_risk,
    COUNT(*) AS total_txn,
    SUM(isFraud) AS fraud_cases
FROM transactions
GROUP BY high_risk;


#Balance Mismatch Impact
SELECT 
    balance_mismatch,
    COUNT(*) AS total_txn,
    SUM(isFraud) AS fraud_cases
FROM transactions
GROUP BY balance_mismatch;


#System vs Model Comparison
SELECT
    SUM(CASE WHEN isFraud = 1 AND isFlaggedFraud = 1 THEN 1 ELSE 0 END) AS system_correct,
    SUM(CASE WHEN isFraud = 1 AND high_risk = 1 THEN 1 ELSE 0 END) AS model_correct
FROM transactions;



#High Risk View
CREATE VIEW high_risk_transactions AS
SELECT *
FROM transactions
WHERE high_risk = 1;


#Fraud Summary View
CREATE VIEW fraud_summary AS
SELECT 
    type,
    COUNT(*) AS total_txn,
    SUM(isFraud) AS fraud_cases
FROM transactions
GROUP BY type;



#Fraud by Type
SELECT type, SUM(isFraud) FROM transactions GROUP BY type;


#Control Effectiveness
SELECT 
    isFlaggedFraud,
    COUNT(*) AS total,
    SUM(isFraud) AS fraud_cases
FROM transactions
GROUP BY isFlaggedFraud;


SELECT * FROM transactions LIMIT 5;













