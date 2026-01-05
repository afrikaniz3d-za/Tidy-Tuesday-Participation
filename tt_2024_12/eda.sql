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

-- Cleaned table: Full   
CREATE TABLE named (
	`Member` VARCHAR(50),
    full_name VARCHAR(50),
    alias_name VARCHAR(50)
);

INSERT INTO named VALUES
	('warrenWorthington', "Warren Worthington", 'Angel'),
    ('hankMcCoy', "Hank McCoy", 'Beast'),
    ('scottSummers', "Scott Summers", 'Cyclops'),
    ('bobbyDrake', "Bobby Drake", 'Iceman'),
    ('jeanGrey', "Jean Grey", 'Phoenix'),
    ('alexSummers', "Alex Summers", 'Havok'),
    ('lornaDane', "Lorna Dane", 'Polaris'),
    ('ororoMunroe', "Ororo Munroe", 'Storm'),
    ('kurtWagner', "Kurt Wagner", 'Nightcrawler'),
    ('loganHowlett', "Logan Howlett", 'Wolverine'),
    ('peterRasputin', "Peter Rasputin", 'Colossus'),
    ('seanCassidy', "Sean Cassidy", 'Banshee'),
    ('shiroYoshida', "Shiro Yoshida", 'Sunfire'),
    ('johnProudstar', "John Proudstar", 'Thunderbird'),
    ('kittyPryde', "Kitty Pryde", 'Shadowcat'),
    ('annaMarieLeBeau', "Anna-Marie LeBeau", 'Rogue'),
    ('rachelSummers', "Rachel Summers", 'Askani'),
    ('ericMagnus', "Eric Magnus", 'Magneto'),
    ('alisonBlaire', "Alison Blaire", 'Dazzler'),
    ('longshot', "Arthur Centino", 'Longshot'),
    ('jonathanSilvercloud', "Jonathan Silvercloud", 'Forge'),
    ('remyLeBeau', "Remy LeBeau", 'Gambit'),
    ('jubilationLee', "Jubilation Lee", 'Jubilee'),
    ('lucasBishop', "Lucas Bishop", 'Bishop'),
    ('betsyBraddock', "Betsy Braddock", 'Psylocke'),
    ('charlesXavier', "Charles Xavier", 'Professor-X'); 

SELECT
	full_name,
    alias_name,
    TotalIssues AS total_issues,
	TotalIssues60s AS total_issues_60s,
	TotalIssues70s AS total_issues_70s,
	TotalIssues80s AS total_issues_80s,
	TotalIssues90s AS total_issues_90s,
    ROUND(CAST(REPLACE(60s_Appearance_Percent, '%', '') AS DECIMAL (10,2)), 2) AS 60s_appearance_perc,
    ROUND(CAST(REPLACE(70s_Appearance_Percent, '%', '') AS DECIMAL (10,2)), 2) AS 70s_appearance_perc,
    ROUND(CAST(REPLACE(80s_Appearance_Percent, '%', '') AS DECIMAL (10,2)), 2) AS 80s_appearance_perc,
    ROUND(CAST(REPLACE(90s_Appearance_Percent, '%', '') AS DECIMAL (10,2)), 2) AS 90s_appearance_perc,
    
    ROUND(CAST(TotalValue_heritage AS DECIMAL (10,2)) / 100, 2) AS total_value_heritage,
    ROUND(CAST(TotalValue60s_heritage AS DECIMAL (10,2)) / 100, 2) AS total_value60s_heritage,
    ROUND(CAST(TotalValue70s_heritage AS DECIMAL (10,2)) / 100, 2) AS total_value70s_heritage,
    ROUND(CAST(TotalValue80s_heritage AS DECIMAL (10,2)) / 100, 2) AS total_value80s_heritage,
    ROUND(CAST(TotalValue90s_heritage AS DECIMAL (10,2)) / 100, 2) AS total_value90s_heritage,
    ROUND(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi60s_heritage,
    ROUND(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi70s_heritage,
    ROUND(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi80s_heritage,
    ROUND(CAST(REPLACE(REPLACE(PPI90s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi90s_heritage,
    
    ROUND(CAST(TotalValue_ebay AS DECIMAL (10,2)) / 100, 2) AS total_value_ebay,
    ROUND(CAST(TotalValue60s_ebay AS DECIMAL (10,2)) / 100, 2) AS total_value60s_ebay,
    ROUND(CAST(TotalValue70s_ebay AS DECIMAL (10,2)) / 100, 2) AS total_value70s_ebay,
    ROUND(CAST(TotalValue80s_ebay AS DECIMAL (10,2)) / 100, 2) AS total_value80s_ebay,
    ROUND(CAST(TotalValue90s_ebay AS DECIMAL (10,2)) / 100, 2) AS total_value90s_ebay,
    ROUND(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi60s_ebay,
    ROUND(CAST(REPLACE(REPLACE(PPI70s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi70s_ebay,
    ROUND(CAST(REPLACE(REPLACE(PPI80s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi80s_ebay,
    ROUND(CAST(REPLACE(REPLACE(PPI90s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi90s_ebay,
    
    ROUND(CAST(REPLACE(TotalValue60s_wiz, '$', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(TotalValue70s_wiz, '$', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS total_value_wizard,
    ROUND(CAST(REPLACE(TotalValue60s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS total_value60s_wizard,
    ROUND(CAST(REPLACE(TotalValue70s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS total_value70s_wizard,
    ROUND(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS total_value80s_wizard,
    ROUND(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS total_value90s_wizard,
    ROUND(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS ppi60s_wizard,
    ROUND(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS ppi70s_wizard,
    ROUND(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS ppi80s_wizard,
    ROUND(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS ppi90s_wizard,
    
    ROUND(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(REPLACE(TotalValue90s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS total_value_ostreet,
    ROUND(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS total_value60s_ostreet,
    ROUND(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS total_value70s_ostreet,
    ROUND(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS total_value80s_ostreet,
    ROUND(CAST(REPLACE(REPLACE(TotalValue90s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS total_value90s_ostreet,
	ROUND(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi60s_ostreet,
    ROUND(CAST(REPLACE(REPLACE(PPI70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi70s_ostreet,
    ROUND(CAST(REPLACE(REPLACE(PPI80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi80s_ostreet,
    ROUND(CAST(REPLACE(REPLACE(PPI90s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi90s_ostreet
FROM
	mutant_moneyball
LEFT JOIN
	named
ON
	mutant_moneyball.`Member` = named.`Member`;

-- TotalIssues descriptive stats: totals, min, max, avg
SELECT
	SUM(TotalIssues) AS sum_total_issues,
    MIN(TotalIssues) AS min_total_issues,
    MAX(TotalIssues) AS max_total_issues,
    
    ROUND(AVG(TotalIssues), 0) AS avg_total_issues,
	SUM(TotalIssues60s) AS sum_total_issues60s,
    MIN(TotalIssues60s) AS min_total_issues60s,
    MAX(TotalIssues60s) AS max_total_issues60s,
    ROUND(AVG(TotalIssues60s), 0) AS avg_total_issues60s,
	SUM(TotalIssues70s) AS sum_total_issues70s,
    MIN(TotalIssues70s) AS min_total_issues70s,
    MAX(TotalIssues70s) AS max_total_issues70s,
    ROUND(AVG(TotalIssues70s), 0) AS avg_total_issues70s,
	SUM(TotalIssues80s) AS sum_total_issues80s,
    MIN(TotalIssues80s) AS min_total_issues80s,
    MAX(TotalIssues80s) AS max_total_issues80s,
    ROUND(AVG(TotalIssues80s), 0) AS avg_total_issues80s,
	SUM(TotalIssues90s) AS sum_total_issues90s,
    MIN(TotalIssues90s) AS min_total_issues90s,
    MAX(TotalIssues90s) AS max_total_issues90s,
    ROUND(AVG(TotalIssues90s), 0) AS avg_total_issues90s
FROM 
	mutant_moneyball;
    
-- TotalValue_heritage descriptive stats: totals, min, max, avg
-- Chose to to take the last 2 digits in each value as cents rather than whole numbers because the values then match brackets of other outlets 
SELECT
	ROUND(SUM(CAST(TotalValue_heritage AS DECIMAL (10,2))) / 100, 2) AS sum_total_value_heritage,
    ROUND(MIN(CAST(TotalValue_heritage AS DECIMAL (10,2))) / 100, 2) AS min_total_value_heritage,
    ROuND(MAX(CAST(TotalValue_heritage AS DECIMAL (10,2))) / 100, 2) AS max_total_value_heritage,
    ROUND(AVG(CAST(TotalValue_heritage AS DECIMAL (10,2))) / 100, 2) AS avg_total_value_heritage,
    
    ROUND(SUM(CAST(TotalValue60s_heritage AS DECIMAL (10,2))) / 100, 2) AS sum_total_value60s_heritage,
    ROUND(MIN(CAST(TotalValue60s_heritage AS DECIMAL (10,2))) / 100, 2) AS min_total_value60s_heritage,
    ROUND(MAX(CAST(TotalValue60s_heritage AS DECIMAL (10,2))) / 100, 2) AS max_total_value60s_heritage,
    ROUND(AVG(CAST(TotalValue60s_heritage AS DECIMAL (10,2))) / 100, 2) AS avg_total_value60s_heritage,
    
    ROUND(SUM(CAST(TotalValue70s_heritage AS DECIMAL (10,2))) / 100, 2) AS sum_total_value70s_heritage,
    ROUND(MIN(CAST(TotalValue70s_heritage AS DECIMAL (10,2))) / 100, 2) AS min_total_value70s_heritage,
    ROUND(MAX(CAST(TotalValue70s_heritage AS DECIMAL (10,2))) / 100, 2) AS max_total_value70s_heritage,
    ROUND(AVG(CAST(TotalValue70s_heritage AS DECIMAL (10,2))) / 100, 2) AS avg_total_value70s_heritage,
    
    ROUND(SUM(CAST(TotalValue80s_heritage AS DECIMAL (10,2))) / 100, 2) AS sum_total_value80s_heritage,
    ROUND(MIN(CAST(TotalValue80s_heritage AS DECIMAL (10,2))) / 100, 2) AS min_total_value80s_heritage,
    ROUND(MAX(CAST(TotalValue80s_heritage AS DECIMAL (10,2))) / 100, 2) AS max_total_value80s_heritage,
    ROUND(AVG(CAST(TotalValue80s_heritage AS DECIMAL (10,2))) / 100, 2) AS avg_total_value80s_heritage,
    
    ROUND(SUM(CAST(TotalValue90s_heritage AS DECIMAL (10,2))) / 100, 2) AS sum_total_value90s_heritage,
    ROUND(MIN(CAST(TotalValue90s_heritage AS DECIMAL (10,2))) / 100, 2) AS min_total_value90s_heritage,
    ROUND(MAX(CAST(TotalValue90s_heritage AS DECIMAL (10,2))) / 100, 2) AS max_total_value90s_heritage,
    ROUND(AVG(CAST(TotalValue90s_heritage AS DECIMAL (10,2))) / 100, 2) AS avg_total_value90s_heritage
FROM 
	mutant_moneyball;
    
-- TotalValue_ebay descriptive stats: totals, min, max, avg
SELECT
	ROUND(SUM(CAST(TotalValue_ebay AS DECIMAL (10,2))) / 100, 2) AS sum_total_value_ebay,
    ROUND(MIN(CAST(TotalValue_ebay AS DECIMAL (10,2))) / 100, 2) AS min_total_value_ebay,
    ROuND(MAX(CAST(TotalValue_ebay AS DECIMAL (10,2))) / 100, 2) AS max_total_value_ebay,
    ROUND(AVG(CAST(TotalValue_ebay AS DECIMAL (10,2))) / 100, 2) AS avg_total_value_ebay,
    
    ROUND(SUM(CAST(TotalValue60s_ebay AS DECIMAL (10,2))) / 100, 2) AS sum_total_value60s_ebay,
    ROUND(MIN(CAST(TotalValue60s_ebay AS DECIMAL (10,2))) / 100, 2) AS min_total_value60s_ebay,
    ROUND(MAX(CAST(TotalValue60s_ebay AS DECIMAL (10,2))) / 100, 2) AS max_total_value60s_ebay,
    ROUND(AVG(CAST(TotalValue60s_ebay AS DECIMAL (10,2))) / 100, 2) AS avg_total_value60s_ebay,
    
    ROUND(SUM(CAST(TotalValue70s_ebay AS DECIMAL (10,2))) / 100, 2) AS sum_total_value70s_ebay,
    ROUND(MIN(CAST(TotalValue70s_ebay AS DECIMAL (10,2))) / 100, 2) AS min_total_value70s_ebay,
    ROUND(MAX(CAST(TotalValue70s_ebay AS DECIMAL (10,2))) / 100, 2) AS max_total_value70s_ebay,
    ROUND(AVG(CAST(TotalValue70s_ebay AS DECIMAL (10,2))) / 100, 2) AS avg_total_value70s_ebay,
    
    ROUND(SUM(CAST(TotalValue80s_ebay AS DECIMAL (10,2))) / 100, 2) AS sum_total_value80s_ebay,
    ROUND(MIN(CAST(TotalValue80s_ebay AS DECIMAL (10,2))) / 100, 2) AS min_total_value80s_ebay,
    ROUND(MAX(CAST(TotalValue80s_ebay AS DECIMAL (10,2))) / 100, 2) AS max_total_value80s_ebay,
    ROUND(AVG(CAST(TotalValue80s_ebay AS DECIMAL (10,2))) / 100, 2) AS avg_total_value80s_ebay,
    
    ROUND(SUM(CAST(TotalValue90s_ebay AS DECIMAL (10,2))) / 100, 2) AS sum_total_value90s_ebay,
    ROUND(MIN(CAST(TotalValue90s_ebay AS DECIMAL (10,2))) / 100, 2) AS min_total_value90s_ebay,
    ROUND(MAX(CAST(TotalValue90s_ebay AS DECIMAL (10,2))) / 100, 2) AS max_total_value90s_ebay,
    ROUND(AVG(CAST(TotalValue90s_ebay AS DECIMAL (10,2))) / 100, 2) AS avg_total_value90s_ebay
FROM 
	mutant_moneyball;
    
-- Appearance Percentages descriptive stats: min, max, avg
SELECT
	ROUND(MIN(CAST(REPLACE(60s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS min_60s_appearance_perc,
    ROUND(MAX(CAST(REPLACE(60s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS max_60s_appearance_perc,
    ROUND(AVG(CAST(REPLACE(60s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS avg_60s_appearance_perc,
    
	ROUND(MIN(CAST(REPLACE(70s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS min_70s_appearance_perc,
    ROUND(MAX(CAST(REPLACE(70s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS max_70s_appearance_perc,
    ROUND(AVG(CAST(REPLACE(70s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS avg_70s_appearance_perc,
    
	ROUND(MIN(CAST(REPLACE(80s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS min_80s_appearance_perc,
    ROUND(MAX(CAST(REPLACE(80s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS max_80s_appearance_perc,
    ROUND(AVG(CAST(REPLACE(80s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS avg_80s_appearance_perc,
    
	ROUND(MIN(CAST(REPLACE(90s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS min_90s_appearance_perc,
    ROUND(MAX(CAST(REPLACE(90s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS max_90s_appearance_perc,
    ROUND(AVG(CAST(REPLACE(90s_Appearance_Percent, '%', '') AS DECIMAL (10,2))), 2) AS avg_90s_appearance_perc
FROM 
	mutant_moneyball;
-- this needed more wrangling to get these to be proper numeric because the 90s figures were coming out wrong, namely the avg was higher than the max..
    
-- PPI_heritage descriptive stats: min, max, avg
SELECT
    ROUND(SUM(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi60s_heritage, 
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi60s_heritage, 
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi60s_heritage,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi60s_heritage,
    
	ROUND(SUM(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi70s_heritage,
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi70s_heritage, 
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi70s_heritage,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi70s_heritage,
    
    ROUND(SUM(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi80s_heritage,
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi80s_heritage, 
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi80s_heritage,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi80s_heritage,
    
    ROUND(SUM(CAST(REPLACE(REPLACE(PPI90s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi90s_heritage,
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI90s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi90s_heritage, 
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI90s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi90s_heritage,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI90s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi90s_heritage
FROM 
	mutant_moneyball;

-- PPI_ebay descriptive stats: min, max, avg
SELECT
    ROUND(SUM(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi60s_ebay, 
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi60s_ebay, 
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi60s_ebay,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi60s_ebay,
    
	ROUND(SUM(CAST(REPLACE(REPLACE(PPI70s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi70s_ebay,
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI70s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi70s_ebay, 
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI70s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi70s_ebay,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI70s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi70s_ebay,
    
    ROUND(SUM(CAST(REPLACE(REPLACE(PPI80s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi80s_ebay,
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI80s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi80s_ebay, 
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI80s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi80s_ebay,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI80s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi80s_ebay,
    
    ROUND(SUM(CAST(REPLACE(REPLACE(PPI90s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi90s_ebay,
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI90s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi90s_ebay, 
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI90s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi90s_ebay,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI90s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi90s_ebay
FROM 
	mutant_moneyball;

-- TotalValue_wiz descriptive stats: totals, min, max, avg
-- looks like the earlier columns might be dollar values and not issue counts - according to later columns 
-- need to verify if there are issues worth below a dollar but not zero so I don't rule out cents valued issues
SELECT
    ROUND(SUM(CAST(REPLACE(TotalValue60s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS sum_total_value60s_wiz,
    ROUND(MIN(CAST(REPLACE(TotalValue60s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS min_total_value60s_wiz,
    ROUND(MAX(CAST(REPLACE(TotalValue60s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS max_total_value60s_wiz,
    ROUND(AVG(CAST(REPLACE(TotalValue60s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS avg_total_value60s_wiz,
    
    ROUND(SUM(CAST(REPLACE(TotalValue70s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS sum_total_value70s_wiz,
    ROUND(MIN(CAST(REPLACE(TotalValue70s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS min_total_value70s_wiz,
    ROUND(MAX(CAST(REPLACE(TotalValue70s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS max_total_value70s_wiz,
    ROUND(AVG(CAST(REPLACE(TotalValue70s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS avg_total_value70s_wiz,
    
    ROUND(SUM(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS sum_total_value80s_wiz,
    ROUND(MIN(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS min_total_value80s_wiz,
    ROUND(MAX(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS max_total_value80s_wiz,
    ROUND(AVG(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS avg_total_value80s_wiz,
    
    ROUND(SUM(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS sum_total_value90s_wiz,
    ROUND(MIN(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS min_total_value90s_wiz,
    ROUND(MAX(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS max_total_value90s_wiz,
    ROUND(AVG(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS avg_total_value90s_wiz
FROM 
	mutant_moneyball;
    
-- TotalValue_oStreet descriptive stats: totals, min, max, avg
SELECT
    ROUND(SUM(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_total_value60s_ostreet,
    ROUND(MIN(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_total_value60s_ostreet,
    ROUND(MAX(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_total_value60s_ostreet,
    ROUND(AVG(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_total_value60s_ostreet,
    
    ROUND(SUM(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_total_value70s_ostreet,
    ROUND(MIN(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_total_value70s_ostreet,
    ROUND(MAX(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_total_value70s_ostreet,
    ROUND(AVG(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_total_value70s_ostreet,
    
    ROUND(SUM(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_total_value80s_ostreet,
    ROUND(MIN(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_total_value80s_ostreet,
    ROUND(MAX(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_total_value80s_ostreet,
    ROUND(AVG(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_total_value80s_ostreet,
    
    ROUND(SUM(CAST(REPLACE(REPLACE(TotalValue90s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_total_value90s_ostreet,
    ROUND(MIN(CAST(REPLACE(REPLACE(TotalValue90s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_total_value90s_ostreet,
    ROUND(MAX(CAST(REPLACE(REPLACE(TotalValue90s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_total_value90s_ostreet,
    ROUND(AVG(CAST(REPLACE(REPLACE(TotalValue90s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_total_value90s_ostreet
FROM 
	mutant_moneyball;

-- PPI_wiz descriptive stats: totals, min, max, avg
SELECT
	ROUND(SUM(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS sum_ppi60s_wiz,
    ROUND(MIN(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS min_ppi60s_wiz,
    ROUND(MAX(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS max_ppi60s_wiz,
    ROUND(AVG(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS avg_ppi60s_wiz,
    
	ROUND(SUM(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS sum_ppi70s_wiz,
    ROUND(MIN(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS min_ppi70s_wiz,
    ROUND(MAX(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS max_ppi70s_wiz,
    ROUND(AVG(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS avg_ppi70s_wiz,
    
	ROUND(SUM(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS sum_ppi80s_wiz,
    ROUND(MIN(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS min_ppi80s_wiz,
    ROUND(MAX(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS max_ppi80s_wiz,
    ROUND(AVG(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS avg_ppi80s_wiz,
    
	ROUND(SUM(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS sum_ppi90s_wiz,
    ROUND(MIN(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS min_ppi90s_wiz,
    ROUND(MAX(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS max_ppi90s_wiz,
    ROUND(AVG(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS avg_ppi90s_wiz
FROM 
	mutant_moneyball;
    
-- PPI_oStreet descriptive stats: totals, min, max, avg
SELECT
	ROUND(SUM(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi60s_ostreet,
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi60s_ostreet,
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi60s_ostreet,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi60s_ostreet,
    
	ROUND(SUM(CAST(REPLACE(REPLACE(PPI70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi70s_ostreet,
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi70s_ostreet,
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi70s_ostreet,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi70s_ostreet,
    
	ROUND(SUM(CAST(REPLACE(REPLACE(PPI80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi80s_ostreet,
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi80s_ostreet,
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi80s_ostreet,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi80s_ostreet,
    
	ROUND(SUM(CAST(REPLACE(REPLACE(PPI90s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS sum_ppi90s_ostreet,
    ROUND(MIN(CAST(REPLACE(REPLACE(PPI90s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS min_ppi90s_ostreet,
    ROUND(MAX(CAST(REPLACE(REPLACE(PPI90s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS max_ppi90s_ostreet,
    ROUND(AVG(CAST(REPLACE(REPLACE(PPI90s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS avg_ppi90s_ostreet
FROM 
	mutant_moneyball;
    
-- descriptive stats: mean, medium, mode (overall)
WITH ordered AS (
	SELECT
		TotalIssues,
        ROW_NUMBER() OVER (ORDER BY TotalIssues) AS `row_number`,
        COUNT(*) OVER () AS total_rows
	FROM
		mutant_moneyball
	)

SELECT
	ROUND((
    SELECT
		AVG(TotalIssues)
	FROM
		mutant_moneyball), 0) AS mean_total_issues,
    ROUND(AVG(TotalIssues), 0) AS median_total_issues,
    (
    SELECT
		TotalIssues
	FROM
		mutant_moneyball
	GROUP BY
		TotalIssues
	ORDER BY
		COUNT(*) DESC
	LIMIT
		1) AS mode_total_issues
FROM
	ordered
WHERE
	`row_number` IN (FLOOR((total_rows + 1) / 2), CEIL((total_rows + 1) / 2));

-- descriptive stats: mean, medium, mode (60s)
WITH ordered AS (
	SELECT
		TotalIssues60s,
        ROW_NUMBER() OVER (ORDER BY TotalIssues60s) AS `row_number`,
        COUNT(*) OVER () AS total_rows
	FROM
		mutant_moneyball
	)

SELECT
	ROUND((
    SELECT
		AVG(TotalIssues60s)
	FROM
		mutant_moneyball), 0) AS mean_total_issues,
    ROUND(AVG(TotalIssues60s), 0) AS median_total_issues,
    (
    SELECT
		TotalIssues60s
	FROM
		mutant_moneyball
	GROUP BY
		TotalIssues60s
	ORDER BY
		COUNT(*) DESC
	LIMIT
		1) AS mode_total_issues
FROM
	ordered
WHERE
	`row_number` IN (FLOOR((total_rows + 1) / 2), CEIL((total_rows + 1) / 2));
    
-- descriptive stats: mean, medium, mode (70s)
WITH ordered AS (
	SELECT
		TotalIssues70s,
        ROW_NUMBER() OVER (ORDER BY TotalIssues70s) AS `row_number`,
        COUNT(*) OVER () AS total_rows
	FROM
		mutant_moneyball
	)

SELECT
	ROUND((
    SELECT
		AVG(TotalIssues70s)
	FROM
		mutant_moneyball), 0) AS mean_total_issues,
    ROUND(AVG(TotalIssues70s), 0) AS median_total_issues,
    (
    SELECT
		TotalIssues70s
	FROM
		mutant_moneyball
	GROUP BY
		TotalIssues70s
	ORDER BY
		COUNT(*) DESC
	LIMIT
		1) AS mode_total_issues
FROM
	ordered
WHERE
	`row_number` IN (FLOOR((total_rows + 1) / 2), CEIL((total_rows + 1) / 2));
    
-- descriptive stats: mean, medium, mode (80s)
WITH ordered AS (
	SELECT
		TotalIssues80s,
        ROW_NUMBER() OVER (ORDER BY TotalIssues80s) AS `row_number`,
        COUNT(*) OVER () AS total_rows
	FROM
		mutant_moneyball
	)

SELECT
	ROUND((
    SELECT
		AVG(TotalIssues80s)
	FROM
		mutant_moneyball), 0) AS mean_total_issues,
    ROUND(AVG(TotalIssues80s), 0) AS median_total_issues,
    (
    SELECT
		TotalIssues80s
	FROM
		mutant_moneyball
	GROUP BY
		TotalIssues80s
	ORDER BY
		COUNT(*) DESC
	LIMIT
		1) AS mode_total_issues
FROM
	ordered
WHERE
	`row_number` IN (FLOOR((total_rows + 1) / 2), CEIL((total_rows + 1) / 2));
    
-- descriptive stats: mean, medium, mode (90s)
WITH ordered AS (
	SELECT
		TotalIssues90s,
        ROW_NUMBER() OVER (ORDER BY TotalIssues90s) AS `row_number`,
        COUNT(*) OVER () AS total_rows
	FROM
		mutant_moneyball
	)

SELECT
	ROUND((
    SELECT
		AVG(TotalIssues90s)
	FROM
		mutant_moneyball), 0) AS mean_total_issues,
    ROUND(AVG(TotalIssues90s), 0) AS median_total_issues,
    (
    SELECT
		TotalIssues90s
	FROM
		mutant_moneyball
	GROUP BY
		TotalIssues90s
	ORDER BY
		COUNT(*) DESC
	LIMIT
		1) AS mode_total_issues
FROM
	ordered
WHERE
	`row_number` IN (FLOOR((total_rows + 1) / 2), CEIL((total_rows + 1) / 2));
    
    
-- Standard Deviation Tables (All in one looong table
DROP TABLE IF EXISTS named;
CREATE TABLE named (
	`Member` VARCHAR(50),
    full_name VARCHAR(50),
    alias_name VARCHAR(50)
);

INSERT INTO named VALUES
	('warrenWorthington', "Warren Worthington", 'Angel'),
    ('hankMcCoy', "Hank McCoy", 'Beast'),
    ('scottSummers', "Scott Summers", 'Cyclops'),
    ('bobbyDrake', "Bobby Drake", 'Iceman'),
    ('jeanGrey', "Jean Grey", 'Phoenix'),
    ('alexSummers', "Alex Summers", 'Havok'),
    ('lornaDane', "Lorna Dane", 'Polaris'),
    ('ororoMunroe', "Ororo Munroe", 'Storm'),
    ('kurtWagner', "Kurt Wagner", 'Nightcrawler'),
    ('loganHowlett', "Logan Howlett", 'Wolverine'),
    ('peterRasputin', "Peter Rasputin", 'Colossus'),
    ('seanCassidy', "Sean Cassidy", 'Banshee'),
    ('shiroYoshida', "Shiro Yoshida", 'Sunfire'),
    ('johnProudstar', "John Proudstar", 'Thunderbird'),
    ('kittyPryde', "Kitty Pryde", 'Shadowcat'),
    ('annaMarieLeBeau', "Anna-Marie LeBeau", 'Rogue'),
    ('rachelSummers', "Rachel Summers", 'Askani'),
    ('ericMagnus', "Eric Magnus", 'Magneto'),
    ('alisonBlaire', "Alison Blaire", 'Dazzler'),
    ('longshot', "Arthur Centino", 'Longshot'),
    ('jonathanSilvercloud', "Jonathan Silvercloud", 'Forge'),
    ('remyLeBeau', "Remy LeBeau", 'Gambit'),
    ('jubilationLee', "Jubilation Lee", 'Jubilee'),
    ('lucasBishop', "Lucas Bishop", 'Bishop'),
    ('betsyBraddock', "Betsy Braddock", 'Psylocke'),
    ('charlesXavier', "Charles Xavier", 'Professor-X'); 

WITH cleaned AS (
SELECT
	full_name,
    alias_name,
    TotalIssues AS total_issues,
	TotalIssues60s AS total_issues_60s,
	TotalIssues70s AS total_issues_70s,
	TotalIssues80s AS total_issues_80s,
	TotalIssues90s AS total_issues_90s,
    ROUND(CAST(REPLACE(60s_Appearance_Percent, '%', '') AS DECIMAL (10,2)), 2) AS 60s_appearance_perc,
    ROUND(CAST(REPLACE(70s_Appearance_Percent, '%', '') AS DECIMAL (10,2)), 2) AS 70s_appearance_perc,
    ROUND(CAST(REPLACE(80s_Appearance_Percent, '%', '') AS DECIMAL (10,2)), 2) AS 80s_appearance_perc,
    ROUND(CAST(REPLACE(90s_Appearance_Percent, '%', '') AS DECIMAL (10,2)), 2) AS 90s_appearance_perc,
    
    ROUND(CAST(TotalValue_heritage AS DECIMAL (10,2)), 2) AS total_value_heritage,
    ROUND(CAST(TotalValue60s_heritage AS DECIMAL (10,2)), 2) AS total_value60s_heritage,
    ROUND(CAST(TotalValue70s_heritage AS DECIMAL (10,2)), 2) AS total_value70s_heritage,
    ROUND(CAST(TotalValue80s_heritage AS DECIMAL (10,2)), 2) AS total_value80s_heritage,
    ROUND(CAST(TotalValue90s_heritage AS DECIMAL (10,2)), 2) AS total_value90s_heritage,
    ROUND(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi60s_heritage,
    ROUND(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi70s_heritage,
    ROUND(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi80s_heritage,
    ROUND(CAST(REPLACE(PPI90s_heritage, '$', '') AS DECIMAL (10,2)), 2) AS ppi90s_heritage,
    
    ROUND(CAST(TotalValue_ebay AS DECIMAL (10,2)), 2) AS total_value_ebay,
    ROUND(CAST(TotalValue60s_ebay AS DECIMAL (10,2)), 2) AS total_value60s_ebay,
    ROUND(CAST(TotalValue70s_ebay AS DECIMAL (10,2)), 2) AS total_value70s_ebay,
    ROUND(CAST(TotalValue80s_ebay AS DECIMAL (10,2)), 2) AS total_value80s_ebay,
    ROUND(CAST(TotalValue90s_ebay AS DECIMAL (10,2)), 2) AS total_value90s_ebay,
    ROUND(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi60s_ebay,
    ROUND(CAST(REPLACE(PPI70s_ebay, '$', '') AS DECIMAL (10,2)), 2) AS ppi70s_ebay,
    ROUND(CAST(REPLACE(PPI80s_ebay, '$', '') AS DECIMAL (10,2)), 2) AS ppi80s_ebay,
    ROUND(CAST(REPLACE(PPI90s_ebay, '$', '') AS DECIMAL (10,2)), 2) AS ppi90s_ebay,
    
    ROUND(CAST(REPLACE(REPLACE(TotalValue60s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(REPLACE(TotalValue70s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS total_value_wizard,
    ROUND(CAST(REPLACE(REPLACE(TotalValue60s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS total_value60s_wizard,
    ROUND(CAST(REPLACE(REPLACE(TotalValue70s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS total_value70s_wizard,
    ROUND(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS total_value80s_wizard,
    ROUND(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS total_value90s_wizard,
    ROUND(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS ppi60s_wizard,
    ROUND(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS ppi70s_wizard,
    ROUND(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS ppi80s_wizard,
    ROUND(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2)), 2) AS ppi90s_wizard,
    
    ROUND(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) +
    ROUND(CAST(REPLACE(TotalValue90s_oStreet, '$', '') AS DECIMAL (10,2)), 2) AS total_value_ostreet,
    ROUND(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS total_value60s_ostreet,
    ROUND(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS total_value70s_ostreet,
    ROUND(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS total_value80s_ostreet,
    ROUND(CAST(REPLACE(TotalValue90s_oStreet, '$', '') AS DECIMAL (10,2)), 2) AS total_value90s_ostreet,
	ROUND(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) AS ppi60s_ostreet,
    ROUND(CAST(REPLACE(PPI70s_oStreet, '$', '') AS DECIMAL (10,2)), 2) AS ppi70s_ostreet,
    ROUND(CAST(REPLACE(PPI80s_oStreet, '$', '') AS DECIMAL (10,2)), 2) AS ppi80s_ostreet,
    ROUND(CAST(REPLACE(PPI90s_oStreet, '$', '') AS DECIMAL (10,2)), 2) AS ppi90s_ostreet
FROM
	mutant_moneyball
LEFT JOIN
	named
ON
	mutant_moneyball.`Member` = named.`Member`)

SELECT
	*
FROM
	cleaned;

-- calculating the central tendencies
SELECT
    COUNT(*) AS count_n,
  
-- TOTAL ISSUES, APPEARANCE PERCENTAGE
  
-- total issues 60s   
    ROUND(AVG(TotalIssues60s), 0) AS mean_total_issues_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues60s ORDER BY TotalIssues60s), ',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 0
		  )AS median_total_issues_60s,
	(
	SELECT 
		TotalIssues60s
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalIssues60s
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_issues_60s,
        ROUND(STDDEV_POP(TotalIssues60s), 0) AS stddev_total_issues_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues60s ORDER BY TotalIssues60s), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 0) AS p25_total_issues_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues60s ORDER BY TotalIssues60s), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
				) AS DECIMAL(10,2)), 0) AS p75_total_issues_60s,
		        
-- total issues 70s
    ROUND(AVG(TotalIssues70s), 0) AS mean_total_issues_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues70s ORDER BY TotalIssues70s), ',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 0
		  )AS median_total_issues_70s,
	(
	SELECT 
		TotalIssues70s
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalIssues70s
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_issues_70s,
    ROUND(STDDEV_POP(TotalIssues70s), 0) AS stddev_total_issues_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues70s ORDER BY TotalIssues70s), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 0) AS p25_total_issues_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues70s ORDER BY TotalIssues70s), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
				) AS DECIMAL(10,2)), 0) AS p75_total_issues_70s,
                
-- total issues 80s
	ROUND(AVG(TotalIssues80s), 0) AS mean_total_issues_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues80s ORDER BY TotalIssues80s), ',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 0
		  )AS median_total_issues_80s,
	(
	SELECT 
		TotalIssues80s
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalIssues80s
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_issues_80s,
    ROUND(STDDEV_POP(TotalIssues80s), 0) AS stddev_total_issues_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues80s ORDER BY TotalIssues80s), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 0) AS p25_total_issues_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues80s ORDER BY TotalIssues80s), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
				) AS DECIMAL(10,2)), 0) AS p75_total_issues_80s,
                
-- total issues 90s
	ROUND(AVG(TotalIssues90s), 0) AS mean_total_issues_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues90s ORDER BY TotalIssues90s), ',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 0
		  )AS median_total_issues_90s,
	(
	SELECT 
		TotalIssues90s
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalIssues90s
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_issues_90s,
    ROUND(STDDEV_POP(TotalIssues90s), 0) AS stddev_total_issues_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues90s ORDER BY TotalIssues90s), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 0) AS p25_total_issues_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(TotalIssues90s ORDER BY TotalIssues90s), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
				) AS DECIMAL(10,2)), 0) AS p75_total_issues_90s,

-- appearance percentage 60s
	ROUND(AVG(CAST(REPLACE(`60s_Appearance_Percent`, '%', '') AS DECIMAL (10,2))), 2) AS mean_appearance_perc_60s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(
						ROUND(
							CAST(REPLACE(`60s_Appearance_Percent`, '%', '') AS DECIMAL(10,2)),
							2
						)
						ORDER BY ROUND(
							CAST(REPLACE(`60s_Appearance_Percent`, '%', '') AS DECIMAL(10,2)),
							2
						)
					),
					',', CEIL(0.5 * COUNT(*))
				),
				',', -1
			) AS DECIMAL(10,2)
		),
		2
	) AS median_appearance_perc_60s,
	(
	SELECT 
		ROUND(CAST(REPLACE(`60s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		`60s_Appearance_Percent`
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_appearance_perc_60s,
    ROUND(STDDEV_POP(CAST(REPLACE(`60s_Appearance_Percent`, '%', '') AS DECIMAL (10,2))), 2) AS stddev_appearance_perc_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(`60s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(`60s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_appearance_perc_60s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(`60s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(`60s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
				) AS DECIMAL(10,2)), 2) AS p75_appearance_perc_60s,

-- appearance percentage 70s
	ROUND(AVG(CAST(REPLACE(`70s_Appearance_Percent`, '%', '') AS DECIMAL (10,2))), 2) AS mean_appearance_perc_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(`70s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(`70s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_appearance_perc_70s,
	(
	SELECT 
		ROUND(CAST(REPLACE(`70s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		`70s_Appearance_Percent`
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_appearance_perc_70s,
    ROUND(STDDEV_POP(CAST(REPLACE(`70s_Appearance_Percent`, '%', '') AS DECIMAL (10,2))), 2) AS stddev_appearance_perc_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(`70s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(`70s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_appearance_perc_70s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(`70s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(`70s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
				) AS DECIMAL(10,2)), 2) AS p75_appearance_perc_70s,

-- appearance percentage 80s
	ROUND(AVG(CAST(REPLACE(`80s_Appearance_Percent`, '%', '') AS DECIMAL (10,2))), 2) AS mean_appearance_perc_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(`80s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(`80s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_appearance_perc_80s,
	(
	SELECT 
		ROUND(CAST(REPLACE(`80s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		`80s_Appearance_Percent`
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_appearance_perc_80s,
    ROUND(STDDEV_POP(CAST(REPLACE(`80s_Appearance_Percent`, '%', '') AS DECIMAL (10,2))), 2) AS stddev_appearance_perc_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(`80s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(`80s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_appearance_perc_80s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(`80s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(`80s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
				) AS DECIMAL(10,2)), 2) AS p75_appearance_perc_80s,
                
-- appearance percentage 90s
	ROUND(AVG(CAST(REPLACE(`90s_Appearance_Percent`, '%', '') AS DECIMAL (10,2))), 2) AS mean_appearance_perc_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(`90s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(`90s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_appearance_perc_90s,
	(
	SELECT 
		ROUND(CAST(REPLACE(`90s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		`90s_Appearance_Percent`
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_appearance_perc_90s,
    ROUND(STDDEV_POP(CAST(REPLACE(`90s_Appearance_Percent`, '%', '') AS DECIMAL (10,2))), 2) AS stddev_appearance_perc_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(`90s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(`90s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_appearance_perc_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(`90s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(`90s_Appearance_Percent`, '%', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
				) AS DECIMAL(10,2)), 2) AS p75_appearance_perc_90s,

-- HERITAGE: TOTAL VALUE, PPI
                
-- total value heritage 60s                
	ROUND(AVG(CAST(TotalValue60s_heritage AS DECIMAL (10,2))), 2) AS mean_total_value_heritage_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue60s_heritage AS DECIMAL(10,2)), 2) ORDER BY ROUND(CAST(TotalValue60s_heritage AS DECIMAL(10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_heritage_60s,
	(
	SELECT 
		ROUND(CAST(TotalValue60s_heritage AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue60s_heritage
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_heritage_60s,
    ROUND(STDDEV_POP(CAST(TotalValue60s_heritage AS DECIMAL (10,2))), 2) AS stddev_total_value_heritage_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue60s_heritage AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue60s_heritage AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_heritage_60s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue60s_heritage AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue60s_heritage AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_heritage_60s,
                
-- total value heritage 70s
	ROUND(AVG(CAST(TotalValue70s_heritage AS DECIMAL (10,2))), 2) AS mean_total_value_heritage_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue70s_heritage AS DECIMAL(10,2)), 2) ORDER BY ROUND(CAST(TotalValue70s_heritage AS DECIMAL(10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_heritage_70s,
	(
	SELECT 
		ROUND(CAST(TotalValue70s_heritage AS DECIMAL(10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue70s_heritage
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_heritage_70s,
    ROUND(STDDEV_POP(CAST(TotalValue70s_heritage AS DECIMAL (10,2))), 2) AS stddev_total_value_heritage_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue70s_heritage AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue70s_heritage AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_heritage_70s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue70s_heritage AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue70s_heritage AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_heritage_70s,
                
-- total value heritage 80s
	ROUND(AVG(CAST(TotalValue80s_heritage AS DECIMAL (10,2))), 2) AS mean_total_value_heritage_80s,
	    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue80s_heritage AS DECIMAL(10,2)), 2) ORDER BY ROUND(CAST(TotalValue80s_heritage AS DECIMAL(10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_heritage_80s,
	(
	SELECT 
		ROUND(CAST(TotalValue80s_heritage AS DECIMAL(10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue80s_heritage
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_heritage_80s,
    ROUND(STDDEV_POP(CAST(TotalValue80s_heritage AS DECIMAL (10,2))), 2) AS stddev_total_value_heritage_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue80s_heritage AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue80s_heritage AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_heritage_80s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue80s_heritage AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue80s_heritage AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_heritage_80s,
                
-- total value heritage 90s
	ROUND(AVG(CAST(TotalValue90s_heritage AS DECIMAL (10,2))), 2) AS mean_total_value_heritage_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue90s_heritage AS DECIMAL(10,2)), 2) ORDER BY ROUND(CAST(TotalValue90s_heritage AS DECIMAL(10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_heritage_90s,
	(
	SELECT 
		ROUND(CAST(TotalValue90s_heritage AS DECIMAL(10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue90s_heritage
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_heritage_90s,
    ROUND(STDDEV_POP(CAST(TotalValue90s_heritage AS DECIMAL (10,2))), 2) AS stddev_total_value_heritage_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue90s_heritage AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue90s_heritage AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_heritage_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue90s_heritage AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue90s_heritage AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_heritage_90s,
                
-- ppi heritage 60s                
	ROUND(AVG(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS mean_ppi_heritage_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_heritage_60s,
	(
	SELECT 
		ROUND(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI60s_heritage
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_heritage_60s,
    ROUND(STDDEV_POP(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_heritage_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_heritage_60s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI60s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_heritage_60s,

-- ppi heritage 70s                
	ROUND(AVG(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS mean_ppi_heritage_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_heritage_70s,
	(
	SELECT 
		ROUND(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI70s_heritage
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_heritage_70s,
    ROUND(STDDEV_POP(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_heritage_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_heritage_70s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI70s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_heritage_70s,

-- ppi heritage 80s                
	ROUND(AVG(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS mean_ppi_heritage_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_heritage_80s,
	(
	SELECT 
		ROUND(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI80s_heritage
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_heritage_80s,
    ROUND(STDDEV_POP(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_heritage_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_heritage_80s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI80s_heritage, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_heritage_80s,
                
-- ppi heritage 90s                
	ROUND(AVG(CAST(REPLACE(PPI90s_heritage, '$', '') AS DECIMAL (10,2))), 2) AS mean_ppi_heritage_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI90s_heritage, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI90s_heritage, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_heritage_90s,
	(
	SELECT 
		ROUND(CAST(REPLACE(PPI90s_heritage, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI90s_heritage
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_heritage_90s,
    ROUND(STDDEV_POP(CAST(REPLACE(PPI90s_heritage, '$', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_heritage_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI90s_heritage, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI90s_heritage, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_heritage_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI90s_heritage, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI90s_heritage, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_heritage_90s,

-- EBAY: TOTAL VALUE, PPI 

-- total value ebay 60s                
	ROUND(AVG(CAST(TotalValue60s_ebay AS DECIMAL (10,2))), 2) AS mean_total_value_ebay_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue60s_ebay AS DECIMAL(10,2)), 2) ORDER BY ROUND(CAST(TotalValue60s_ebay AS DECIMAL(10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_ebay_60s,
	(
	SELECT 
		ROUND(CAST(TotalValue60s_ebay AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue60s_ebay
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_ebay_60s,
    ROUND(STDDEV_POP(CAST(TotalValue60s_ebay AS DECIMAL (10,2))), 2) AS stddev_total_value_ebay_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue60s_ebay AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue60s_ebay AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_ebay_60s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue60s_ebay AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue60s_ebay AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_ebay_60s,

-- total value ebay 70s
	ROUND(AVG(CAST(TotalValue70s_ebay AS DECIMAL (10,2))), 2) AS mean_total_value_ebay_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue70s_ebay AS DECIMAL(10,2)), 2) ORDER BY ROUND(CAST(TotalValue70s_ebay AS DECIMAL(10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_ebay_70s,
	(
	SELECT 
		ROUND(CAST(TotalValue70s_ebay AS DECIMAL(10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue70s_ebay
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_ebay_70s,
    ROUND(STDDEV_POP(CAST(TotalValue70s_ebay AS DECIMAL (10,2))), 2) AS stddev_total_value_ebay_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue70s_ebay AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue70s_ebay AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_ebay_70s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue70s_ebay AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue70s_ebay AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_ebay_70s,

-- total value ebay 80s
	ROUND(AVG(CAST(TotalValue80s_ebay AS DECIMAL (10,2))), 2) AS mean_total_value_ebay_80s,
	    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue80s_ebay AS DECIMAL(10,2)), 2) ORDER BY ROUND(CAST(TotalValue80s_ebay AS DECIMAL(10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_ebay_80s,
	(
	SELECT 
		ROUND(CAST(TotalValue80s_ebay AS DECIMAL(10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue80s_ebay
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_ebay_80s,
    ROUND(STDDEV_POP(CAST(TotalValue80s_ebay AS DECIMAL (10,2))), 2) AS stddev_total_value_ebay_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue80s_ebay AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue80s_ebay AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_ebay_80s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue80s_ebay AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue80s_ebay AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_ebay_80s,
                
-- total value ebay 90s
	ROUND(AVG(CAST(TotalValue90s_ebay AS DECIMAL (10,2))), 2) AS mean_total_value_ebay_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue90s_ebay AS DECIMAL(10,2)), 2) ORDER BY ROUND(CAST(TotalValue90s_ebay AS DECIMAL(10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_ebay_90s,
	(
	SELECT 
		ROUND(CAST(TotalValue90s_ebay AS DECIMAL(10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue90s_ebay
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_ebay_90s,
    ROUND(STDDEV_POP(CAST(TotalValue90s_ebay AS DECIMAL (10,2))), 2) AS stddev_total_value_ebay_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue90s_ebay AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue90s_ebay AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_ebay_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(TotalValue90s_ebay AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(TotalValue90s_ebay AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_ebay_90s,
                
-- ppi ebay 60s                
	ROUND(AVG(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS mean_ppi_ebay_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_ebay_60s,
	(
	SELECT 
		ROUND(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI60s_ebay
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_ebay_60s,
    ROUND(STDDEV_POP(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_ebay_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_ebay_60s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI60s_ebay, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_ebay_60s,
                
-- ppi ebay 70s                
	ROUND(AVG(CAST(REPLACE(PPI70s_ebay, '$', '') AS DECIMAL (10,2))), 2) AS mean_ppi_ebay_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI70s_ebay, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI70s_ebay, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_ebay_70s,
	(
	SELECT 
		ROUND(CAST(REPLACE(PPI70s_ebay, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI70s_ebay
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_ebay_70s,
    ROUND(STDDEV_POP(CAST(REPLACE(PPI70s_ebay, '$', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_ebay_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI70s_ebay, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI70s_ebay, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_ebay_70s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI70s_ebay, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI70s_ebay, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_ebay_70s,
                
-- ppi ebay 80s                
	ROUND(AVG(CAST(REPLACE(PPI80s_ebay, '$', '') AS DECIMAL (10,2))), 2) AS mean_ppi_ebay_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI80s_ebay, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI80s_ebay, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_ebay_80s,
	(
	SELECT 
		ROUND(CAST(REPLACE(PPI80s_ebay, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI80s_ebay
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_ebay_80s,
    ROUND(STDDEV_POP(CAST(REPLACE(PPI80s_ebay, '$', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_ebay_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI80s_ebay, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI80s_ebay, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_ebay_80s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI80s_ebay, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI80s_ebay, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_ebay_80s,
                
-- ppi ebay 90s                
	ROUND(AVG(CAST(REPLACE(PPI90s_ebay, '$', '') AS DECIMAL (10,2))), 2) AS mean_ppi_ebay_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI90s_ebay, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI90s_ebay, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_ebay_90s,
	(
	SELECT 
		ROUND(CAST(REPLACE(PPI90s_ebay, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI90s_ebay
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_ebay_90s,
    ROUND(STDDEV_POP(CAST(REPLACE(PPI90s_ebay, '$', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_ebay_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI90s_ebay, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI90s_ebay, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_ebay_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI90s_ebay, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI90s_ebay, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_ebay_90s,

-- WIZARD: TOTAL VALUE, PPI

-- total value wizard 60s
	ROUND(AVG(CAST(REPLACE(REPLACE(TotalValue60s_wiz, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS mean_total_value_wizard_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue60s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue60s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_wizard_60s,
	(
	SELECT 
		ROUND(CAST(REPLACE(REPLACE(TotalValue60s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue60s_wiz
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_wizard_60s,
    ROUND(STDDEV_POP(CAST(REPLACE(REPLACE(TotalValue60s_wiz, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS stddev_total_value_wizard_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue60s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue60s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_wizard_60s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue60s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue60s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_wizard_60s,

-- total value wizard 70s
	ROUND(AVG(CAST(REPLACE(REPLACE(TotalValue70s_wiz, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS mean_total_value_wizard_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue70s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue70s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_wizard_70s,
	(
	SELECT 
		ROUND(CAST(REPLACE(REPLACE(TotalValue70s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue70s_wiz
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_wizard_70s,
    ROUND(STDDEV_POP(CAST(REPLACE(REPLACE(TotalValue70s_wiz, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS stddev_total_value_wizard_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue70s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue70s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_wizard_70s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue70s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue70s_wiz, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_wizard_70s,
                
-- total value wizard 80s
	ROUND(AVG(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS mean_total_value_wizard_80s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_wizard_80s,
	(
	SELECT 
		ROUND(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue80s_wiz
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_wizard_80s,
    ROUND(STDDEV_POP(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS stddev_total_value_wizard_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_wizard_80s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(TotalValue80s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_wizard_80s,
                
-- total value wizard 90s
	ROUND(AVG(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS mean_total_value_wizard_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_wizard_90s,
	(
	SELECT 
		ROUND(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue90s_wiz
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_wizard_90s,
    ROUND(STDDEV_POP(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS stddev_total_value_wizard_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_wizard_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(TotalValue90s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_wizard_90s,

-- ppi wizard 60s                
	ROUND(AVG(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS mean_ppi_wizard_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_wizard_60s,
	(
	SELECT 
		ROUND(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI60s_wiz
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_wizard_60s,
    ROUND(STDDEV_POP(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_wizard_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_wizard_60s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI60s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_wizard_60s,
                
-- ppi wizard 70s                
	ROUND(AVG(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS mean_ppi_wizard_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_wizard_70s,
	(
	SELECT 
		ROUND(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI70s_wiz
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_wizard_70s,
    ROUND(STDDEV_POP(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_wizard_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_wizard_70s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI70s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_wizard_70s,
                
-- ppi wizard 80s                
	ROUND(AVG(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS mean_ppi_wizard_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_wizard_80s,
	(
	SELECT 
		ROUND(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI80s_wiz
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_wizard_80s,
    ROUND(STDDEV_POP(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_wizard_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_wizard_80s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI80s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_wizard_80s,
                
-- ppi wizard 90s                
	ROUND(AVG(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS mean_ppi_wizard_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_wizard_90s,
	(
	SELECT 
		ROUND(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI90s_wiz
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_wizard_90s,
    ROUND(STDDEV_POP(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_wizard_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_wizard_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI90s_wiz, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_wizard_90s,

-- OSTREET: TOTAL VALUE, PPI

-- total value ostreet 60s
	ROUND(AVG(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS mean_total_value_ostreet_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_ostreet_60s,
	(
	SELECT 
		ROUND(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue60s_oStreet
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_ostreet_60s,
    ROUND(STDDEV_POP(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS stddev_total_value_ostreet_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_ostreet_60s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_ostreet_60s,
                
-- total value ostreet 70s
	ROUND(AVG(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS mean_total_value_ostreet_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_ostreet_70s,
	(
	SELECT 
		ROUND(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue70s_oStreet
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_ostreet_70s,
    ROUND(STDDEV_POP(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS stddev_total_value_ostreet_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_ostreet_70s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue70s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_ostreet_70s,
                
-- total value ostreet 80s
	ROUND(AVG(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS mean_total_value_ostreet_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_ostreet_80s,
	(
	SELECT 
		ROUND(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue80s_oStreet
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_ostreet_80s,
    ROUND(STDDEV_POP(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS stddev_total_value_ostreet_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_ostreet_80s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(TotalValue80s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_ostreet_80s,
                
-- total value ostreet 90s
	ROUND(AVG(CAST(REPLACE(TotalValue90s_oStreet, '$', '') AS DECIMAL (10,2))), 2) AS mean_total_value_ostreet_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(TotalValue90s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(TotalValue90s_oStreet, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_total_value_ostreet_90s,
	(
	SELECT 
		ROUND(CAST(REPLACE(TotalValue90s_oStreet, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		TotalValue90s_oStreet
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_total_value_ostreet_90s,
    ROUND(STDDEV_POP(CAST(REPLACE(TotalValue90s_oStreet, '$', '') AS DECIMAL (10,2))), 2) AS stddev_total_value_ostreet_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(TotalValue90s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(TotalValue90s_oStreet, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_total_value_ostreet_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(TotalValue90s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(TotalValue90s_oStreet, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_total_value_ostreet_90s,

-- ppi ostreet 60s                
	ROUND(AVG(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS mean_ppi_ostreet_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_ostreet_60s,
	(
	SELECT 
		ROUND(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI60s_oStreet
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_ostreet_60s,
    ROUND(STDDEV_POP(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_ostreet_60s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_ostreet_60s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(REPLACE(PPI60s_oStreet, '$', ''), ',', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_ostreet_60s,
                
-- ppi ostreet 70s                
	ROUND(AVG(CAST(REPLACE(PPI70s_oStreet, '$', '') AS DECIMAL (10,2))), 2) AS mean_ppi_ostreet_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI70s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI70s_oStreet, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_ostreet_70s,
	(
	SELECT 
		ROUND(CAST(REPLACE(PPI70s_oStreet, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI70s_oStreet
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_ostreet_70s,
    ROUND(STDDEV_POP(CAST(REPLACE(PPI70s_oStreet, '$', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_ostreet_70s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI70s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI70s_oStreet, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_ostreet_70s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI70s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI70s_oStreet, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_ostreet_70s,
                
-- ppi ostreet 80s                
	ROUND(AVG(CAST(REPLACE(PPI80s_oStreet, '$', '') AS DECIMAL (10,2))), 2) AS mean_ppi_ostreet_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI80s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI80s_oStreet, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_ostreet_80s,
	(
	SELECT 
		ROUND(CAST(REPLACE(PPI80s_oStreet, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI80s_oStreet
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_ostreet_80s,
    ROUND(STDDEV_POP(CAST(REPLACE(PPI80s_oStreet, '$', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_ostreet_80s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI80s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI80s_oStreet, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p25_ppi_ostreet_80s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI80s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI80s_oStreet, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1
                ) AS DECIMAL(10,2)), 2) AS p75_ppi_ostreet_80s,
                
-- ppi ostreet 90s                
	ROUND(AVG(CAST(REPLACE(PPI90s_oStreet, '$', '') AS DECIMAL (10,2))), 2) AS mean_ppi_ostreet_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(ROUND(CAST(REPLACE(PPI90s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY ROUND(CAST(REPLACE(PPI90s_oStreet, '$', '') AS DECIMAL (10,2)), 2)),	',', CEIL(0.5 * COUNT(*))
						), ',',	-1
					) AS DECIMAL(10,2)
				), 2
		  )AS median_ppi_ostreet_90s,
	(
	SELECT 
		ROUND(CAST(REPLACE(PPI90s_oStreet, '$', '') AS DECIMAL (10,2)), 2)
	FROM 
		mutant_moneyball AS sub
	GROUP BY 
		PPI90s_oStreet
	ORDER BY 
		COUNT(*) DESC
	LIMIT 
		1
	) AS mode_ppi_ostreet_90s,
    ROUND(STDDEV_POP(CAST(REPLACE(PPI90s_oStreet, '$', '') AS DECIMAL (10,2))), 2) AS stddev_ppi_ostreet_90s,
    ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(
						ROUND(
							CAST(
								REPLACE(PPI90s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY 
										ROUND(
											CAST(
												REPLACE(PPI90s_oStreet, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.25 * COUNT(*))
					), ',', -1) AS DECIMAL(10,2)), 2) AS p25_ppi_ostreet_90s,
	ROUND(
		CAST(
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(
					GROUP_CONCAT(
						ROUND(
							CAST(
								REPLACE(PPI90s_oStreet, '$', '') AS DECIMAL (10,2)), 2) ORDER BY 
										ROUND(CAST(REPLACE(PPI90s_oStreet, '$', '') AS DECIMAL (10,2)), 2)), ',', CEIL(0.75 * COUNT(*))
					), ',', -1) AS DECIMAL(10,2)), 2) AS p75_ppi_ostreet_90s
FROM
	mutant_moneyball;
