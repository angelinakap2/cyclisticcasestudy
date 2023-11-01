-- cleaning up: deleted trailing NULL rows
-- union all monthly datasets into one table


-- create new table
CREATE TABLE Cyclistic.dbo.cyclistic_year (
	member_type nvarchar(255),
	bike_type nvarchar(255),
	start_time_stamp datetime,
	start_date datetime,
	start_month nvarchar(255),
	start_day nvarchar(255),
	start_time datetime,
	end_time_stamp datetime,
	ride_length float
)


-- insert combined excel monthly sheets into newly created tables
INSERT INTO Cyclistic.dbo.cyclistic_year (member_type, bike_type, start_time_stamp, start_date, start_month, start_day, start_time, end_time_stamp, ride_length)
	SELECT *
	FROM dbo.['2022_October_Cyclistic$']
	UNION ALL
	SELECT *
	FROM dbo.['2022_November_Cyclistic$']
	UNION ALL
	SELECT *
	FROM dbo.['2022_December_Cyclistic$']
	UNION ALL
	SELECT *
	FROM dbo.['2023_January_Cyclistic$']
	UNION ALL
	SELECT *
	FROM dbo.['2023_February_Cyclistic$']
	UNION ALL
	SELECT *
	FROM dbo.['2023_March_Cyclistic$']
	UNION ALL
	SELECT *
	FROM dbo.['2023_April_Cyclistic$']
	UNION ALL
	SELECT *
	FROM dbo.['2023_May_Cyclistic$']
	UNION ALL
	SELECT *
	FROM dbo.['2023_June_Cyclistic$']
	UNION ALL
	SELECT *
	FROM dbo.['2023_July_Cyclistic$']
	UNION ALL
	SELECT *
	FROM dbo.['2023_August_Cyclistic$']
	UNION ALL
	SELECT *
	FROM dbo.['2023_September_Cyclistic$']
	order by start_time_stamp



-- chart for ride length average from annual and casual member, based on month
SELECT start_month, member_type, AVG(ride_length) as avg_ride_in_minutes
FROM cyclistic_year
GROUP BY start_month, member_type
ORDER BY CASE 
WHEN start_month = 'January' then 1
WHEN start_month = 'February' then 2
WHEN start_month = 'March' then 3
WHEN start_month = 'April' then 4
WHEN start_month = 'May' then 5
WHEN start_month = 'June' then 6
WHEN start_month = 'July' then 7
WHEN start_month = 'August' then 8
WHEN start_month = 'September' then 9
WHEN start_month = 'October' then 10
WHEN start_month = 'November' then 11
WHEN start_month = 'December' then 12
else NULL end
, member_type


-- chart for total ride amount from annual and casual member, based on month
SELECT start_month, member_type, COUNT(ride_length) as ride_count
FROM cyclistic_year
GROUP BY start_month, member_type
ORDER BY CASE 
WHEN start_month = 'January' then 1
WHEN start_month = 'February' then 2
WHEN start_month = 'March' then 3
WHEN start_month = 'April' then 4
WHEN start_month = 'May' then 5
WHEN start_month = 'June' then 6
WHEN start_month = 'July' then 7
WHEN start_month = 'August' then 8
WHEN start_month = 'September' then 9
WHEN start_month = 'October' then 10
WHEN start_month = 'November' then 11
WHEN start_month = 'December' then 12
else NULL end
, member_type


-- chart for total ride amount from annual and casual member, based on day
SELECT start_day, member_type, COUNT(ride_length) as day_ride_count
FROM cyclistic_year
GROUP BY start_day, member_type
ORDER BY CASE 
WHEN start_day = 'Sunday' then 1
WHEN start_day = 'Monday' then 2
WHEN start_day = 'Tuesday' then 3
WHEN start_day = 'Wednesday' then 4
WHEN start_day = 'Thursday' then 5
WHEN start_day = 'Friday' then 6
WHEN start_day = 'Saturday' then 7
else NULL end
, member_type


-- chart for total ride average from annual and casual member, based on day
SELECT start_day, member_type, AVG(ride_length) as day_ride_avg
FROM cyclistic_year
GROUP BY start_day, member_type
ORDER BY CASE 
WHEN start_day = 'Sunday' then 1
WHEN start_day = 'Monday' then 2
WHEN start_day = 'Tuesday' then 3
WHEN start_day = 'Wednesday' then 4
WHEN start_day = 'Thursday' then 5
WHEN start_day = 'Friday' then 6
WHEN start_day = 'Saturday' then 7
else NULL end
, member_type



-- total ride count over year (member vs. casual)
SELECT member_type, AVG(ride_length) as ride_count_min
FROM cyclistic_year
GROUP BY member_type

-- total ride average over year (member vs. casual)
SELECT member_type, AVG(ride_length) as avg_ride_min
FROM cyclistic_year
GROUP BY member_type

-- bike type usage per member type (member vs. casual)
SELECT member_type, bike_type, COUNT(bike_type) as amount
FROM cyclistic_year
GROUP BY member_type, bike_type
ORDER BY member_type, bike_type


-- highest month/days of use for casual riders
SELECT member_type, start_day, COUNT(ride_length) as casual_ride_count_july
FROM cyclistic_year
WHERE start_month = 'July' AND member_type = 'casual'
GROUP BY start_day, member_type
ORDER BY CASE 
WHEN start_day = 'Sunday' then 1
WHEN start_day = 'Monday' then 2
WHEN start_day = 'Tuesday' then 3
WHEN start_day = 'Wednesday' then 4
WHEN start_day = 'Thursday' then 5
WHEN start_day = 'Friday' then 6
WHEN start_day = 'Saturday' then 7
else NULL end


-- total ride count for each member for entire year
SELECT member_type, COUNT(ride_length) as year_ride_count
FROM cyclistic_year
GROUP BY member_type
