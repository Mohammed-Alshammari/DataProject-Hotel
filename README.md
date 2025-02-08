# 📊 Hotel Booking Analysis Using SQL & Power BI  

## 🏆 Project Overview  
This project involves analyzing hotel booking data to extract meaningful insights that can inform business decisions. The analysis is conducted using SQL for data querying and Power BI for visualization. Key questions addressed include:
  - Is the hotel's revenue growing annually?
  - Should the parking lot size be increased?
  - What trends are evident in the booking data?

---

## 📑 Table of Contents  
- [📂 Data Source](#📂-data-source)  
- [🛠 Tools & Technologies Used](#🛠-tools--technologies-used)  
- [🔍 Data Analysis Breakdown](#🔍-data-analysis-breakdown)  
  - [🗄 Data Preparation](#🗄-data-preparation)  
  - [📊 Exploratory Data Analysis (EDA)](#📊-exploratory-data-analysis-eda)  
  - [📊 Power BI Analysis](#📊-power-bi-analysis)  
- [📉 Results](#📉-results)  
- [📢 Recommendations](#📢-recommendations)  

---

## 📂 Data Source  
- **Dataset:** Hotel booking records  
- **Original Source:** [AbsentData]([https://absentdata.com/data-analysis/data-analysis-mastery-step-by-step-portfolio-project-guide/](https://absentdata.com/data-analysis/where-to-find-data/))  

---

## 🛠 Tools & Technologies Used  
- **SQL Server Management Studio (SSMS)** for querying and data preparation  
- **Power BI** for visualization and dashboard creation  

---

# 🔍 Data Analysis Breakdown


## SQL Analysis

### 🗄 Data Preparation  
- Database Creation: Established a database in SSMS and imported the hotel booking data from Excel files for the years 2018, 2019, and 2020.


---

### 📊 Exploratory Data Analysis (EDA)  

1. Is Our Hotel Revenue Growing Annually?
The dataset does not contain explicit revenue figures. However, we can estimate revenue using the Average Daily Rate (ADR) and the total number of nights stayed.

SQL Query:
```sql
with hotels as (
select* from dbo.['2018$']
union
select * from dbo.['2019$']
union
select* from dbo.['2020$'] ) 

select arrival_date_year , hotel, ROUND( sum ( (stays_in_week_nights +stays_in_weekend_nights)* adr),2) as revenue
from hotels
group by arrival_date_year, hotel;
```
  - This query calculates the estimated revenue for each year by multiplying the ADR by the total number of nights stayed (both week and weekend nights) and aggregating the results annually.
  
---
![image](https://github.com/user-attachments/assets/afc4a6ec-35dc-43f6-9151-87ab3d71139e)

---
  - We can see that for both City Hotel and Resort Hotel, the revenue values increased from 2018 to 2019 and then decreased in 2020.
----
2. Should We Increase Our Parking Lot Size?
To determine if there's a need to expand the parking lot, we analyze the proportion of guests who required parking space.
```sql
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
```
  - This query calculates the total number of parking spaces requested each year and the percentage of bookings that included a parking space request.
---
![image](https://github.com/user-attachments/assets/0902a34f-5b18-4ed3-b97d-6ed6249ee554)

---
  - We can observe that we have enough space for parking. So, there is no need to increase our parking lot size.
----

### Prepiration for power bi
Before moving to Power BI, we need to preprocess some columns. Using SQL, we will perform two left join queries on the data.

```sql
with hotels as (
select* from dbo.['2018$']
union
select * from dbo.['2019$']
union
select* from dbo.['2020$'] ) 

select * from hotels
left join dbo.market_segment$
on hotels.market_segment=market_segment$.market_segment
left join dbo.meal_cost$
on meal_cost$.meal=hotels.meal
```

---

## 📊 Power BI Analysis  

3. What trends can we see in the data?

We have created some visuals using Power BI that show some possible trends. Here are a few of them:

  - Revenue increased from 2018 to 2019, but it began to decrease from 2019 to 2020.
  - The average daily rate (ADR) has increased from 2019 to 2020, from $99.53 to $104.47.
  - Total number of nights booked by customers decreased from 2019 to 2020.
  - The discount percentage offered by the hotel has increased from 2019 to 2020 to attract more customers.

---
![image](https://github.com/user-attachments/assets/33244e7f-f9f3-475e-b3b4-fb6fb19b48c2)
  

---

## 📉 Results  
- Revenue Fluctuations: Revenue experienced growth from 2018 to 2019 but saw a decline in 2020. Despite this, the average daily rate (ADR) increased from $99.53 in 2019 to $104.47 in 2020, suggesting a pricing adjustment strategy.
- Booking & Discount Trends: The total nights booked dropped in 2020, prompting the hotel to increase discount offerings in an attempt to attract more guests.
- Parking Demand: Analysis shows that the current parking capacity is sufficient, indicating no immediate need for expansion.

---

## 📢 Recommendations  
- Revenue Strategy: To counter declining revenue, introduce targeted promotions and dynamic pricing strategies, especially during off-peak seasons.
- Customer Retention: Enhance customer engagement with loyalty programs and personalized offers to encourage repeat bookings.
- Operational Efficiency: Maintain the current parking lot size but continue monitoring usage trends to ensure future capacity aligns with demand.
  

---


