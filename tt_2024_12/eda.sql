-- first look at the table
SELECT
	*
FROM
	mutant_moneyball;
  -- names of characters need working - first and last names separated, first letter of first names capitalised

-- data types
DESCRIBE
	mutant_moneyball;

-- data validation - adding check columns to ensure the values for each mutant add up
WITH with_check AS (
	SELECT
		`Member` AS `member`,
        TotalIssues AS total_issues,
        TotalIssues60s AS total_issues_60s,
        TotalIssues70s AS total_issues_70s,
        TotalIssues80s AS total_issues_80s,
        TotalIssues90s AS total_issues_90s,
        totalIssueCheck AS total_issues_check,
        TotalValue_heritage AS total_value_heritage,
        TotalValue60s_heritage AS total_value60s_heritage,
        TotalValue70s_heritage AS total_value70s_heritage,
        TotalValue80s_heritage AS total_value80s_heritage,
        TotalValue70s_heritage AS total_value90s_heritage,
        TotalValue60s_heritage + TotalValue70s_heritage + TotalValue80s_heritage + TotalValue90s_heritage AS total_value_heritage_check,
        TotalValue_ebay AS total_value_ebay,
        TotalValue60s_ebay AS total_value60s_ebay,
        TotalValue70s_ebay AS total_value70s_ebay,
        TotalValue80s_ebay AS total_value80s_ebay,
        TotalValue70s_ebay AS total_value90s_ebay,
        TotalValue60s_ebay + TotalValue70s_ebay + TotalValue80s_ebay + TotalValue90s_ebay AS total_value_ebay_check
	FROM
		mutant_moneyball
	)

SELECT
	`member`
FROM
	with_check
WHERE
	total_issues_check <> total_issues OR
    total_value_heritage_check <> total_value_heritage OR
    total_value_ebay_check <> total_value_ebay;
  -- result came back as NULL

