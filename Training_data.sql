USE yek;

#table that will hold all quarters in the last 5 years

CREATE TABLE quarterly_sampling_helper_table (sampled_date DATE);

INSERT INTO quarterly_sampling_helper_table (sampled_date)
SELECT DISTINCT DATE_FORMAT(date, '%Y-%m-%d') AS sampled_date
FROM (
    SELECT DATE_ADD('2023-01-01', INTERVAL (t4*1000 + t3*100 + t2*10 + t1) DAY) AS date
    FROM
        (SELECT 0 AS t1 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t1,
        (SELECT 0 AS t2 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2,
        (SELECT 0 AS t3 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t3,
        (SELECT 0 AS t4 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t4
) AS all_dates_in_time_frame
WHERE date BETWEEN '2023-01-01' AND '2024-02-09'
ORDER BY sampled_date DESC;


#relevant technology company per sampled date

CREATE TABLE sampled_companies (Company VARCHAR(255),sampled_date DATE);

WITH company_first_layoff AS (
SELECT Company, MIN(Date) AS first_layoff
  FROM my_files.layoffs_data_1_
  GROUP BY Company)

INSERT INTO sampled_companies (Company, sampled_date)
SELECT company_first_layoff.Company, quarterly_sampling_helper_table.sampled_date
FROM company_first_layoff
JOIN quarterly_sampling_helper_table ON quarterly_sampling_helper_table.sampled_date >= company_first_layoff.first_layoff
ORDER BY sampled_date DESC, Company;
  
  

# positive and negative examples from historical data
# core_set

CREATE TABLE core_set (Company VARCHAR(255), sampled_date DATE, did_the_company_make_more_layoffs_within_next_quarter VARCHAR(3));

WITH max_layoffs_date AS (SELECT MAX(Date) AS max_date FROM my_files.layoffs_data_1_)

INSERT INTO core_set (Company, sampled_date, did_the_company_make_more_layoffs_within_next_quarter)
SELECT sampled_companies.Company, sampled_companies.sampled_date,
  CASE 
    WHEN COUNT(my_files.layoffs_data_1_.Company) > 0 THEN 'YES'
    ELSE 'NO'
  END AS did_the_company_make_more_layoffs_within_next_quarter
FROM sampled_companies
LEFT JOIN my_files.layoffs_data_1_
ON 
  sampled_companies.Company = my_files.layoffs_data_1_.Company
  AND my_files.layoffs_data_1_.Date >= sampled_companies.sampled_date
  AND my_files.layoffs_data_1_.Date < sampled_companies.sampled_date + INTERVAL 3 MONTH
WHERE sampled_companies.sampled_date + INTERVAL 3 MONTH < (SELECT max_date FROM max_layoffs_date)
GROUP BY sampled_companies.Company, sampled_companies.sampled_date;
  
  
  
  # additional tables with information about prediction
  
  CREATE TABLE additional_activity_data (
    Location_HQ VARCHAR(255),
    Industry VARCHAR(255),
    Laid_Off_Count INT,
    Percentage FLOAT,
    Source VARCHAR(255),
    Funds_Raised FLOAT,
    Stage VARCHAR(255),
    Country VARCHAR(255),
    List_of_Employees_Laid_Off TEXT
);

INSERT INTO additional_activity_data (Location_HQ, Industry, Laid_Off_Count, Percentage, Source, Funds_Raised, Stage, Country, List_of_Employees_Laid_Off)
SELECT Location_HQ, Industry, Laid_Off_Count, Percentage, Source, Funds_Raised, Stage, Country, List_of_Employees_Laid_Off
FROM my_files.layoffs_data_1_
JOIN core_set ON my_files.layoffs_data_1_.Company = core_set.Company
WHERE my_files.layoffs_data_1_.Date < core_set.sampled_date AND my_files.layoffs_data_1_.Date >= core_set.sampled_date - INTERVAL 1 YEAR;
