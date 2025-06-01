-- ===================================================================
-- MeterMind - Smart Energy Analytics for Ranchi (MySQL)
-- Author: Jitu Kumar
-- Date: 2025-05-31
-- Description: SQL-driven analysis for meter readings and billing analytics
-- ===================================================================

-- ============================ PHASE 1: Database Creation and Table Setup Script (MySQL Version) =============================

/* 
Script Purpose:
    This script creates a new MySQL database named ' meter_readings_ranchi'. 
    If the database already exists, it is dropped to ensure a clean setup. 
    The script then create one table: ' meter_readings'
    with their respective schemas, and populates them with sample data.
    
WARNING:
    Running this script will drop the entire 'meter_readings_ranchi' database if it exists, 
    permanently deleting all data within it. Proceed with caution and ensure you 
    have proper backups before executing this script.
*/

-- Create the main project database
DROP DATABASE IF EXISTS meter_readings_ranchi;
CREATE DATABASE IF NOT EXISTS meter_readings_ranchi;
USE meter_readings_ranchi;

-- Create the master table for meter readings
CREATE TABLE IF NOT EXISTS meter_readings (
    customer_id VARCHAR(20),
    meter_id VARCHAR(20),
    reading_date DATE,
    energy_consumed FLOAT,
    location VARCHAR(50),
    billing_amount FLOAT,
    meter_status VARCHAR(20),
    reading_type VARCHAR(20),
    customer_type VARCHAR(20),
    tariff_plan VARCHAR(20),
    previous_reading FLOAT,
    reading_time VARCHAR(5),
    communication_status VARCHAR(20),
    meter_install_date DATE,
    meter_make VARCHAR(50),
    fault_code VARCHAR(10),
    invoice_generated VARCHAR(3)
);

-- Load data into the table
-- Note: Ensure LOCAL_INFILE is enabled in MySQL and file path is accessible
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/meter_readings_ranchi.csv'
INTO TABLE meter_readings
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Preview loaded data
SELECT * FROM meter_readings LIMIT 10;


-- ======================= STEP 1: INITIAL DATA EXPLORATION ========================

-- 1. Total records
SELECT COUNT(*) AS total_rows FROM meter_readings;

-- 2. Distinct values
SELECT DISTINCT meter_status FROM meter_readings;
SELECT DISTINCT customer_type FROM meter_readings;
SELECT DISTINCT tariff_plan FROM meter_readings;


-- ======================= STEP 2: DATA QUALITY CHECKS ============================

-- Null check for reading date
SELECT COUNT(*) AS missing_reading_date
FROM meter_readings
WHERE reading_date IS NULL;

-- Invalid energy values
SELECT * FROM meter_readings
WHERE energy_consumed < 0;

-- Billing mismatch (arbitrary threshold: < ₹5/unit)
SELECT * FROM meter_readings
WHERE billing_amount < energy_consumed * 5;


-- ======================= STEP 3: HIGH-LEVEL KPIs ================================

-- Total energy consumed and revenue
SELECT 
  ROUND(SUM(energy_consumed), 2) AS total_units_consumed,
  ROUND(SUM(billing_amount), 2) AS total_revenue
FROM meter_readings;

-- Average per customer
SELECT 
  ROUND(AVG(energy_consumed), 2) AS avg_units,
  ROUND(AVG(billing_amount), 2) AS avg_bill
FROM meter_readings;


-- ====================== STEP 4: TIME SERIES ANALYSIS ============================

-- Monthly energy usage trend
SELECT 
  MONTH(reading_date) AS month,
  ROUND(SUM(energy_consumed), 2) AS monthly_units
FROM meter_readings
GROUP BY MONTH(reading_date)
ORDER BY month;

-- Daily reading count
SELECT reading_date, COUNT(*) AS readings_taken
FROM meter_readings
GROUP BY reading_date
ORDER BY reading_date;


-- ==================== STEP 5: GEOGRAPHICAL INSIGHTS =============================

-- Energy usage by location
SELECT 
  location,
  ROUND(SUM(energy_consumed), 2) AS total_consumed
FROM meter_readings
GROUP BY location
ORDER BY total_consumed DESC;

-- Billing by customer type & location
SELECT 
  location,
  customer_type,
  ROUND(AVG(billing_amount), 2) AS avg_billing
FROM meter_readings
GROUP BY location, customer_type;


-- ====================== STEP 6: OPERATIONAL ISSUES ===============================

-- Faulty or tampered meters
SELECT * FROM meter_readings
WHERE meter_status IN ('faulty', 'tampered');

-- Communication status summary
SELECT communication_status, COUNT(*) AS count
FROM meter_readings
GROUP BY communication_status;

-- Repeated faults per meter
SELECT meter_id, COUNT(*) AS fault_count
FROM meter_readings
WHERE meter_status = 'faulty'
GROUP BY meter_id
HAVING fault_count > 1;


-- =================== STEP 7: CUSTOMER SEGMENT ANALYSIS ===========================

-- Consumption by customer type
SELECT 
  customer_type,
  ROUND(AVG(energy_consumed), 2) AS avg_units,
  ROUND(AVG(billing_amount), 2) AS avg_bill
FROM meter_readings
GROUP BY customer_type;

-- Top 10 high-usage residential customers
SELECT *
FROM meter_readings
WHERE customer_type = 'residential'
ORDER BY energy_consumed DESC
LIMIT 10;


-- =================== STEP 8: TARIFF PLAN ANALYSIS ================================

-- Tariff-wise summary
SELECT 
  tariff_plan,
  COUNT(*) AS readings_count,
  ROUND(SUM(energy_consumed), 2) AS total_units,
  ROUND(SUM(billing_amount), 2) AS total_billed
FROM meter_readings
GROUP BY tariff_plan;


-- =================== STEP 9: METER & DEVICE ANALYSIS ============================

-- Top 5 meter manufacturers
SELECT meter_make, COUNT(*) AS count
FROM meter_readings
GROUP BY meter_make
ORDER BY count DESC
LIMIT 5;

-- Meters older than 5 years (as of 2025-05-30)
SELECT * FROM meter_readings
WHERE meter_install_date < '2020-05-30';


-- =================== STEP 10: ADVANCED INSIGHTS ================================

-- Billing inconsistencies
SELECT customer_id,
       AVG(billing_amount) AS avg_bill,
       MAX(billing_amount) AS max_bill,
       MIN(billing_amount) AS min_bill
FROM meter_readings
GROUP BY customer_id
HAVING MAX(billing_amount) > 1.5 * AVG(billing_amount);

-- Top 10 revenue-generating locations
SELECT location,
       ROUND(SUM(billing_amount), 2) AS total_revenue
FROM meter_readings
GROUP BY location
ORDER BY total_revenue DESC
LIMIT 10;

-- Reading time distribution
SELECT reading_time, COUNT(*) AS count
FROM meter_readings
GROUP BY reading_time
ORDER BY count DESC;

-- Tariff effectiveness by customer type
SELECT customer_type, tariff_plan,
       ROUND(SUM(billing_amount), 2) AS total_revenue
FROM meter_readings
GROUP BY customer_type, tariff_plan
ORDER BY customer_type, total_revenue DESC;

-- Inactive customers (no activity since 3 months)
SELECT customer_id
FROM meter_readings
GROUP BY customer_id
HAVING MAX(reading_date) < '2025-03-01';

-- Reading time vs avg energy usage
SELECT reading_time,
       ROUND(AVG(energy_consumed), 2) AS avg_consumption
FROM meter_readings
GROUP BY reading_time
ORDER BY avg_consumption DESC;

-- Customer Lifetime Value (CLV)
SELECT customer_id,
       COUNT(*) AS total_readings,
       ROUND(SUM(billing_amount), 2) AS total_revenue
FROM meter_readings
GROUP BY customer_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Energy efficiency (unit consumed per ₹1 billed)
SELECT customer_id,
       ROUND(SUM(energy_consumed) / SUM(billing_amount), 2) AS energy_per_rupee
FROM meter_readings
GROUP BY customer_id
ORDER BY energy_per_rupee;