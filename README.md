# Exploring SBA Loan Data — Team 2

End-to-end data analytics project: cleaning, mapping, ETL, SQL analysis, and Tableau visualization of real U.S. Small Business Administration (SBA) 7(a)/504 loan data.

## Objective

Analyze SBA loan data to surface insights on total loan volume, top-performing banks and franchises, yearly program trends, and payment status — delivered as stakeholder-ready reports and an interactive Tableau dashboard.

## Dataset

**Source:** U.S. Small Business Administration — [7(a) & 504 FOIA loan data](https://www.sba.gov/about-sba/open-government/foia/frequently-requested-records/sba-7a-504-loan-data), real public lending records (FY2020–present, as of 6/30/2024).

**Scale:** ~249,000 loan records, 38 columns after cleaning/mapping.

## Pipeline

1. **Data Cleaning (Excel)** — removed irrelevant/missing records, standardized formatting.
2. **Data Mapping** — defined technical-to-business name mappings and data types (see `docs/SBA_team2__Data_Mapping_Document.xlsx` and `docs/7a_504_foia_data_dictionary.xlsx`).
3. **ETL (SSIS)** — imported cleaned data into a SQL Server / Postgres reporting table via an SSIS package (Flat File Source → Data Conversion → OLE DB Destination). See `screenshots/ssis.png`.
4. **SQL Analysis** — 15 analytical queries covering loan volume by district office, top banks/franchises, yearly trends by program, and payment status breakdown. See `sql/sba_loan_analysis_queries.sql`.
5. **Reporting** — query outputs exported as flat files for stakeholder distribution.
6. **Visualization (Tableau)** — interactive dashboard built from the cleaned dataset. See `tableau/sba.twb`.

## Repo structure

```
data/       Cleaned, mapped loan dataset (CSV, ~249K rows)
sql/        SQL analysis queries (15 stakeholder-facing queries)
tableau/    Tableau workbook (.twb)
docs/       Project brief, data dictionary, data mapping document
screenshots/ SSIS package design, SQL query screenshots, mapping docs
```

## Key fields

`Business_Name`, `Bank_Name`, `Gross_Approval_Amount`, `SBA_Guaranteed_Approval_Amount`, `Approval_Fiscal_Year`, `Program`, `Loan_Status`, `Paid_in_Full_Date`, `NAICS_Description`, `SBA_District_Office`, `Business_State` — full field list in the data dictionary.

## Tools

Excel · SQL (PostgreSQL) · SSIS · Tableau
