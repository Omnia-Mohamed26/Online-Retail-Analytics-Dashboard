-- Data Exploration
-- =====================================================

-- Explore the dataset structure
SELECT *
FROM online_retail

----------------------------------------------------------

-- Count the total number of unique customers
SELECT COUNT(DISTINCT CustomerID) AS TotalCustomers
FROM online_retail
WHERE CustomerID IS NOT NULL
  AND TRIM(CustomerID) <> ''
  AND Quantity > 0
  AND UnitPrice > 0

----------------------------------------------------------

-- Calculate total sales by country
SELECT
    Country,
    SUM(Quantity * UnitPrice) AS TotalSales
FROM online_retail
GROUP BY Country
ORDER BY TotalSales DESC

----------------------------------------------------------

-- Identify the top-selling products by quantity
SELECT
    Description,
    SUM(Quantity) AS TotalQuantity
FROM online_retail
GROUP BY Description
ORDER BY TotalQuantity DESC
LIMIT 10

-- =====================================================
-- Data Quality Assessment
-- =====================================================

-- Check the dataset for cancelled invoices, returns,
-- missing values, invalid prices, and malformed dates.

WITH data_quality_check AS (
    SELECT

        COUNT(CASE WHEN InvoiceNo LIKE 'C%' THEN 1 END) AS cancelled_invoices,
        COUNT(DISTINCT CASE WHEN InvoiceNo LIKE 'C%' THEN InvoiceNo END) AS distinct_cancelled_invoices,

        COUNT(CASE WHEN Quantity < 0 THEN 1 END) AS return_transactions,
        SUM(CASE WHEN Quantity < 0 THEN ABS(Quantity) * UnitPrice ELSE 0 END) AS total_return_value,

        COUNT(CASE WHEN UnitPrice <= 0 THEN 1 END) AS zero_or_negative_price_items,
        COUNT(DISTINCT CASE WHEN UnitPrice <= 0 THEN StockCode END) AS distinct_zero_price_products,

        COUNT(CASE WHEN CustomerID IS NULL OR TRIM(CustomerID) = '' THEN 1 END) AS missing_customer_ids,
        COUNT(DISTINCT CASE WHEN CustomerID IS NULL OR TRIM(CustomerID) = '' THEN InvoiceNo END) AS invoices_with_missing_customer,

        COUNT(CASE WHEN Description IS NULL OR TRIM(Description) = '' THEN 1 END) AS missing_descriptions,
        COUNT(DISTINCT CASE WHEN Description IS NULL OR TRIM(Description) = '' THEN StockCode END) AS products_without_description,

        COUNT(CASE WHEN InvoiceDate IS NULL THEN 1 END) AS null_invoice_dates,
        COUNT(CASE WHEN CAST(InvoiceDate AS VARCHAR) NOT LIKE '____-__-__ __:__:__' THEN 1 END) AS malformed_dates,

        COUNT(*) AS total_rows

    FROM online_retail
)

SELECT

    total_rows,

    cancelled_invoices,
    ROUND(cancelled_invoices * 100.0 / total_rows,2) AS cancelled_invoices_pct,
    distinct_cancelled_invoices,

    return_transactions,
    ROUND(return_transactions * 100.0 / total_rows,2) AS return_transactions_pct,
    total_return_value,

    zero_or_negative_price_items,
    ROUND(zero_or_negative_price_items * 100.0 / total_rows,2) AS zero_price_items_pct,
    distinct_zero_price_products,

    missing_customer_ids,
    ROUND(missing_customer_ids * 100.0 / total_rows,2) AS missing_customer_ids_pct,
    invoices_with_missing_customer,

    missing_descriptions,
    ROUND(missing_descriptions * 100.0 / total_rows,2) AS missing_descriptions_pct,
    products_without_description,

    null_invoice_dates,
    malformed_dates

FROM data_quality_check


-- =====================================================
-- Business Question:
-- Question 1: High-Value Customer Identification
-- Who are the top 10 customers based on total spending?

SELECT
    customerid,
    SUM(Quantity * UnitPrice) AS TotalSpending,
    RANK() OVER (
        ORDER BY SUM(Quantity * UnitPrice) DESC
    ) AS CustomerRank
FROM online_retail
WHERE customerid IS NOT NULL
  AND customerid != ''
  AND Quantity > 0
  AND UnitPrice > 0
  AND InvoiceNo NOT LIKE 'C%'
GROUP BY customerid
ORDER BY TotalSpending DESC
LIMIT 10




-- Question 2: Product Performance Analysis
-- Which products generate the highest revenue?

SELECT
    StockCode,
    Description,
    SUM(Quantity) AS UnitsSold,
    SUM(Quantity * UnitPrice) AS Revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(Quantity * UnitPrice) DESC
    ) AS RevenueRank
FROM online_retail
WHERE StockCode IS NOT NULL
GROUP BY StockCode, Description
ORDER BY Revenue DESC
LIMIT 10




-- Question 3: Customer Retention Analysis
-- Which customers are repeat buyers and which customers made only one purchase?

SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceDate) AS PurchaseCount,
    CASE
        WHEN COUNT(DISTINCT InvoiceDate) > 1 THEN 'Repeat'
        ELSE 'One-Time'
    END AS CustomerType
FROM online_retail
WHERE CustomerID IS NOT NULL
   AND CustomerID <> ''
GROUP BY CustomerID




-- Question 4: Monthly Sales Performance Analysis
-- How does sales performance vary across different months?

SELECT
    EXTRACT(YEAR FROM TO_TIMESTAMP(InvoiceDate, 'MM/DD/YYYY HH24:MI')) AS Year,
    EXTRACT(MONTH FROM TO_TIMESTAMP(InvoiceDate, 'MM/DD/YYYY HH24:MI')) AS Month,
    SUM(Quantity * UnitPrice) AS Revenue,
    COUNT(*) AS TransactionCount
FROM online_retail
GROUP BY Year, Month
ORDER BY Year, Month



-- Question 5: Product Affinity Analysis
-- Which products are frequently purchased together?

WITH ProductPairs AS (

    SELECT
        a.StockCode AS Product1,
        b.StockCode AS Product2,
        COUNT(DISTINCT a.InvoiceNo) AS ComboCount

    FROM online_retail a
    JOIN online_retail b
        ON a.InvoiceNo = b.InvoiceNo
       AND a.StockCode < b.StockCode

    GROUP BY
        a.StockCode,
        b.StockCode

    HAVING COUNT(DISTINCT a.InvoiceNo) > 10

)

SELECT
    Product1,
    Product2,
    ComboCount,
    ROUND(
        ComboCount * 100.0 /
        (SELECT COUNT(DISTINCT InvoiceNo) FROM online_retail),
        2
    ) AS PenetrationPct

FROM ProductPairs

ORDER BY ComboCount DESC

LIMIT 10



-- Question 6: RFM Customer Segmentation
-- How can customers be segmented based on Recency,
-- Frequency, and Monetary value?

WITH data_clean AS (

    SELECT
        customerid,
        invoiceno,
        unitprice,
        quantity,
        TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI')::date AS invoice_date
    FROM online_retail

),

rfm_base AS (

    SELECT
        customerid,

        (
            (SELECT MAX(invoice_date) FROM data_clean)
            - MAX(invoice_date)
        ) AS recency,

        CAST(COUNT(DISTINCT invoiceno) AS NUMERIC) AS frequency,

        ROUND(
            CAST(SUM(unitprice * quantity) AS NUMERIC),
            2
        ) AS monetary

    FROM data_clean

    WHERE customerid IS NOT NULL
  AND TRIM(customerid) <> ''
  AND quantity > 0
  AND unitprice > 0

    GROUP BY customerid

),

r_scored AS (

    SELECT
        customerid,
        recency,
        frequency,
        monetary,

        ROUND((frequency + monetary) / 2, 2) AS fm_avg,

        CASE

            WHEN recency BETWEEN 0
                 AND MAX(recency) OVER () / 5
                THEN 5

            WHEN recency BETWEEN MAX(recency) OVER () / 5 + 1
                 AND MAX(recency) OVER () / 5 * 2
                THEN 4

            WHEN recency BETWEEN MAX(recency) OVER () / 5 * 2 + 1
                 AND MAX(recency) OVER () / 5 * 3
                THEN 3

            WHEN recency BETWEEN MAX(recency) OVER () / 5 * 3 + 1
                 AND MAX(recency) OVER () / 5 * 4
                THEN 2

            WHEN recency BETWEEN MAX(recency) OVER () / 5 * 4 + 1
                 AND MAX(recency) OVER () / 5 * 5
                THEN 1

            ELSE 0

        END AS R_Score

    FROM rfm_base

),

fm_scored AS (

    SELECT
        customerid,
        recency,
        frequency,
        monetary,
        R_Score,
        fm_avg,

        CASE

            WHEN fm_avg BETWEEN MIN(fm_avg)
                 AND MAX(fm_avg) OVER () / 5
                THEN 1

            WHEN fm_avg BETWEEN MAX(fm_avg) OVER () / 5 + 1
                 AND MAX(fm_avg) OVER () / 5 * 2
                THEN 2

            WHEN fm_avg BETWEEN MAX(fm_avg) OVER () / 5 * 2 + 1
                 AND MAX(fm_avg) OVER () / 5 * 3
                THEN 3

            WHEN fm_avg BETWEEN MAX(fm_avg) OVER () / 5 * 3 + 1
                 AND MAX(fm_avg) OVER () / 5 * 4
                THEN 4

            ELSE 5

        END AS F_M_Score

    FROM r_scored

    GROUP BY
        customerid,
        recency,
        frequency,
        monetary,
        R_Score,
        fm_avg

)

SELECT
    customerid,
    recency,
    frequency,
    monetary,
    R_Score,
    F_M_Score,
    fm_avg,

    CASE

        WHEN R_Score = 5
             AND F_M_Score IN (5, 4)
            THEN 'Champions'

        WHEN R_Score = 4
             AND F_M_Score = 5
            THEN 'Champions'

        WHEN R_Score IN (5, 4)
             AND F_M_Score = 2
            THEN 'Potential Loyalists'

        WHEN R_Score IN (3, 4)
             AND F_M_Score = 3
            THEN 'Potential Loyalists'

        WHEN R_Score = 5
             AND F_M_Score = 3
            THEN 'Loyal Customers'

        WHEN R_Score = 4
             AND F_M_Score = 4
            THEN 'Loyal Customers'

        WHEN R_Score = 3
             AND F_M_Score IN (5, 4)
            THEN 'Loyal Customers'

        WHEN R_Score = 5
             AND F_M_Score = 1
            THEN 'Recent Customers'

        WHEN R_Score = 4
             AND F_M_Score = 1
            THEN 'Promising'

        WHEN R_Score = 3
             AND F_M_Score = 1
            THEN 'Promising'

        WHEN R_Score = 2
             AND F_M_Score IN (2, 3)
            THEN 'Customers Needing Attention'

        WHEN R_Score = 3
             AND F_M_Score = 2
            THEN 'Customers Needing Attention'

        WHEN R_Score = 2
             AND F_M_Score IN (4, 5)
            THEN 'At Risk'

        WHEN R_Score = 1
             AND F_M_Score = 3
            THEN 'At Risk'

        WHEN R_Score = 1
             AND F_M_Score IN (4, 5)
            THEN 'Can Not Lose Them'

        WHEN R_Score = 1
             AND F_M_Score = 2
            THEN 'Hibernating'

        WHEN R_Score = 1
             AND F_M_Score = 1
            THEN 'Lost'

        ELSE 'Undefined'

    END AS Customer_Segment

FROM fm_scored

ORDER BY F_M_Score DESC