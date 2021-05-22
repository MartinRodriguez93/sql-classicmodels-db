use classicmodels_db;

#PAYMENTS TABLE:

#Avg payments amount: '32431.645531'
select avg(`amount`)
from `payments`;

#Avg payments amount per customerNumber classified:
select `customerNumber`,
		avg(`amount`) as avg_payment,
		case when avg(`amount`)>(select avg(`amount`)
								 from `payments`) then "Above avg"
			 else "Below avg"
			 end as `AvgClassification` 
from `payments`
group by `customerNumber`
order by avg(`amount`) desc;

#Number, amount and avg of payments per year:
select YEAR(`paymentDate`) as paymentYear,
	   COUNT(`paymentDate`) as paymentCount,
       format(sum(`amount`),0) as paymentAmount,
       format((sum(`amount`)/COUNT(`paymentDate`)),0) as avg_paymentAmount
from `payments`
GROUP BY YEAR(`paymentDate`)
ORDER BY YEAR(`paymentDate`);

#Monthly number of payments per year: 2005 only six months
select YEAR(`paymentDate`) as paymentYear,
	   MONTH(`paymentDate`) as paymentMonth,
	   COUNT(`paymentDate`) as paymentCount,
       format(sum(`amount`),0) as paymentTotals,
       format((sum(`amount`)/COUNT(`paymentDate`)),0) as avg_paymentAmount
from `payments`
GROUP BY YEAR(`paymentDate`), MONTH(`paymentDate`) 
ORDER BY YEAR(`paymentDate`);

#ORDERS AND ORDERDETAILS TABLES

#Unique orderNumber in orders: 326
select count(distinct(o.orderNumber))
from orders o;

#Unique orderNumber in orderdetails: 326
select count(distinct(od.orderNumber))
from orderdetails od;

#Total quantity and amount per orderNumber and orderDate:
select o.orderDate,
	   o.orderNumber,
	   b.total_quantity,
       b.amount_product
from orders o
join 
	 #Total quantity and amount per orderNumber:
     (select od.orderNumber, 
			 SUM(od.quantityOrdered) as total_quantity,
			 SUM((od.quantityOrdered*od.priceEach)) as amount_product
	  from orderdetails od
	  group by od.orderNumber) b on o.orderNumber=b.orderNumber;
      
#Total order quantity and amount per year:
select YEAR(o.orderDate) as orderYear,
       count(b.orderNumber) as order_number,
	   format(sum(b.total_quantity),0) as order_quantity,
       format(sum(b.amount_product),0) as order_amount
from orders o
join 
	 #Total order quantity and amount per orderNumber:
     (select od.orderNumber, 
			 SUM(od.quantityOrdered) as total_quantity,
			 SUM((od.quantityOrdered*od.priceEach)) as amount_product
	  from orderdetails od
	  group by od.orderNumber) b on o.orderNumber=b.orderNumber
group by YEAR(o.orderDate);

#Quantity, amount and avg of payments and orders per year:
select YEAR(`paymentDate`) as year_of_trx,
	   COUNT(`paymentDate`) as number_of_payments,
       format(sum(`amount`),0) as payment_amount,
       format((sum(`amount`)/COUNT(`paymentDate`)),0) as avg_per_payment,
       c.number_of_orders as number_of_orders,
       format(c.order_amount,0) as order_amount,
       c.avg_order as avg_per_order,
       format(c.quantity_per_order,0) as quantity_per_order,
       format(c.order_amount-sum(`amount`),0) as pending_payments
from `payments`
join
    #Total order quantity and amount per year: 
	(select YEAR(o.orderDate) as orderYear,
			count(b.orderNumber) as number_of_orders,
			sum(b.total_quantity) as quantity_per_order,
			sum(b.amount_product) as order_amount,
            format((sum(b.amount_product)/count(b.orderNumber)),0) as avg_order
	 from orders o
	 join 
	     #Total order quantity and amount per orderNumber:
			 (select od.orderNumber, 
					 SUM(od.quantityOrdered) as total_quantity,
					 SUM((od.quantityOrdered*od.priceEach)) as amount_product
			  from orderdetails od
			  group by od.orderNumber) b on o.orderNumber=b.orderNumber
	 group by YEAR(o.orderDate)) as c on YEAR(`paymentDate`)=c.orderYear 
GROUP BY YEAR(`paymentDate`), c.orderYear 
ORDER BY YEAR(`paymentDate`);
