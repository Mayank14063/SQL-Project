--select * from Portfolio_Project.dbo.CovidDeaths;

--select * from Portfolio_Project.dbo.Covidvaccination;

select Location, Date, total_cases, new_cases, total_deaths, population from  
  Portfolio_Project.dbo.CovidDeaths order by 1,2;

  --total cases vs total death

  select Location, Date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage 
  from Portfolio_Project.dbo.CovidDeaths where Location like '%dia%' order by 1,2;


  -- total cases vs population

   select Location, Date, total_cases, population, (total_cases/population)*100 as cases_per_population
  from Portfolio_Project.dbo.CovidDeaths where location like '%states%' order by 1,2;

  -- country with highest infection rate

     select location, max(total_cases) as high_cases, max((total_cases/population)*100) as 
	 percent_population_affected from Portfolio_Project.dbo.CovidDeaths group by 
	 location, Population order by percent_population_affected desc;

	 select location from Portfolio_Project.dbo.CovidDeaths where total_cases=151399480;

	   -- countries with highest death rate

	    select location, max((total_deaths/population)*100) as 
	 percent_population_died from Portfolio_Project.dbo.CovidDeaths where continent is not null group by 
	 location order by percent_population_died desc ;

	 -- continents with highest death rate

	 select continent, max((total_deaths/population)*100) as 
	 percent_population_died  from Portfolio_Project.dbo.CovidDeaths where continent is not null group by
	 continent order by  percent_population_died;

	 -- joining both tables

	 select Portfolio_Project.dbo.Covidvaccination.total_vaccinations,  Portfolio_Project.dbo.Covidvaccination.location,
	 Portfolio_Project.dbo.CovidDeaths.total_cases, Portfolio_Project.dbo.CovidDeaths.location
	 from Portfolio_Project.dbo.Covidvaccination inner join Portfolio_Project.dbo.CovidDeaths on 
	 Portfolio_Project.dbo.Covidvaccination.location=Portfolio_Project.dbo.CovidDeaths.location where
	 total_vaccinations is not null and total_cases is not null

	 -- sum of vaccinations each day

	 select location, date, sum(cast(total_vaccinations as bigint)) over (partition by date) as vacc_per_day 
	
	  from Portfolio_Project.dbo.Covidvaccination  where total_vaccinations is not null  order by date 

	  select sum(cast(new_deaths as int)) as total_deaths, sum(new_cases) as total_cases,
	  sum(cast(new_deaths as int))/sum(new_cases)*100 as death_percentage
	  from Portfolio_Project.dbo.CovidDeaths where continent is not null;

	  select location, sum(cast(new_deaths as int)) as total_death_count from Portfolio_Project.dbo.CovidDeaths 
	  where continent is null and location not in ('world', 'European Union', 'International')
	  
	   group by location order by total_death_count desc 

	   select location, population, max(total_cases) highest_case, max((total_cases/population)*100) as 
	   percentage_population_infected from Portfolio_Project.dbo.CovidDeaths group by location, population
	   order by  percentage_population_infected desc

	      select location, population, date, max(total_cases) highest_case, max((total_cases/population)*100) as 
	   percentage_population_infected from Portfolio_Project.dbo.CovidDeaths group by location, population, date
	   order by  percentage_population_infected desc