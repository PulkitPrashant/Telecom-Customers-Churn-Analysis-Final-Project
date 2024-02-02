CREATE SCHEMA `guvi_project_17_18` ;
USE guvi_project_17_18;
SELECT * from customer_churn_dataset;


# 1.	Identify the total number of customers and the churn rate
select* from customer_churn;
select
   count(*) as totalcustomers,
   sum(CASE when churn_status='Yes' then 1 else 0 end) as churnedcustomers,
   ((sum(case when churn_status='Yes' then 1 else 0 end)/count(*))*100) as churnrate
from customer_churn; # Total customers are 500 and 105 are churned customers and 21% is the churnrate



# 2.	Find the average age of churned customers
SELECT 
   AVG(Age) as averageage
from customer_churn
WHERE churn_status='Yes'; # Average age is 50.89


# 3.	Discover the most common contract types among churned customers
SELECT
  Contract_type, count(*) as count
from customer_churn
Where churn_status='Yes'
group by contract_type
order by count DESC; #  Monthly=56 and Yearly=49



# 4.	Analyze the distribution of monthly charges among churned customers
select
    Churn_status,
    Avg(Monthly_Charges) as avgmonthly,
    MIN(Monthly_Charges) as minmonthly,
    Max(Monthly_Charges) as Maxmonthly
FROM customer_churn
Group by churn_status;



# 5.	Create a query to identify the contract types that are most prone to churn
SELECT
  Contract_type, count(*) as count
from customer_churn
Where churn_status='Yes'
group by contract_type
order by count DESC; #  Monthly=56 and Yearly=49




# 6.	Identify customers with high total charges who have churned
SELECT
   Customer_ID,total_charges
FROM customer_churn
WHERE churn_status='Yes' and Total_charges>
                                       (Select Avg(Total_charges) 
                                       from customer_churn)
order by total_charges DESC;



# 7.	Calculate the total charges distribution for churned and non-churned customers
select
    Churn_status,
    Avg(Total_Charges) as avgtotal,
    MIN(Total_Charges) as mintotal,
    Max(Total_Charges) as Maxtotal
FROM customer_churn
Group by churn_status;


# 8.	Calculate the average monthly charges for different contract types among churned customers

SELECT
     contract_type, AVG(Monthly_charges) as avgmonthly
from customer_churn
Where churn_status='Yes'
group by contract_type;


# 9.	Identify customers who have both online security and online backup services and have not churned
SELECT customer_id, Gender,age,Monthly_charges
FROM customer_churn
WHERE churn_status='Yes' and online_security='Yes' and online_backup='Yes';


# 10.	Determine the most common combinations of services among churned customers
select
  concat_ws(',',online_security, online_backup,device_protection,tech_support)as servicecombo, count(*) as churnedcustomer
From customer_churn
Where churn_status='Yes'
group by servicecombo
order by churnedcustomer DESC;


# 11.	Identify the average total charges for customers grouped by gender and marital status
SELECT gender, marital_status, Avg(Total_charges) as totalcharg
from customer_churn
group by gender, marital_status;


# 12.	Calculate the average monthly charges for different age groups among churned customers
select
  case
    when age<30 then 'Under 30'
    when age>=30 AND age<60 then '30-59'
    else '60 and above'
    end as agegroup,
    avg(Monthly_charges) as avgmonthlycharges
from customer_churn
where churn_status='Yes'
Group by agegroup;


# 13.	Determine the average age and total charges for customers with multiple lines and online backup
select 
    multiple_lines, 
    online_backup, 
    avg(age) as avgage, 
    avg(total_charges) as avgtotalcharges
from customer_churn
group by multiple_lines, online_backup;


# 14.	Identify the contract types with the highest churn rate among senior citizens (age 65 and over)

select
 contract_type,
 count(*) as churnedcustomer,
 (count(*)/(select count(*) from customer_churn where age>65))*100 as churnrate,
 Avg(total_charges)
from customer_churn
where churn_status='Yes' and age>65
group by contract_type
order by churnrate DESC ;



# 16.	Identify the customers who have churned and used the most online services
SELECT
   customer_id, gender, age,
   (CASE 
       when online_security='Yes' then 1 else 0 end +
       case when online_backup='Yes'then 1 else 0 end+
       case when device_protection='Yes' then 1 else 0 end+
       case when tech_support='Yes' then 1 else 0 end ) as Totalonlineservices
from customer_churn
where churn_status='NO'
order by Totalonlineservices DESC
limit 25;



# 17.	Calculate the average age and total charges for customers with different combinations of streaming services

select 
     
    avg(age) as avgage, 
    avg(total_charges) as avgtotalcharges
from customer_churn
group by multiple_lines, online_backup;
