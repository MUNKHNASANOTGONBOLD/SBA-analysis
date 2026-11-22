# Exploring SBA Loan Data: Team 2

My team analyzed about 249,000 public SBA loan records to compare approvals across lenders, districts, industries, and fiscal years.

## Dataset

**Source:** U.S. Small Business Administration: [7(a) & 504 FOIA loan data](https://www.sba.gov/about-sba/open-government/foia/frequently-requested-records/sba-7a-504-loan-data), real public lending records (FY2020–present, as of 6/30/2024).

**Scale:** ~249,000 loan records, 38 columns after cleaning/mapping.

## Pipeline

1. **Data Cleaning (Excel)**: removed irrelevant/missing records, standardized formatting.
2. **Data Mapping**: defined technical-to-business name mappings and data types (see `SBA_Data_Mapping_Document.xlsx` and `docs/7a_504_foia_data_dictionary.xlsx`).
3. **ETL (SSIS)**: imported cleaned data into a SQL Server / Postgres reporting table via an SSIS package (Flat File Source → Data Conversion → OLE DB Destination).
4. **SQL Analysis**: 15 analytical queries covering loan volume by district office, top banks/franchises, yearly trends by program, and payment status breakdown. See `sql/sba_loan_analysis_queries.sql`.
5. **Reporting**: query outputs exported as flat files for stakeholder distribution.
6. **Visualization (Tableau)**: interactive dashboard built from the cleaned dataset.

## Files

- [Reporting queries](sql/sba_loan_analysis_queries.sql)
- [Mapping workbook](SBA_Data_Mapping_Document.xlsx)
- [Source data dictionary](docs/7a_504_foia_data_dictionary.xlsx)

## Key fields

`Business_Name`, `Bank_Name`, `Gross_Approval_Amount`, `SBA_Guaranteed_Approval_Amount`, `Approval_Fiscal_Year`, `Program`, `Loan_Status`, `Paid_in_Full_Date`, `NAICS_Description`, `SBA_District_Office`, `Business_State`: full field list in the data dictionary.

## Tools

Excel · SQL (PostgreSQL) · SSIS · Tableau
