# Data Analysis Portfolio

Practice projects in SQL, Python and BI tools. Files keep their original names and locations so existing links keep working.

## Projects

| Project | Files | Tools | Data |
|---------|-------|-------|------|
| **Data Professional Survey dashboard** | `Project.pbix`, `Project.pdf` | Power BI | Survey of data professionals (630 respondents): respondent country, average salary by job title and gender, satisfaction with work/life balance and salary, favourite programming language, difficulty of breaking into data |
| **Housing price dashboard** | `Dashboard 1.pdf` | Dashboard export (PDF) | Average price by zip code with a map view (Seattle-area 98xxx zip codes) |
| **Tech layoffs: data cleaning** | `WorldLayoffs_DataCleaning.sql` | MySQL | Public layoffs dataset. Staging table, duplicate removal with `ROW_NUMBER()` in a CTE, standardizing values, handling nulls and blanks, dropping helper columns |
| **Tech layoffs: exploratory analysis** | `ExploratoryDataAnalysis.sql` | MySQL | Same dataset. Aggregations by company, location, country, year, stage and industry; top-3 companies per year with `DENSE_RANK()`; rolling monthly total with a window function |
| **COVID-19 data exploration** | `SQLQuery1..sql` | SQL Server (T-SQL) | Public COVID deaths and vaccinations tables. Joins, `CAST`/`CONVERT`, rolling vaccinations with `SUM() OVER (PARTITION BY ...)`, a CTE for percent of population vaccinated |
| **Student performance analysis** | `noteboooks/notebook1-3.ipynb` | Python (pandas, SciPy, seaborn) | Kaggle student grading dataset (file not included). Descriptive statistics, chi-square tests of independence, visualizations |
| **Customer data cleaning pipeline** | `Project(Commented).ipynb` | Python (pandas, NumPy) | **Synthetic** 1,050-row customer dataset generated in the notebook with deliberate errors (blanks, invalid emails, out-of-range ages and amounts, bad dates, 50 duplicates). 13 cleaning steps and a before/after report (1,050 rows in, 875 out) |
| **Game metrics statistics** | `project(GameAnalysis).ipynb` | Python (pandas, NumPy, SciPy, seaborn) | **Synthetic** gaming metrics (350 rows from random distributions). Custom summary-statistics function (IQR, skewness, kurtosis, coefficient of variation) and distribution plots |
| **Web scraping** | `Book2WebScraping.ipynb` | Python (requests, BeautifulSoup, pandas) | Table of the largest US companies by revenue, scraped from Wikipedia |

## Notes

- Notebooks that read local files (for example the student dataset) use paths from my own machine; update the paths to run them elsewhere.
- The synthetic-data notebooks are exercises in cleaning and describing data. They do not measure real-world performance.
- A separate project, TransitDelay (Toronto bus delays vs. weather), and a SQL fraud-detection project are in their own repositories.

## Author

Sharad Patel, https://github.com/SharadPatel1703
