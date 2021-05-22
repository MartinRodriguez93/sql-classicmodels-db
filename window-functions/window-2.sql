#Payments per customerNumber and country % over total country payments:
select c.customerNumber,
	   c.country,
       format(sum(p.amount),0) as payment_amount,
       sum(sum(p.amount)) over (partition by c.country) as total_country_payment,
	   sum(p.amount)/ sum(sum(p.amount)) over (partition by c.country) as perc_over_total
from customers c
inner join payments p on c.customerNumber=p.customerNumber
group by p.customerNumber, c.country
order by country, perc_over_total desc;
