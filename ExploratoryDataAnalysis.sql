SELECT * 
FROM layoffs_staging2;

SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- Looking at how brutal lay offs were.
SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL;

-- Looking at companies which has whole of their companies shut down (Where percentage laid off = 1)
SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off = 1;

-- Ordering by funds raised by millions so we can know that how big some of the companies were, which shut down.
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- Britishvolt was the company which had highest funding of all, which is 2.4 Billion dollars and went down.

-- Looking at top 5 companies with highest layoffs in a single time 
SELECT company, total_laid_off
FROM layoffs_staging2
ORDER BY 2 DESC
LIMIT 5;

-- Looking at top 10 companies with most layoffs
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;
-- Data shows amazon had the most layoffs of all companies(overall).

-- Now we will look at highest layoffs by location
SELECT location, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;
-- SF Bay Area had the highest number of layoffs in total

-- Now we will look for highest number of layoffs by country
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
-- United States had the highest number of layoffs in total

-- Now we will look at highest number of layoffs by year
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

-- Now we will look at what stage companies had most layoffs
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;
-- POST-IPO companies had the most layoffs

-- Now we will look at which industry had the highest layoffs in all.
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
-- Consumer industry had the highest number of layoffs.

-- Now we will divide companies on the basis of layoffs by year and rank them
WITH Company_Year AS
(
SELECT company, YEAR(`date`) as years, SUM(total_laid_off) as total_laid_off 
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
, Company_Year_Rank AS
(
SELECT company, years, total_laid_off, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;

-- Rolling Total of Layoffs Per Month
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC;

-- now use it in a CTE so we can query off of it
WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;



