/*
Name : Ajay Chauhan
Project : Coffee Sales 
Date : 15-08-2025
*/
------------------------------------------------------------------------
------------------------------------------------------------------------

use Pr_Coffee

------------------------------------------------------------------------
------------------------------------------------------------------------
select 
	Round(SUM(transaction_qty * unit_price),0) as Total_sales	-- total_sales
from Coffee

------------------------------------------------------------------------
select 
	concat(round(SUM(transaction_qty * unit_price),0)/1000,' K') as Total_May_Sales
	from Coffee
where MONTH(transaction_date) = 5 -- total_sales for MAY = 5

------------------------------------------------------------------------
--TOTAL SALES KPI - MOM DIFFERENCE AND MOM GROWTH

	with MonthlySales
	as
		(
select
	MONTH(transaction_date) as MonthNumber,
	SUM(transaction_qty * unit_price ) as Total_sales
	from
		Coffee
			where 
					MONTH(transaction_date) in (4,5)
			group by 
					MONTH(transaction_date)
		)

			select 
				MonthNumber ,
				Total_sales,
				ROUND(
				Case
				when LAG(Total_sales) over(order by MonthNumber) is null then NULL
						ELSE 
						((Total_sales - LAG(Total_sales) OVER (ORDER BY monthnumber)) /
						cast (lag(total_sales) over(order by monthnumber) as float )) * 100
						END ,2) as MOM_sales_increase
				from 
					MonthlySales
------------------------------------------------------------------------
--TOTAL ORDERS for May month 

select count(transaction_id) as Count_Order
from Coffee
where month(transaction_date) = 5 -- count no of orders for May Month 

------------------------------------------------------------------------
--TOTAL ORDERS KPI - MOM DIFFERENCE AND MOM GROWTH

with MonthlyOrders
AS
(
select 
	MONTH(transaction_date) as MonthNumber,
	COUNT(transaction_id) as Total_orders
	from
		Coffee
		where	
			 MONTH(transaction_date) in(4,5)
		group by 
				MONTH(transaction_date)
					 )
select
	MonthNumber ,	
	Total_orders,
	ROUND(
	case
		when LAG(Total_orders) over(order by MonthNumber) is NULL THEN NULL 
		else
			((Total_orders - LAG(Total_orders) over (order by MonthNumber)) /
			cast(lag(Total_orders) over(order by monthNumber) as float)) * 100 
			END ,2
			) as MOM_sales_increase
		from
		MonthlyOrders

------------------------------------------------------------------------

--TOTAL qnantity sold for May month 

select sum(transaction_qty) as Total_qnt_sold
from Coffee
where month(transaction_date) = 5 -- count no of orders for May Month 

------------------------------------------------------------------------
--TOTAL QUANTITY SOLD KPI - MOM DIFFERENCE AND MOM GROWTH

	With QuantityOrders
	As
	(
select 
	  MONTH(transaction_date) as MonthNumber,
      round(SUM(transaction_qty),2) as Total_sales
		from 
			Coffee
				where MONTH(transaction_date) in (4,5)
				group by MONTH(transaction_date)
				)

				select 
						MonthNumber ,
						Total_sales,
						ROUND(
									case
										when LAG(Total_sales) over(order by monthnumber) is null then Null
										ELSE 
											((Total_sales - LaG(Total_sales) over (order by MonthNumber)) /
											cast(LAG(Total_sales) over(order by MonthNumber) as float)) * 100
											END ,2) as mom_increase_percentage
					from 
					QuantityOrders

------------------------------------------------------------------------
 