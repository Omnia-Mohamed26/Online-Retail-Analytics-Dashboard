# 🛒 Online Retail Analytics Dashboard

An interactive **Retail Sales & Customer Analytics Dashboard** built using **Power BI, PostgreSQL, SQL, Power Query, and DAX** to transform transactional retail data into meaningful business insights.

The dashboard provides an analytical view of sales performance, customer behavior, product performance, RFM customer segmentation, product affinity, and data quality through five interactive Power BI report pages.

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
- Project Summary
- Author

---

## 📌 Project Overview

The **Online Retail Analytics Dashboard** is an end-to-end Business Intelligence project designed to analyze transactional retail data and transform it into actionable business insights.

The project combines **PostgreSQL**, **SQL**, **Power Query**, **DAX**, and **Power BI** to prepare, analyze, model, and visualize retail transaction data.

The dashboard focuses on four major analytical areas:

- Sales Performance
- Customer Analytics
- Product Analytics
- Data Quality

It also incorporates **RFM Customer Segmentation** and **Product Affinity Analysis** to provide deeper customer and product-level insights.

---

## 🎯 Business Objectives

- Monitor overall retail sales performance.
- Analyze revenue and transaction trends over time.
- Identify top-performing countries and products.
- Analyze customer purchasing behavior.
- Compare repeat and one-time customers.
- Identify high-value customers.
- Segment customers using RFM analysis.
- Identify customer groups requiring retention attention.
- Analyze products frequently purchased together.
- Compare product revenue and sales quantity.
- Identify missing and problematic transaction records.
- Quantify revenue associated with unknown customers.
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

The original dataset contains **541,909 transaction records**.

The dataset contains both complete and incomplete records, which allows the project to combine business analysis with dedicated data quality analysis.

---

## 🧹 Data Preparation

Data preparation and transformation were performed using **PostgreSQL** and **Power Query**.

Key preparation activities included:

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

The raw transactional data was retained to support the dedicated Data Quality page.

---

## 🗂️ Data Model

The Power BI model combines transactional and analytical tables to support sales, customer, product, date, and segmentation analysis.

### Main Tables

- `Sales_Data`
- `Customers`
- `RFM`
- `Date`
- Raw Online Retail data

The model supports customer-level and transaction-level analysis through `CustomerID` relationships.

The `RFM` table contains:

- Recency
- Frequency
- Monetary
- RFM Score
- Customer Segment

The `Date` table supports time-based analysis including monthly revenue and transaction trends.

---

# 📊 Dashboard Pages

The dashboard consists of **five interactive report pages**, each focused on a specific analytical area.

---

## 📈 1. Executive Overview

![Executive Overview](Assets/1_Executive_Overview.png)

Provides a high-level view of overall retail performance.

### Highlights

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

---

## 👥 2. Customer Analytics

![Customer Analytics](Assets/2_Customer_Analytics.png)

Analyzes customer purchasing behavior, customer value, and customer segmentation.

### Highlights

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

---

## 📦 3. Product Analytics

![Product Analytics](Assets/3_Product_Analytics.png)

Analyzes product performance, sales volume, purchasing relationships, and product-level revenue.

### Highlights

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

The dashboard presents the **Top 10 Product Pairs** generated through SQL-based product pair analysis.

This analysis can support:

- Cross-selling opportunities
- Product bundling
- Promotional strategies
- Product recommendation analysis

---

## 📈 4. Sales Performance

![Sales Performance](Assets/4_Sales_Performance.png)

Provides a detailed view of revenue and transaction performance over time and across countries.

### Highlights

- Total Revenue
- Total Transactions
- Average Order Value
- Monthly Average Revenue
- Revenue Growth %
- Monthly Revenue Trend
- Monthly Transaction Trend
- Revenue by Country
- Units Sold by Country
- Country Filter
- Year Filter

---

## 🧪 5. Data Quality

![Data Quality](Assets/5_Data_Quality.png)

Provides a dedicated view of data quality issues identified in the raw transactional dataset.

### Highlights

- Missing Customer IDs
- Revenue from Unknown Customers
- Cancelled Invoices
- Return Transactions
- Zero Price Records
- Data Quality Issues
- Valid vs Issue Distribution
- Data Quality Details Matrix

---

## ⭐ Project Highlights

- Five-page interactive Power BI dashboard
- PostgreSQL-based SQL analysis
- Customer RFM segmentation
- Product Affinity analysis
- Sales performance analysis
- Customer behavior analysis
- Product performance analysis
- Dedicated data quality analysis
- Dynamic DAX measures
- Interactive slicers and filtering
- Consistent dashboard design
- Business-focused data storytelling

---

## 📊 Dashboard KPIs

The dashboard uses dynamic KPI cards to monitor key business metrics.

| KPI | Description |
|---|---|
| Total Revenue | Total revenue generated from retail transactions |
| Total Orders | Number of unique orders/invoices |
| Total Customers | Number of unique customers |
| Units Sold | Total quantity of products sold |
| Average Order Value | Average revenue generated per order |
| Repeat Customers | Customers with multiple purchasing transactions |
| One-Time Customers | Customers with a single purchasing transaction |
| Total Products | Number of distinct products |
| Total Transactions | Number of transactions analyzed |

---

## 🗃️ SQL Business Analysis

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
