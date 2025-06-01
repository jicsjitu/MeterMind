# ⚡ MeterMind - Smart Energy Analytics for Ranchi

**MeterMind** is a smart-meter-based data analytics project that leverages **SQL** and **Power BI** to uncover valuable energy consumption insights for the city of **Ranchi**. This project is designed to solve real-world electricity usage and billing challenges by transforming raw meter data into interactive dashboards and data-driven decisions.

---

## 🔍 Introduction

In today's world, **smart meters** are revolutionizing how we monitor, manage, and optimize electricity consumption. However, raw data from these devices often remains underutilized. **MeterMind** bridges this gap by transforming energy data into intuitive business intelligence dashboards.

This project provides a deep dive into **energy consumption patterns**, **bill generation**, and **consumer behavior** across Ranchi, enabling stakeholders to take data-backed decisions for **cost efficiency** and **grid optimization**.

---

## 🧩 Problem Statement

Utility providers and electricity boards often face challenges such as:
- Unclear consumption patterns
- Irregular bill generation
- Lack of visual insights into meter data
- Delayed energy theft detection or peak usage prediction

**MeterMind** solves these issues by analyzing structured smart meter data to deliver clear, actionable insights.

---

## 🎯 Project Objectives

- Create a centralized dataset from smart meter readings
- Analyze daily/monthly energy consumption trends
- Track customer-wise usage, billing, and status
- Generate interactive dashboards for better understanding
- Identify power wastage, irregular readings, or outage signals
- Optimize electricity billing based on usage data

---

## 💡 Why *MeterMind*?

The name **MeterMind** was chosen to reflect the core intelligence behind the project:

- **Meter**: Represents smart electricity meters
- **Mind**: Represents the smart analytical engine (you!) extracting meaning from the data

Together, *MeterMind* suggests:  
> “A smart mind behind energy meters” – bringing smart insights from raw utility data.

---

## 📊 Dataset Description

The dataset consists of **150 smart meter records** (sampled and cleaned) representing electricity usage for consumers in Ranchi. The data includes:

| Column Name         | Description                                       |
|---------------------|---------------------------------------------------|
| Customer_ID         | Unique ID of each customer                        |
| Meter_ID            | Unique meter ID                                   |
| Location            | City area/location name                           |
| Energy_Consumed(kWh)| Total energy consumed                             |
| Meter_Status        | Active, Inactive, or Faulty                       |
| Billing_Amount(INR) | Final bill amount                                 |
| Billing_Date        | Date of bill generation                           |
| Consumption_Slab    | Slab category based on usage                      |
| Month               | Month of billing                                  |
| Year                | Year of billing                                   |
and so on..
> **Data Size:** 150 rows | **Format:** `.csv` & SQL Table  
> **Source:** Mock data created for educational & visualization purposes

---

## 🎯 Key Business Problems Solved

✅ Which area of Ranchi consumes the most energy?  
✅ Which customers have inactive or faulty meters?  
✅ What is the average monthly billing amount across slabs?  
✅ Which meters have the highest or lowest consumption?  
✅ How does consumption vary month to month?

---

## ⚙️ Tools & Technologies Used

| Tool/Tech       | Purpose                                  |
|------------------|-------------------------------------------|
| SQL (MySQL)      | Data querying and preprocessing           |
| Power BI         | Dashboard creation and visual analytics   |
| Excel/CSV        | Data cleaning and staging                 |
| Git & GitHub     | Version control and hosting               |
| MS Word          | Report design (optional)                  |

---

## 🚀 How to Run the Project

### 💻 1. SQL Setup
- Import the dataset into your SQL environment (MySQL/PostgreSQL)
- Use the provided SQL queries to analyze and extract insights
- Sample SQL command to import data:
```sql
LOAD DATA INFILE 'meter_readings_ranchi.csv'
INTO TABLE smart_meter_data
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;
````

### 📊 2. Power BI Setup

* Open `MeterMind_Dashboard.pbix` in Power BI
* Connect to your SQL data source or load CSV
* Refresh data to view the latest insights

> 🧠 Make sure Power BI is set to auto-refresh if you're connecting to SQL directly

---

## 📝 SQL Query Guide

| Query                                                                                     | Description                    |
| ----------------------------------------------------------------------------------------- |------------------------------- |
| `SELECT * FROM meter_readings;`                                                           | View full dataset              |
| `SELECT Location, SUM(Energy_Consumed) FROM meter_readings GROUP BY Location;`            | Total energy usage by location |
| `SELECT Customer_ID, Billing_Amount FROM meter_readings WHERE Meter_Status = 'Inactive';` | Inactive customers             |
| `SELECT Month, AVG(Billing_Amount) FROM meter_readings GROUP BY Month;`                   | Monthly billing average        |

---

## 📊 Power BI Dashboard Guide

Dashboard includes:

* 🔥 **Top 10 High Usage Customers**
* 📅 **Monthly Trends** of Energy and Billing
* 🚦 **Meter Status Breakdown** (Active, Faulty, Inactive)
  And More...!!
---

## 👤 About Me

Hi, I'm **Jitu Kumar**, an aspiring Data Analyst with a passion for solving real-world problems using data and visualization tools.

* 🔭 Skilled in SQL, Power BI, Python
* 📊 Passionate about creating meaningful dashboards
* 🌐 [LinkedIn](https://www.linkedin.com/in/jicsjitu) | [Medium](https://medium.com/@jicsjitu))

---

## 🤝 Support & Feedback

Have feedback or want to collaborate?

* 📬 Email: [jitukumar9387@gmail.com](mailto:jitukumar9387@gmail.com)
* 🗨️ DM on [LinkedIn](https://www.linkedin.com/in/jicsjitu)

If you found this helpful, please ⭐️ this repository and share it with others!

---

> “The goal is to turn data into information, and information into insight.”
---
