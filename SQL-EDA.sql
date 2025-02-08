
select* from Projects.dbo.['2018$'];

select * from dbo.['2019$'];

select* from dbo.['2020$'];


--Before answering the questions, we will first create a single temporary table hotels that combines all the data using following code for easier access and analysis.
with hotels as (
select* from dbo.['2018$']
union
select * from dbo.['2019$']
union
select* from dbo.['2020$'] )

select * from hotels



--Explotary Data Analysis 


--Q.1: Is our hotel revenue growing yearly?
--In our dataset we don’t have revenue, but we do have adr (Average Daily Rate), stays_in_week_nights, and stays_in _weekend_nights. So, we will create a new column revenue by using the data of these three columns as follows.
with hotels as (
select* from dbo.['2018$']
union
select * from dbo.['2019$']
union
select* from dbo.['2020$'] ) 

select arrival_date_year , hotel, ROUND( sum ( (stays_in_week_nights +stays_in_weekend_nights)* adr),2) as revenue
from hotels
group by arrival_date_year, hotel;
-- in the table we can see that for both City Hotel and Resort Hotel, the revenue values increased from 2018 to 2019 and then decreased in 2020.


--Q2: Should we increase our parking lot size?
--To answer this question, we will focus on the car_parking_spaces and number of guests staying in the hotel. So, let’s do it by applying the following SQL query.
with hotels as (
select* from dbo.['2018$']
union
select * from dbo.['2019$']
union
select* from dbo.['2020$'] ) 

select
arrival_date_year, hotel,
sum((stays_in_week_nights + stays_in_weekend_nights) * adr) as renenue,
concat (round((sum(required_car_parking_spaces)/sum(stays_in_week_nights +
stays_in_weekend_nights)) * 100, 2), '%') as parking_percentage
from hotels group by arrival_date_year, hotel

--In the next table we can observe that we have enough space for parking. So, there is no need to increase our parking lot size.



