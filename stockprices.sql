--Brief database overview
SELECT * FROM PortfolioProjects..['S&P 500 Stock Prices 2014-2017$']
where symbol = 'CHK'
order by date 

-------------------------------------------------------------------------------------------------------------------------------------------------|
--Q1) Which date in the sample saw the largest overall trading volume?
	-- On that date, which two stocks were traded most?

--Date with highest trading volume
	-- Date is 2014/03/21 with Volume of 7,223,983,122
select TOP 1 date
	, sum(volume) as totalVol
from PortfolioProjects..['S&P 500 Stock Prices 2014-2017$']
group by date
order by totalVol desc;

--STOCKS TRADED THE most on 21/03/2014
	-- BAC with 312,052,582
	-- CSCO with 194,754,684
select TOP 2 symbol
	, sum(volume) as totalVol
from PortfolioProjects..['S&P 500 Stock Prices 2014-2017$']
where date = '2014-03-21'
group by symbol
order by totalVol desc;
-------------------------------------------------------------------------------------------------------------------------------------------------|

--Q2) On which day of the week does volume tend to be highest? Lowest?
	-- Fridays have the highest trading volume
	-- Mondays have the lowest trading volumes
select DATENAME(DW, date) as Day_of_week
	, avg(volume) as avg_Vol
from PortfolioProjects..['S&P 500 Stock Prices 2014-2017$']
group by DATENAME(DW, date)
order by avg_Vol desc;
-------------------------------------------------------------------------------------------------------------------------------------------------|

--Q3) On which date did Amazon (AMZN) see the most volatility, measured by the difference between the high and low price?
	-- FRIDAY of 2017/06/09 with MaxVolatility of 85.99
select date
	, DATENAME(dw,date) as Dayofweek
	, MAX(high - low) as MaxVolatility
from PortfolioProjects..['S&P 500 Stock Prices 2014-2017$']
where symbol = 'AMZN'
group by date
order by MaxVolatility desc;
-------------------------------------------------------------------------------------------------------------------------------------------------|

--Q4) If you could go back in time and invest in one stock from 1/2/2014 - 12/29/2017, which would you choose? What % gain would you realize?
	-- CHK is number 1 choice with a percentGain of 1785.5% gain
	-- if a single share was purchased on 1/2/2014 (open is $27.07) on 12/29/2017 it would have grown by 1785%
	-- so total gains is (27.07 * 1785%) + 27.07 = $510
select symbol
	, ((MAX([close]) - MIN([open])) / MIN([open]))*100 as percentGain
from PortfolioProjects..['S&P 500 Stock Prices 2014-2017$']
 where date >= '2014-01-02' and date <= '2017-12-29'
 group by symbol
 order by percentGain desc;
-------------------------------------------------------------------------------------------------------------------------------------------------|

