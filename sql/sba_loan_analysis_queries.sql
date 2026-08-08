/* ==============================================================
   Final Project: Exploring SBA Loan Data
   Table: public.sba_team2
   Purpose: SBA loan analysis queries for stakeholder reports
   ============================================================== */

/* 1. Preview the data */
SELECT *
FROM public.sba_team2
LIMIT 10;

/* 2. Check total number of records */
SELECT
    COUNT(*) AS total_records
FROM public.sba_team2;

/* 3. Total loan amount for each SBA District Office */
SELECT
    TRIM("SBADistrictOffice") AS sba_district_office,
    COUNT(*) AS total_loans,
    SUM("GrossApprovalAmount") AS total_loan_amount,
    AVG("GrossApprovalAmount") AS average_loan_amount
FROM public.sba_team2
GROUP BY TRIM("SBADistrictOffice")
ORDER BY total_loan_amount DESC;

/* 4. Top 5 banks with the highest gross approval amount */
SELECT
    TRIM("BankName") AS bank_name,
    COUNT(*) AS total_loans,
    SUM("GrossApprovalAmount") AS total_gross_approval_amount,
    AVG("GrossApprovalAmount") AS average_loan_amount
FROM public.sba_team2
WHERE "BankName" IS NOT NULL
  AND TRIM("BankName") <> ''
GROUP BY TRIM("BankName")
ORDER BY total_gross_approval_amount DESC
LIMIT 5;

/* 5. Top 10 franchises with the most approved loans */
SELECT
    TRIM("FranchiseName") AS franchise_name,
    COUNT(*) AS total_approved_loans,
    SUM("GrossApprovalAmount") AS total_gross_approval_amount
FROM public.sba_team2
WHERE "FranchiseName" IS NOT NULL
  AND TRIM("FranchiseName") <> ''
  AND UPPER(TRIM("FranchiseName")) <> 'UNKNOWN'
GROUP BY TRIM("FranchiseName")
ORDER BY total_approved_loans DESC
LIMIT 10;

/* 6. Total gross approval amount by fiscal year and program */
SELECT
    "ApprovalFiscalYear" AS approval_fiscal_year,
    TRIM("Program") AS program,
    COUNT(*) AS total_loans,
    SUM("GrossApprovalAmount") AS total_gross_approval_amount,
    AVG("GrossApprovalAmount") AS average_loan_amount
FROM public.sba_team2
GROUP BY
    "ApprovalFiscalYear",
    TRIM("Program")
ORDER BY
    approval_fiscal_year,
    total_gross_approval_amount DESC;

/* 7. Payment status breakdown: Paid In Full vs Not Paid */
SELECT
    CASE
        WHEN UPPER(TRIM("LoanStatus")) = 'PIF' THEN 'Paid In Full'
        ELSE 'Not Paid'
    END AS payment_status,
    COUNT(*) AS loan_count,
    SUM("GrossApprovalAmount") AS total_gross_approval_amount,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS loan_percentage
FROM public.sba_team2
GROUP BY
    CASE
        WHEN UPPER(TRIM("LoanStatus")) = 'PIF' THEN 'Paid In Full'
        ELSE 'Not Paid'
    END;

/* 8. Loan status breakdown by program */
SELECT
    TRIM("Program") AS program,
    TRIM("LoanStatus") AS loan_status,
    COUNT(*) AS loan_count,
    SUM("GrossApprovalAmount") AS total_gross_approval_amount,
    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (PARTITION BY TRIM("Program")),
        2
    ) AS status_percentage_within_program
FROM public.sba_team2
GROUP BY
    TRIM("Program"),
    TRIM("LoanStatus")
ORDER BY
    program,
    loan_count DESC;

/* 9. Yearly loan trend */
SELECT
    "ApprovalFiscalYear" AS approval_fiscal_year,
    COUNT(*) AS total_loans,
    SUM("GrossApprovalAmount") AS total_gross_approval_amount,
    AVG("GrossApprovalAmount") AS average_loan_amount
FROM public.sba_team2
GROUP BY "ApprovalFiscalYear"
ORDER BY approval_fiscal_year;

/* 10. Top 10 SBA District Offices by number of loans */
SELECT
    TRIM("SBADistrictOffice") AS sba_district_office,
    COUNT(*) AS total_loans,
    SUM("GrossApprovalAmount") AS total_gross_approval_amount,
    AVG("GrossApprovalAmount") AS average_loan_amount
FROM public.sba_team2
GROUP BY TRIM("SBADistrictOffice")
ORDER BY total_loans DESC
LIMIT 10;

/* 11. Top 10 states by total gross approval amount */
SELECT
    TRIM("BorrState") AS borrower_state,
    COUNT(*) AS total_loans,
    SUM("GrossApprovalAmount") AS total_gross_approval_amount,
    AVG("GrossApprovalAmount") AS average_loan_amount
FROM public.sba_team2
WHERE "BorrState" IS NOT NULL
  AND TRIM("BorrState") <> ''
GROUP BY TRIM("BorrState")
ORDER BY total_gross_approval_amount DESC
LIMIT 10;

/* 12. Paid In Full loans by fiscal year */
SELECT
    "ApprovalFiscalYear" AS approval_fiscal_year,
    COUNT(*) AS paid_in_full_loans,
    SUM("GrossApprovalAmount") AS paid_in_full_amount
FROM public.sba_team2
WHERE UPPER(TRIM("LoanStatus")) = 'PIF'
GROUP BY "ApprovalFiscalYear"
ORDER BY approval_fiscal_year;

/* 13. Charged-off loans by fiscal year */
SELECT
    "ApprovalFiscalYear" AS approval_fiscal_year,
    COUNT(*) AS charged_off_loans,
    SUM("GrossApprovalAmount") AS charged_off_amount
FROM public.sba_team2
WHERE UPPER(TRIM("LoanStatus")) = 'CHGOFF'
GROUP BY "ApprovalFiscalYear"
ORDER BY approval_fiscal_year;

/* 14. Top 10 industries by total loan amount */
SELECT
    TRIM("NaicsDescription") AS industry,
    COUNT(*) AS total_loans,
    SUM("GrossApprovalAmount") AS total_gross_approval_amount,
    AVG("GrossApprovalAmount") AS average_loan_amount
FROM public.sba_team2
WHERE "NaicsDescription" IS NOT NULL
  AND TRIM("NaicsDescription") <> ''
GROUP BY TRIM("NaicsDescription")
ORDER BY total_gross_approval_amount DESC
LIMIT 10;

/* 15. Tableau-ready cleaned report */
SELECT
    TRIM("SBADistrictOffice") AS sba_district_office,
    TRIM("BankName") AS bank_name,
    TRIM("FranchiseName") AS franchise_name,
    "ApprovalFiscalYear" AS approval_fiscal_year,
    TRIM("Program") AS program,
    TRIM("LoanStatus") AS loan_status,
    "GrossApprovalAmount" AS gross_approval_amount,
    "PaidInFullDate" AS paid_in_full_date,
    TRIM("BorrState") AS borrower_state,
    TRIM("NaicsDescription") AS industry,
    CASE
        WHEN UPPER(TRIM("LoanStatus")) = 'PIF' THEN 'Paid In Full'
        ELSE 'Not Paid'
    END AS payment_status_group
FROM public.sba_team2;
