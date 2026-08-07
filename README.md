# 🛒 Online Retail Analytics Dashboard

An interactive **Retail Sales & Customer Analytics Dashboard** built using **Power BI, PostgreSQL, SQL, Power Query, and DAX** to transform transactional retail data into actionable business insights.

The project analyzes sales performance, customer behavior, product performance, customer segmentation using **RFM analysis**, product purchasing relationships, and data quality issues through an interactive five-page Power BI dashboard.

---

## 📑 Table of Contents

- Project Overview
- Business Objectives
- Dataset
- Data Preparation
- Data Model
- Dashboard Pages
- Dashboard KPIs
- SQL Business Analysis
- RFM Customer Segmentation
- Data Quality Analysis
- DAX Measures
- Business Questions Answered
- Key Business Insights
- Skills Demonstrated
- Business Value
- Repository Structure
- How to Explore the Dashboard
- Future Improvements
- Author

---

## 📌 Project Overview

The **Online Retail Analytics Dashboard** is an end-to-end Business Intelligence project developed to analyze transactional retail data and provide actionable insights into sales performance, customer behavior, product performance, and data quality.

The project combines **PostgreSQL**, **SQL**, **Power Query**, **DAX**, and **Power BI** to transform raw transactional data into an interactive analytical solution.

The dashboard provides a comprehensive view of:

- Overall retail performance
- Revenue and transaction trends
- Customer purchasing behavior
- Customer retention and segmentation
- Product performance
- Product affinity
- Data quality issues

The solution is designed to support business stakeholders in identifying high-value customers, top-performing products, sales trends, cross-selling opportunities, and data quality issues that may affect analytical results.

---

## 🎯 Business Objectives

- Monitor overall revenue and transaction performance.
- Analyze monthly revenue and transaction trends.
- Identify top-performing countries.
- Identify top-performing products.
- Identify high-value customers based on revenue.
- Analyze repeat and one-time customer behavior.
- Segment customers using RFM analysis.
- Identify customers requiring retention attention.
- Analyze product purchasing relationships.
- Compare revenue and quantity sold.
- Identify missing customer information.
- Measure revenue associated with unknown customers.
- Identify cancelled invoices, return transactions, and zero-price records.
- Support data-driven business decisions through interactive analytics.

---

## 📂 Dataset

The project is based on the **Online Retail transactional dataset**.

The dataset contains transaction-level retail information, including:

- Invoice Number
- Stock Code
- Product Description
- Quantity
- Invoice Date
- Unit Price
- Customer ID
- Country

The raw dataset contains **541,909 transaction records**.

The dataset includes both complete and incomplete records, allowing the project to demonstrate not only business analysis but also dedicated data quality analysis.

---

## 🧹 Data Preparation

Data preparation was performed using **PostgreSQL** and **Power Query**.

Key preparation and transformation steps included:

- Data type validation
- Invoice date transformation
- Revenue calculation
- Transaction-level analysis
- Customer-level aggregation
- RFM feature preparation
- Identification of missing Customer IDs
- Identification of cancelled invoices
- Identification of return transactions
- Identification of zero-price records
- Preparation of analytical tables for Power BI

The raw transactional data was retained to support the dedicated **Data Quality** analysis page.

---

## 🗂️ Data Model

The Power BI model uses transactional and analytical tables to support sales, customer, product, date, and segmentation analysis.

Main tables include:

- `Sales_Data`
- `Customers`
- `RFM`
- `Date`
- Raw Online Retail data

The model connects customer-level information with transactional sales data through `CustomerID`.

The `RFM` table contains customer-level:

- Recency
- Frequency
- Monetary
- RFM Scores
- Customer Segment

The `Date` table supports time-based analysis such as monthly revenue and transaction trends.

---

# 📊 Dashboard Pages

The dashboard consists of **five interactive report pages**, each designed to analyze a specific business area.

---

## 📈 1. Executive Overview

Provides a high-level overview of overall retail performance.

### Dashboard Highlights

- Total Revenue
- Total Orders
- Total Customers
- Units Sold
- Average Order Value
- Monthly Revenue Trend
- Top 10 Countries by Revenue
- Customer Retention Profile
- Top 10 Products by Revenue
- Country Filter
- Year Filter

### Executive KPIs

| KPI | Description |
|---|---|
| Total Revenue | Total revenue generated from retail transactions |
| Total Orders | Number of unique orders/invoices |
| Total Customers | Number of unique customers |
| Units Sold | Total quantity of products sold |
| Average Order Value | Average revenue generated per order |

---

## 👥 2. Customer Analytics

Analyzes customer behavior, customer value, and RFM-based customer segmentation.

### Dashboard Highlights

- Total Customers
- Repeat Customers
- One-Time Customers
- Average Revenue per Customer
- Average Orders per Customer
- Top 10 Customers by Revenue
- Customer Segment Distribution
- Revenue by Customer Segment
- Customer Segment Slicer
- Country Filter
- Year Filter

### Customer Segments

RFM analysis classifies customers into business-oriented segments including:

- Champions
- Loyal Customers
- Potential Loyalists
- Recent Customers
- Promising
- At Risk
- Hibernating
- Lost
- Undefined

This segmentation provides a structured view of customer value and engagement behavior.

---

## 📦 3. Product Analytics

Analyzes product revenue, sales volume, product relationships, and purchasing behavior.

### Dashboard Highlights

- Total Products
- Top Product Revenue
- Average Revenue per Product
- Average Units Sold
- Revenue by Product
- Units Sold by Product
- Product Affinity
- Revenue vs Quantity
- Country Filter
- Year Filter

### Product Affinity

The Product Affinity analysis identifies product pairs that are frequently purchased together.

The dashboard displays the **Top 10 Product Pairs** based on the product-pair analysis performed in SQL.

This analysis can support:

- Cross-selling opportunities
- Product bundling
- Promotional strategies
- Product recommendation analysis

---

## 📈 4. Sales Performance

Provides detailed analysis of revenue and transaction performance over time and across countries.

### Dashboard Highlights

- Total Revenue
- Total Transactions
- Average Order Value
- Monthly Average Revenue
- Revenue Growth %
- Monthly Revenue Trend
- Monthly Orders Trend
- Revenue by Country
- Units Sold by Country
- Country Filter
- Year Filter

### Sales KPIs

| KPI | Description |
|---|---|
| Total Revenue | Total revenue generated from transactions |
| Total Transactions | Number of unique transactions |
| Average Order Value | Average revenue generated per transaction |
| Monthly Average Revenue | Average revenue generated per month |
| Revenue Growth % | Revenue growth based on the defined comparison period |

---

## 🧪 5. Data Quality

Provides a dedicated analysis of data quality issues identified in the raw transactional dataset.

### Dashboard Highlights

- Missing Customer IDs
- Unknown Customer Revenue
- Cancelled Invoices
- Return Transactions
- Zero Price Records
- Data Quality Issues
- Valid vs Issue Distribution
- Data Quality Details Matrix

### Data Quality KPIs

| KPI | Result |
|---|---:|
| Missing Customer IDs | 135,080 |
| Unknown Customer Revenue | 1.45M |
| Cancelled Invoices | 3,836 |
| Return Transactions | 10,624 |
| Zero Price Records | 2,515 |

> Data quality issue categories are not mutually exclusive. A transaction may contain more than one issue, so issue counts should not be added together to represent a unique number of problematic records.

---

# 🧮 RFM Customer Segmentation

Customer segmentation was performed using **RFM analysis** based on three key customer behavior metrics.

### Recency

Measures how recently a customer made a purchase.

### Frequency

Measures the number of distinct invoices associated with a customer.

### Monetary

Measures the total revenue generated by a customer.

RFM scores were calculated and mapped into customer segments to support customer value and retention analysis.

The resulting segments include:

- Champions
- Loyal Customers
- Potential Loyalists
- Recent Customers
- Promising
- At Risk
- Hibernating
- Lost
- Undefined

The RFM analysis provides a customer-level view that complements the overall sales analysis.

---

# 🗃️ SQL Business Analysis

The analytical work was performed using **PostgreSQL**.

SQL was used to prepare analytical datasets and answer business questions before integrating the results into Power BI.

### SQL Analysis Areas

- RFM Customer Segmentation
- Product Affinity Analysis
- Monthly Sales Performance
- Customer Retention Analysis
- Product Performance Analysis
- Data Quality Analysis

### SQL Techniques Demonstrated

- SELECT
- WHERE
- GROUP BY
- HAVING
- DISTINCT
- CASE Statements
- Aggregate Functions
- Common Table Expressions (CTEs)
- Window Functions
- Date Functions
- Conditional Aggregation
- Customer-Level Aggregation
- Product Pair Analysis

The complete SQL analysis is available in:

```text
SQL/Online_Retail_SQL_Analysis.sql