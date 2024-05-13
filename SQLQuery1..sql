USE PortfolioProject

SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM CovidDeaths
ORDER BY 3, 4;

-- Checking Total Deaths vs Total Cases
-- Shows likelihood of dying in your Canada
SELECT location, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage, date  
FROM CovidDeaths
WHERE location like 'canada'
ORDER BY 1, 2;

-- Checking Total cases vs total popultaion
-- This will show how much percentage of people got infected by Covid in Canada
SELECT location, total_cases, population, (total_cases/population)*100 as InfectionPercentage, date  
FROM CovidDeaths
WHERE location like 'canada'
ORDER BY 1, 2;

-- Now Below query will show countries with highest infectionPercentage in the world
SELECT location, MAX(total_cases) as HighestCases, population, MAX((total_cases/population))*100 as InfectionPercentage  
FROM CovidDeaths
GROUP BY location, population
ORDER BY InfectionPercentage desc;

--Below query will show which countries had the highest death counts
SELECT location, MAX(cast(total_deaths as int)) as HighestDeaths  
FROM CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY HighestDeaths desc;

--Below Query will show which continent had the highest death counts
SELECT location, MAX(CAST(total_deaths as int)) as HighestDeaths
FROM CovidDeaths
WHERE continent is null
GROUP BY location
ORDER BY HighestDeaths desc;

-- Global Numbers
--Below Given Numbers will show New_cases which happened every day along with total new deaths and also calculating Death Percentage

SELECT date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM CovidDeaths
WHERE continent is not null
Group By date
order by 1,2

-- Below Query will show Total cases, Total Deaths and death percentage
SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as DeatPercentage   
FROM CovidDeaths
WHERE continent is not null



--Looking at Total poplulation vs Total Vaccination
SELECT * 
FROM CovidDeaths dea
Join CovidVaccinations vac 
  ON dea.location = vac.location
  and dea.date = vac.date

-- Below Query will show New Vaccinations as per given location in the tables
SELECT dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations 
FROM CovidDeaths dea
Join CovidVaccinations vac 
  ON dea.location = vac.location
  and dea.date = vac.date
WHERE dea.continent is not null
order by 2,3

-- Below Query will show New vaccinations in total every day differentiated by locations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
FROM CovidDeaths dea
Join CovidVaccinations vac
 ON dea.location = vac.location
 and dea.date = vac.date
WHERE dea.continent is not null
order by 2,3

-- using CTE to show how much amount of total population is vaccinted in total
WITH PopVsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated, humanDevelopmentInd)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated, vac.human_development_index
FROM CovidDeaths dea
Join CovidVaccinations vac
 ON dea.location = vac.location
 and dea.date = vac.date
WHERE dea.continent is not null
)
SELECT Continent, Location, Population, humanDevelopmentInd, MAX((RollingPeopleVaccinated/Population)*100) as Population_vaccinated
FROM PopVsVac
GROUP BY Continent,Location, Population, humanDevelopmentInd
ORDER BY 4 DESC