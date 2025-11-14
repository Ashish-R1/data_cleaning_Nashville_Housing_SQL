# **Nashville Housing Data Cleaning Project – SQL**

## Project Overview

This project focuses on cleaning a real-world housing dataset from Nashville, Tennessee, using SQL.
Raw housing data often contains inconsistencies, missing values, duplicate records, and formatting issues.
Effective data cleaning is essential for building accurate dashboards, performing analysis, and supporting data-driven decisions in real estate.

This project demonstrates strong SQL skills, including data transformation, standardization, deduplication, and feature extraction.

## Project Objectives

- Improve data quality to enable accurate housing analysis
- Apply SQL techniques to transform, clean, and structure raw data
- Prepare dataset for downstream analytics or visualization tools (Power BI, Tableau, Python)

## SQL Skills Demonstrated

This project covers end-to-end data cleaning:

### 1. Standardizing Date Formats

- Converted inconsistent date strings to proper SQL DATE format.
- Ensured uniformity for time-series reporting.

### 2. Populating Missing Property Addresses

- Filled missing address fields using JOIN logic based on matching ParcelID.
- Ensured no property-level fields were left null.

### 3. Breaking Out Address Components

- Used SUBSTRING, CHARINDEX, and PARSENAME to extract:
    - Street Address
    - City
    - State
    This improves usability in reporting tools and geospatial analyses.

### 4. Standardizing Categorical Fields

- Cleaned inconsistent values in SoldAsVacant (e.g., Y, N, Yes, No).
- Converted them into uniform categories (Yes / No).

### 5. Removing Duplicates

- Identified duplicates using window functions (ROW_NUMBER()).
- Created a CTE to isolate duplicates.
- Removed duplicate rows based on:
    - ParcelID
    - PropertyAddress
    - SalePrice
    - SaleDate
    - LegalReference

### 6. Dropping Unnecessary Columns

- Removed irrelevant or redundant fields after extraction.
- Ensured the final dataset is clean, lean, and ready for analytics.

## Why This Project Matters
This project simulates a realistic data engineering and analytics workflow:

- Raw enterprise datasets are often messy
- SQL is the backbone of data preparation in real companies
- Clean, structured data powers meaningful dashboards and models
